#!/system/bin/sh
MODDIR=${0%/*}
. "$MODDIR/config"

set_desc() {
	sed -i "s|^description=.*|description=$1|" "$MODDIR/module.prop"
}

until [ "$(getprop sys.boot_completed)" = 1 ]; do sleep 1; done
until [ -d "/sdcard/Android" ]; do sleep 1; done
while
	BASEPATH=$(pm path "$PKG_NAME" 2>&1 </dev/null)
	SVCL=$?
	[ $SVCL = 20 ]
do sleep 2; done

if [ $SVCL != 0 ]; then
	set_desc "⚠️ Needs reflash: 'app not installed'"
	exit 0
fi

VERSION=$(dumpsys package "$PKG_NAME" 2>&1 | grep -m1 versionName)
VERSION=${VERSION#*=}
if [ -n "$VERSION" ] && [ "$VERSION" != "$PKG_VER" ]; then
	set_desc "⚠️ Needs reflash: 'version mismatch (installed:$VERSION, module:$PKG_VER)'"
	exit 0
fi

build_procs_map() {
	mkdir -p /data/adb/rvhc
	PM=/data/adb/rvhc/procs_map
	TMP="${PM}.tmp"
	: >"$TMP"
	for m in /data/adb/modules/*; do
		[ -d "$m" ] || continue
		[ -f "$m/disable" ] && continue
		[ -f "$m/config" ] || continue
		[ -d "$m/zygisk" ] || continue
		(
			# shellcheck disable=SC1091
			. "$m/config"
			[ -z "${PKG_NAME:-}" ] && exit 0
			BP=$(pm path "$PKG_NAME" 2>/dev/null </dev/null) || exit 0
			BP=${BP##*:}
			RV="/data/adb/rvhc/${m##*/}.apk"
			[ -f "$RV" ] || exit 0
			chcon u:object_r:apk_data_file:s0 "$RV" 2>/dev/null
			for s in "$PKG_NAME" "$RV" "$BP"; do
				printf '%b%s\0' "\\x$(printf '%02x' "${#s}")" "$s" >>"$TMP"
			done
		)
	done
	printf '\0' >>"$TMP"
	mv -f "$TMP" "$PM"
	chmod 644 "$PM"
}

# clean stale bind mounts left by older versions
grep -F "$PKG_NAME" /proc/self/mounts 2>/dev/null | while read -r line; do
	mp=${line#* } mp=${mp%% *}
	[ "${mp#/data/app/}" != "$mp" ] && umount -l "${mp%%\\*}" 2>/dev/null
done

build_procs_map
am force-stop "$PKG_NAME"

if [ -s /data/adb/rvhc/procs_map ]; then
	set_desc "YouTube ReVanced Zygisk v$PKG_VER"
else
	set_desc "⚠️ procs_map empty - install ZygiskNext or check logs"
fi
