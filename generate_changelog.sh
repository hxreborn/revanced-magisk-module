#!/usr/bin/env bash
# Generate Anddea changelog from conventional commits between releases

set -euo pipefail

PATCHES_VERSION="${1:-}"
OUTPUT_FILE="${2:-build.md}"

# Configuration
REPO="${CHANGELOG_REPO:-anddea/revanced-patches}"
GH_API="https://api.github.com"
RELEASE_LIMIT="${CHANGELOG_RELEASE_LIMIT:-50}"

if [ -z "$PATCHES_VERSION" ]; then
  echo "Usage: $0 <patches_version> [output_file]" >&2
  exit 1
fi

# Normalize version ()
[[ $PATCHES_VERSION != v* ]] && PATCHES_VERSION="v$PATCHES_VERSION"

# Setup auth header if token available
CURL_AUTH=()
if [[ -n "${GITHUB_TOKEN:-}" ]]; then
  CURL_AUTH=(-H "Authorization: Bearer $GITHUB_TOKEN")
fi

# Fetch releases
RELEASES=$(curl -fsSL "${CURL_AUTH[@]}" \
  "$GH_API/repos/$REPO/releases?per_page=$RELEASE_LIMIT") || {
  echo "Warning: GitHub API request failed, skipping changelog" >&2
  exit 0
}

if [ -z "$RELEASES" ] || [ "$RELEASES" = "[]" ]; then
  echo "Warning: No releases found, skipping changelog" >&2
  exit 0
fi

# Verify current version exists in releases
if ! echo "$RELEASES" | jq -e --arg v "$PATCHES_VERSION" '.[] | select(.tag_name == $v)' >/dev/null 2>&1; then
  echo "Warning: Release ${PATCHES_VERSION} not found in GitHub releases, skipping changelog" >&2
  exit 0
fi

# Get previous release by date (dev→dev, stable→stable)
if [[ $PATCHES_VERSION == *-dev* ]]; then
  PREV_TAG=$(echo "$RELEASES" | jq -r --arg v "$PATCHES_VERSION" '
    .[] | select(.prerelease == true) |
    select(.tag_name != $v) |
    .tag_name' | head -1)
else
  PREV_TAG=$(echo "$RELEASES" | jq -r --arg v "$PATCHES_VERSION" '
    .[] | select(.prerelease == false) |
    select(.tag_name != $v) |
    .tag_name' | head -1)
fi

if [ -z "$PREV_TAG" ]; then
  echo "Warning: Could not determine previous release" >&2
  exit 0
fi

# Fetch commits
COMMIT_DATA=$(curl -fsSL "${CURL_AUTH[@]}" \
  "$GH_API/repos/$REPO/compare/${PREV_TAG}...${PATCHES_VERSION}" |
  jq -r '.commits[]? | "\(.sha[0:7])␞\(.commit.message | split("\n") | .[0])"' 2>/dev/null) || {
  echo "Warning: Could not fetch commits" >&2
  exit 0
}

if [ -z "$COMMIT_DATA" ]; then
  echo "Warning: No commits found between releases" >&2
  exit 0
fi

# Append formatted changelog to output file
{
  echo "## 🛠️ Patch Update"
  echo ""

  # URL-encode version for shields.io badge ()
  BADGE_VERSION="${PATCHES_VERSION//-/--}"
  echo "[![Release](https://img.shields.io/badge/Release_Notes-${BADGE_VERSION}-blue?style=for-the-badge&logo=github)](https://github.com/$REPO/releases/tag/${PATCHES_VERSION})"
  echo ""

  # Categorized commit arrays
  declare -a features=()
  declare -a fixes=()
  declare -a performance=()
  declare -a refactors=()
  declare -a chores=()

  # Conventional Commit patterns
  pattern_scope='^([a-z]+)!?\(([^)]+)\):[ ](.+)$'
  pattern_no_scope='^([a-z]+)!?:[ ](.+)$'

  while IFS='␞' read -r sha msg; do
    [ -z "$sha" ] && continue

    commit_link="[\`${sha}\`](https://github.com/$REPO/commit/${sha})"

    type=""
    scope=""
    text=""

    # Extract type, scope, and message
    if [[ $msg =~ $pattern_scope ]]; then
      type="${BASH_REMATCH[1]}"
      scope="${BASH_REMATCH[2]}"
      text="${BASH_REMATCH[3]}"
    elif [[ $msg =~ $pattern_no_scope ]]; then
      type="${BASH_REMATCH[1]}"
      text="${BASH_REMATCH[2]}"
    fi

    # Skip if no type matched or not in allowed list
    [[ ! "$type" =~ ^(feat|fix|perf|refactor|chore)$ ]] && continue

    # Skip release commits
    [[ "$text" =~ ^[Rr]elease ]] && [[ "$text" =~ \[skip.?ci\] ]] && continue

    # Build entry
    if [ -n "$scope" ]; then
      entry="- **${scope}:** ${text} ${commit_link}"
    else
      entry="- ${text} ${commit_link}"
    fi

    # Categorize by type
    case "$type" in
    feat)
      features+=("$entry")
      ;;
    fix)
      fixes+=("$entry")
      ;;
    perf)
      performance+=("$entry")
      ;;
    refactor)
      refactors+=("$entry")
      ;;
    chore)
      chores+=("$entry")
      ;;
    esac
  done <<<"$COMMIT_DATA"

  # Show "No changes" if all categories are empty
  total_changes=$((${#features[@]} + ${#fixes[@]} + ${#performance[@]} + ${#refactors[@]} + ${#chores[@]}))

  if ((total_changes == 0)); then
    echo "No user-facing changes in this update."
    echo ""
  else
    # Output each category that has content
    if ((${#features[@]} > 0)); then
      echo "### ✨ Features"
      echo ""
      printf '%s\n' "${features[@]}"
      echo ""
    fi

    if ((${#fixes[@]} > 0)); then
      echo "### 🐛 Bug Fixes"
      echo ""
      printf '%s\n' "${fixes[@]}"
      echo ""
    fi

    if ((${#performance[@]} > 0)); then
      echo "### ⚡ Performance"
      echo ""
      printf '%s\n' "${performance[@]}"
      echo ""
    fi

    if ((${#refactors[@]} > 0)); then
      echo "### ♻️ Refactor"
      echo ""
      printf '%s\n' "${refactors[@]}"
      echo ""
    fi

    if ((${#chores[@]} > 0)); then
      echo "### 🔧 Maintenance"
      echo ""
      printf '%s\n' "${chores[@]}"
      echo ""
    fi
  fi
} >>"$OUTPUT_FILE"
