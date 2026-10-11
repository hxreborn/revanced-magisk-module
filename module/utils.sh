#!/system/bin/sh

RVPATH=/data/adb/rvhc/${MODDIR##*/}.apk
. "$MODDIR/config"

ch_desc() {
	sed -i "s|^description=.*|description=${1}|" "$MODDIR/module.prop"
}

ch_desc_err() {
	ch_desc "⚠️ Needs reflash: '${1}'"
}

pmex() {
	OP=$(pm "$@" 2>&1 </dev/null)
	RET=$?
	echo "$OP"
	return $RET
}

get_app_version() {
	VERSION=$(dumpsys package "$PKG_NAME" 2>&1 | grep -m1 versionName=) VERSION="${VERSION#*=}"
	echo "$VERSION"
}

get_basepath() {
	BASEPATH=$(pmex path "$PKG_NAME")
	SVCL=$?

	BASEPATH=${BASEPATH##*:} BASEPATH=${BASEPATH%/*}
	echo "$BASEPATH"
	return $SVCL
}

umount_all() {
	su -M -c grep -F "$PKG_NAME" /proc/mounts | while read -r line; do
		mp=${line#* } mp=${mp%% *} mp=${mp%%\\*}
		su -M -c umount -l "${mp}"
	done
	am force-stop "$PKG_NAME" || :
}

get_mounts() {
	su -M -c grep -F "$PKG_NAME" /proc/mounts || :
}

mount_rv() {
	if [ ! -d "${1}/lib" ]; then
		ch_desc_err "Your installation got broken. Dont report this, consider using rvmm-zygisk-mount."
		return 1
	fi
	VERSION=$(get_app_version)
	if [ "$VERSION" != "$PKG_VER" ] && [ "$VERSION" ]; then
		ch_desc_err "Version mismatch (installed:$VERSION, module:$PKG_VER)"
		return 1
	fi
	umount_all
	if ! OP=$(chcon u:object_r:apk_data_file:s0 "$RVPATH" 2>&1); then
		ch_desc_err "Error chcon: '$OP'"
		return 1
	fi
	mount -o bind "$RVPATH" "${1}/base.apk"
	am force-stop "$PKG_NAME"
	cp -f "$MODDIR/module.prop.orig" "$MODDIR/module.prop"
	return 0
}

mount_rv_now() {
	if ! BASEPATH=$(get_basepath); then
		ch_desc_err "App not installed: '$BASEPATH'"
		return 1
	fi
	mount_rv "$BASEPATH"
}

set_bool_prefs() {
	local file=$1 defaults=$2 key value content
	content=$(sed 's|<map />|<map>\n</map>|' "$file")
	while IFS='=' read -r key value; do
		case "$key" in '' | *[!A-Za-z0-9_]*) continue ;; esac
		case "$value" in true | false) ;; *) continue ;; esac
		content=$(printf '%s\n' "$content" | sed "/<boolean name=\"$key\" /d; s|</map>|<boolean name=\"$key\" value=\"$value\" />\n</map>|")
	done <"$defaults"
	printf '%s\n' "$content" >"$file"
}

seed_prefs() {
	[ -s "$MODDIR/prefs.default" ] || return 0
	local sum marker dir file uid
	sum=$(cksum <"$MODDIR/prefs.default")
	marker=/data/adb/rvhc/${MODDIR##*/}.prefs
	[ "$(cat "$marker" 2>/dev/null)" = "$sum" ] && return 0
	uid=$(stat -c %u "/data/data/$PKG_NAME") || return 1
	dir=/data/data/$PKG_NAME/shared_prefs
	file=$dir/morphe_prefs.xml
	if [ ! -d "$dir" ]; then
		mkdir -p "$dir" && chown "$uid:$uid" "$dir" && chmod 771 "$dir" && restorecon "$dir" || return 1
	fi
	if [ ! -f "$file" ]; then
		printf "<?xml version='1.0' encoding='utf-8' standalone='yes' ?>\n<map>\n</map>\n" >"$file"
		chown "$uid:$uid" "$file" && chmod 660 "$file" && restorecon "$file" || return 1
	fi
	set_bool_prefs "$file" "$MODDIR/prefs.default" && echo "$sum" >"$marker"
}
