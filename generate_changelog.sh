#!/usr/bin/env bash
# Generate Anddea changelog from conventional commits between releases

set -euo pipefail

PATCHES_VERSION="${1:-}"
OUTPUT_FILE="${2:-build.md}"

if [ -z "$PATCHES_VERSION" ]; then
    echo "Usage: $0 <patches_version> [output_file]" >&2
    exit 1
fi

# Normalize version (add 'v' prefix)
[[ $PATCHES_VERSION != v* ]] && PATCHES_VERSION="v$PATCHES_VERSION"

# Fetch releases, filter by prerelease status
RELEASES=$(curl -sL "https://api.github.com/repos/anddea/revanced-patches/releases?per_page=10" 2>/dev/null || :)

if [ -z "$RELEASES" ]; then
    echo "Warning: Could not fetch releases, skipping changelog" >&2
    exit 0
fi

# Verify current version exists in releases
CURRENT_EXISTS=$(echo "$RELEASES" | jq -r '.[].tag_name' | grep -x "$PATCHES_VERSION" || :)
if [ -z "$CURRENT_EXISTS" ]; then
    echo "Warning: Release ${PATCHES_VERSION} not found in GitHub releases, skipping changelog" >&2
    exit 0
fi

# Get previous dev release (dev→dev, stable→stable)
if [[ $PATCHES_VERSION == *-dev* ]]; then
    PREV_TAG=$(echo "$RELEASES" | jq -r '.[] | select(.prerelease == true) | .tag_name' | grep -v "^${PATCHES_VERSION}$" | head -1)
else
    PREV_TAG=$(echo "$RELEASES" | jq -r '.[] | select(.prerelease == false) | .tag_name' | grep -v "^${PATCHES_VERSION}$" | head -1)
fi

if [ -z "$PREV_TAG" ]; then
    echo "Warning: Could not determine previous release" >&2
    exit 0
fi

# Fetch commits with SHA and message
COMMIT_DATA=$(curl -sL "https://api.github.com/repos/anddea/revanced-patches/compare/${PREV_TAG}...${PATCHES_VERSION}" 2>/dev/null | \
    jq -r '.commits[] | "\(.sha[0:7])|\(.commit.message | split("\n") | .[0])"' 2>/dev/null || :)

if [ -z "$COMMIT_DATA" ]; then
    echo "Warning: Could not fetch commits" >&2
    exit 0
fi

# Append formatted changelog to output file
{
    echo "## 🛠️ Patch Update"
    echo ""

    # URL-encode version for shields.io badge (dashes need to be doubled)
    BADGE_VERSION="${PATCHES_VERSION//-/--}"
    echo "[![Release](https://img.shields.io/badge/Release_Notes-${BADGE_VERSION}-blue?style=for-the-badge&logo=github)](https://github.com/anddea/revanced-patches/releases/tag/${PATCHES_VERSION})"
    echo ""

    # Process commits and categorize by type
    features=""
    fixes=""
    performance=""
    refactors=""
    chores=""

    # Regex patterns stored in variables to avoid parsing issues
    pattern_scope='^([a-z]+)[(]([^)]+)[)]:[ ](.+)$'
    pattern_no_scope='^([a-z]+):[ ](.+)$'

    while IFS='|' read -r sha msg; do
        commit_link="[\`${sha}\`](https://github.com/anddea/revanced-patches/commit/${sha})"

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

        # Skip if no type matched or exclude build/ci/docs/style/test
        [[ ! "$type" =~ ^(feat|fix|perf|refactor|chore)$ ]] && continue

        # Skip release commits
        [[ "$text" =~ ^Release.*\[skip\ ci\] ]] && continue

        # Format commit entry without badges
        if [ -n "$scope" ]; then
            entry="- **${scope}:** ${text} ${commit_link}\n"
        else
            entry="- ${text} ${commit_link}\n"
        fi

        # Categorize by type
        case "$type" in
            feat)
                features="${features}${entry}"
                ;;
            fix)
                fixes="${fixes}${entry}"
                ;;
            perf)
                performance="${performance}${entry}"
                ;;
            refactor)
                refactors="${refactors}${entry}"
                ;;
            chore)
                chores="${chores}${entry}"
                ;;
        esac
    done <<< "$COMMIT_DATA"

    # Show "No changes" if all categories are empty
    if [ -z "$features" ] && [ -z "$fixes" ] && [ -z "$performance" ] && [ -z "$refactors" ] && [ -z "$chores" ]; then
        echo "No user-facing changes in this update."
        echo ""
    else
        # Show each category that has content
        if [ -n "$features" ]; then
            echo "### ✨ Features"
            echo ""
            echo -e "$features"
        fi

        if [ -n "$fixes" ]; then
            echo "### 🐛 Bug Fixes"
            echo ""
            echo -e "$fixes"
        fi

        if [ -n "$performance" ]; then
            echo "### ⚡ Performance"
            echo ""
            echo -e "$performance"
        fi

        if [ -n "$refactors" ]; then
            echo "### ♻️ Refactor"
            echo ""
            echo -e "$refactors"
        fi

        if [ -n "$chores" ]; then
            echo "### 🔧 Maintenance"
            echo ""
            echo -e "$chores"
        fi
    fi
} >> "$OUTPUT_FILE"
