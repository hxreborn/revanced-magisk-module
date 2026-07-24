#!/system/bin/sh
MODDIR="$(dirname "$(readlink -f "$0")")"
export MODDIR
. "$MODDIR/utils.sh"

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

until [ "$(getprop sys.boot_completed)" = 1 ]; do sleep 1; done
until [ -d "/sdcard/Android" ]; do sleep 1; done
while
	BASEPATH=$(get_basepath)
	SVCL=$?
	[ $SVCL = 20 ]
do sleep 2; done

if [ $SVCL != 0 ]; then
	ch_desc_err "App not installed: '$BASEPATH'"
	exit 0
fi

VERSION=$(get_app_version)
if [ "$VERSION" ] && [ "$VERSION" != "$PKG_VER" ]; then
	ch_desc_err "Version mismatch (installed:$VERSION, module:$PKG_VER)"
	exit 0
fi

# stale bind mounts left by pre-zygisk versions
umount_all

build_procs_map

if [ -s /data/adb/rvhc/procs_map ]; then
	ch_desc "YouTube ReVanced Zygisk v$PKG_VER"
else
	ch_desc_err "procs_map empty - install ZygiskNext or check logs"
fi
