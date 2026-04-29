# YouTube ReVanced Zygisk

[![CI](https://github.com/hxreborn/revanced-magisk-module/actions/workflows/ci.yml/badge.svg?event=schedule)](https://github.com/hxreborn/revanced-magisk-module/actions/workflows/ci.yml)
[![Releases](https://img.shields.io/github/release-date/hxreborn/revanced-magisk-module?label=Latest%20Build)](https://github.com/hxreborn/revanced-magisk-module/releases/latest)

Automated builds of patched YouTube using official [ReVanced patches](https://gitlab.com/ReVanced/revanced-patches), packaged as a Magisk/KernelSU module for `arm64-v8a`. Patched APK is mounted via Zygisk at app launch.

## Downloads

[**Latest Release**](https://github.com/hxreborn/revanced-magisk-module/releases/latest)

> [!NOTE]
> Use [zygisk-detach](https://github.com/j-hc/zygisk-detach) to detach YouTube from the Play Store to prevent auto-updates overwriting the patched version.

## Credits

- [ReVanced](https://gitlab.com/ReVanced): Patches and CLI
- [j-hc/revanced-magisk-module](https://github.com/j-hc/revanced-magisk-module): Build pipeline template
- [j-hc/rvmm-zygisk-mount](https://github.com/j-hc/rvmm-zygisk-mount): Zygisk companion mount implementation

## License

GPL-3.0 — see [LICENSE](LICENSE).
