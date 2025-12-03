# ReVanced Magisk Module

[![CI](https://github.com/hxreborn/revanced-magisk-module/actions/workflows/ci.yml/badge.svg?event=schedule)](https://github.com/hxreborn/revanced-magisk-module/actions/workflows/ci.yml)
[![Releases](https://img.shields.io/github/release-date/hxreborn/revanced-magisk-module?label=Latest%20Build)](https://github.com/hxreborn/revanced-magisk-module/releases/latest)
[![License](https://img.shields.io/github/license/hxreborn/revanced-magisk-module)](LICENSE)

Automated builds using **[Anddea's RVX patches](https://github.com/anddea/revanced-patches)**.
Supports `arm64-v8a` architecture and include both Non-Root (APK) and Root (Magisk Module) variants.

## Supported Apps

| App Icon | Application | Package Name | Patch Source |
| :---: | :--- | :--- | :---: |
| <img src="https://www.gstatic.com/youtube/img/branding/favicon/favicon_144x144.png" width="36"/> | **YouTube**<br><sub>RVX Extended</sub> | `com.google.android.youtube` | [![Anddea](https://img.shields.io/badge/RVX-Anddea-8a2be2?style=flat-square)](https://github.com/anddea/revanced-patches) |
| <img src="https://music.youtube.com/img/favicon_144.png" width="36"/> | **YouTube Music**<br><sub>RVX Extended</sub> | `com.google.android.apps.youtube.music` | [![Anddea](https://img.shields.io/badge/RVX-Anddea-8a2be2?style=flat-square)](https://github.com/anddea/revanced-patches) |

> **Documentation:** [View unique features and patch details](https://github.com/anddea/revanced-patches/wiki/Unique-features)

> [!NOTE]
> * **Non-Root:** You must install **[GmsCore (MicroG)](https://github.com/ReVanced/GmsCore/releases)** to use these APKs.
> * **Root:** Use **[zygisk-detach](https://github.com/j-hc/zygisk-detach)** to detach YouTube/Music from the Play Store.

## Downloads

[**Get the Latest Release**](https://github.com/hxreborn/revanced-magisk-module/releases/latest)


## Credits

- **[ReVanced](https://github.com/ReVanced)**: Original patches and ecosystem
- **[anddea/revanced-patches](https://github.com/anddea/revanced-patches)**: RVX Extended patches
- **[inotia00/revanced-cli](https://github.com/inotia00/revanced-cli)**: CLI tool
- **[j-hc/revanced-magisk-module](https://github.com/j-hc/revanced-magisk-module)**: Build template
- **[j-hc/zygisk-detach](https://github.com/j-hc/zygisk-detach)**: Play Store detach module

---

## License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details.