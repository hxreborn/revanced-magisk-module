YouTube: 21.16.256  
Patches: 95 applied, 7 not applied  
Not applied: Change installer source, Clone app, Disable Play Store updates, GmsCore support, Network proxy, Override certificate pinning, Spoof signature  

> Requires Zygisk
  
Patches: MorpheApp/patches-1.47.0.mpp  
[Changelog](https://github.com/MorpheApp/morphe-patches/releases/tag/v1.47.0)

CLI: MorpheApp/morphe-desktop-1.18.1-all.jar    
  
## [1.47.0](https://github.com/MorpheApp/morphe-patches/compare/v1.46.0...v1.47.0) (2026-10-11)

### 🐛 Bug Fixes

* **Custom branding:** Use the branded notification icon for playback notifications of mounted installs ([90210ad](https://github.com/MorpheApp/morphe-patches/commit/90210ade0028c1c410c021ba350911cbc212efc4))
* **Settings:** Search hint and tips ignore the Morphe language override ([a532649](https://github.com/MorpheApp/morphe-patches/commit/a5326492f7bd7ae8b1228a1f6603716c002b2433))
* **Spoof video streams:** PoToken generation can stall and show "Failed to generate PoToken" ([#3663](https://github.com/MorpheApp/morphe-patches/issues/3663)) ([32fec71](https://github.com/MorpheApp/morphe-patches/commit/32fec713a9e7e555150b75078d476ddb6a6ba238))
* **Spoof video streams:** Widgets may not play correctly ([#3656](https://github.com/MorpheApp/morphe-patches/issues/3656)) ([a60a3b6](https://github.com/MorpheApp/morphe-patches/commit/a60a3b6725ac8c984e2aa68bd50b3c9358df299f))
* **YouTube - Background playback:** Respect server value of automatic pause and resume flags ([2fa79ef](https://github.com/MorpheApp/morphe-patches/commit/2fa79efa841870b13e18c61e0a54fad057e16b9c))
* **YouTube - Channel search:** Searching again from same channel page may not show channel results ([14ec664](https://github.com/MorpheApp/morphe-patches/commit/14ec664125b49e139d553ec1b55384ecc722a468))
* **YouTube - Force AVC:** Removed VP9 formats with enabled setting ([bb3e3ff](https://github.com/MorpheApp/morphe-patches/commit/bb3e3ff01dc2fcdf7debc4969fb6037b18eefc94))
* **YouTube - Hide layout components:** Hide new type of video labels ([#3641](https://github.com/MorpheApp/morphe-patches/issues/3641)) ([4a7efd1](https://github.com/MorpheApp/morphe-patches/commit/4a7efd1c124c86cc169eb38fd50c311cdec923c7))
* **YouTube - Hide layout components:** History shelf hidden after fullscreen on You tab ([91d9b2d](https://github.com/MorpheApp/morphe-patches/commit/91d9b2daccb9242a02f4fbaa7dcd408a09c5a28a))
* **YouTube - Hide layout components:** Horizontal shelves show again after entering fullscreen ([#3618](https://github.com/MorpheApp/morphe-patches/issues/3618)) ([be4fffa](https://github.com/MorpheApp/morphe-patches/commit/be4fffa02de9d1d9258e148aae4617735c0c244e))
* **YouTube - Hide player flyout menu components:** Add separate Shorts settings for the Captions and Audio Track menus ([963982d](https://github.com/MorpheApp/morphe-patches/commit/963982d54af7c0a10d840e7e940dca29438423d3))
* **YouTube - Legacy player controls:** Autoplay end screen is broken in the miniplayer on 21.36+ ([#3649](https://github.com/MorpheApp/morphe-patches/issues/3649)) ([c3431a3](https://github.com/MorpheApp/morphe-patches/commit/c3431a3476c7d2508308c18d4f7ee8cfdde687ca))
* **YouTube - Miniplayer:** Fixed incorrect check to prevent title/channel name overwriting ([#3576](https://github.com/MorpheApp/morphe-patches/issues/3576)) ([1671904](https://github.com/MorpheApp/morphe-patches/commit/1671904e728a69c3545c2b6e73ea077b8a67d8d4))
* **YouTube - Navigation bar:** Added a setting to disable A/B navigation buttons layout ([2c3f5c8](https://github.com/MorpheApp/morphe-patches/commit/2c3f5c83131eb479c66a28d1a1c0ffbc810f19ac))
* **YouTube - Picture-in-picture button:** Do not load the flyout icon when the patch is not included ([0902326](https://github.com/MorpheApp/morphe-patches/commit/09023263cd73e85a3a0ea975c5ec514e0aa116f9))
* **YouTube - Playback speed:** Audio pitch controls not working on some devices ([44cf78b](https://github.com/MorpheApp/morphe-patches/commit/44cf78bcb556c2567511524e05e88308dc268486))
* **YouTube - Restore original titles:** Find the description by its body instead of the longest text ([3f72696](https://github.com/MorpheApp/morphe-patches/commit/3f726964b9896c12711f578469bc6e522d84474e))
* **YouTube - Restore original titles:** Replace the title in the fullscreen swipe-up panel ([9a966a9](https://github.com/MorpheApp/morphe-patches/commit/9a966a9d2c2f5fb0519218fd408d74653f2e89c7))
* **YouTube - Restore original titles:** Titles of videos searched in different languages ​​were not restored ([41eee25](https://github.com/MorpheApp/morphe-patches/commit/41eee25b9ee9863ba0aed5762f802c91aeb0a6c5))
* **YouTube - Skip silence:** Adapt the silence threshold to the audio level ([672830e](https://github.com/MorpheApp/morphe-patches/commit/672830e18c8fe47aedd6079bd8eb7b3441e0939d))
* **YouTube - Spoof video streams:** Stream spoofing can show "Failed to obtain poToken" error ([c04605b](https://github.com/MorpheApp/morphe-patches/commit/c04605b743a1cd5a9de9d17a86abcfdcef359431))
* **YouTube Music - Third-party lyrics:** App may crash when viewing lyrics ([#3569](https://github.com/MorpheApp/morphe-patches/issues/3569)) ([fe546ad](https://github.com/MorpheApp/morphe-patches/commit/fe546ad518d30833af7b7148f8a9b974088174a7))
* **YouTube:** 'Minimal' miniplayer video area is empty in Arabic (RTL) ([c4f7eb9](https://github.com/MorpheApp/morphe-patches/commit/c4f7eb925e51c6cd91337ae9d4f9c23b7c95d4f2))
* **YouTube:** Allow video upload/live with toolbar create button ([a8fb76a](https://github.com/MorpheApp/morphe-patches/commit/a8fb76ae2162bfab09af383013ee4e2717c3ef38))
* **YouTube:** Audio pitch resets after playback speed ([696c2e4](https://github.com/MorpheApp/morphe-patches/commit/696c2e40bce52706cb5e99c9caa2a96f67a60c37))
* **YouTube:** Fix crash when exiting fullscreen with the new player UI ([5651020](https://github.com/MorpheApp/morphe-patches/commit/56510203e25b8dc4619670a756e65c9439fdf66b))
* **YouTube:** Hide microphone at lower right corner of search not working ([d18708b](https://github.com/MorpheApp/morphe-patches/commit/d18708b39d693abd765e98c735296fe2404308e1))
* **YouTube:** Live chat input field is obscured by Android navigation bar on live streams ([f9f5d58](https://github.com/MorpheApp/morphe-patches/commit/f9f5d587eb796f3abc0686c753f8f0ef605633ba))

### ✨ New Features

* Automatically save crash reports to user documents folder ([#3570](https://github.com/MorpheApp/morphe-patches/issues/3570)) ([f633697](https://github.com/MorpheApp/morphe-patches/commit/f63369780d8a69cd0fb868711ca97e148a650d56))
* **Settings:** Show screen descriptions in a dialog from the toolbar info button ([a62ecc7](https://github.com/MorpheApp/morphe-patches/commit/a62ecc7dd3551a0b0954256a0797723d661bc32a))
* **Spoof video streams:** Add Wii U TV client as a fallback for TV ([#3655](https://github.com/MorpheApp/morphe-patches/issues/3655)) ([28ea7f9](https://github.com/MorpheApp/morphe-patches/commit/28ea7f9fe44d45a1869603086ce6e6adb89e4f48))
* **YouTube - Captions:** Add an option to select preferred caption language ([#3566](https://github.com/MorpheApp/morphe-patches/issues/3566)) ([435aa17](https://github.com/MorpheApp/morphe-patches/commit/435aa171aa30942530efae48159e9a61a94ccc8f))
* **YouTube - Channel search:** Add a separate channel page button to search within channels ([#3572](https://github.com/MorpheApp/morphe-patches/issues/3572)) ([639908f](https://github.com/MorpheApp/morphe-patches/commit/639908fd12eb8126171b7a275eb63a3f564c8239))
* **YouTube - DeArrow:** Add "Casual mode" setting ([#3668](https://github.com/MorpheApp/morphe-patches/issues/3668)) ([a13c11b](https://github.com/MorpheApp/morphe-patches/commit/a13c11b26b5a2b264d3fe4d0937e5814f18d2488))
* **YouTube - DeArrow:** Add more fine-grained settings for showing DeArrow titles ([#3573](https://github.com/MorpheApp/morphe-patches/issues/3573)) ([4aa01d6](https://github.com/MorpheApp/morphe-patches/commit/4aa01d6068722f343857c16ae9d5b9bc08e57c27))
* **YouTube - Hide layout components:** Add "Hide 'Ask Gemini' button" setting  ([#3662](https://github.com/MorpheApp/morphe-patches/issues/3662)) ([3da93d5](https://github.com/MorpheApp/morphe-patches/commit/3da93d5ac7d4abb22712f4725fe12cb8be5f1454))
* **YouTube - Hide layout components:** Add "Hide tap and hold gradient" setting ([#3586](https://github.com/MorpheApp/morphe-patches/issues/3586)) ([bf43c38](https://github.com/MorpheApp/morphe-patches/commit/bf43c38ab1bcc2c0966f3cbd12411313ce2f2323))
* **YouTube - Restore original titles:** Added support for media notification ([#3640](https://github.com/MorpheApp/morphe-patches/issues/3640)) ([a9ebf92](https://github.com/MorpheApp/morphe-patches/commit/a9ebf92c985e09fb551f9921c403478fd712ddf0))
* **YouTube Music - Crossfade:** Support newer versions ([#3635](https://github.com/MorpheApp/morphe-patches/issues/3635)) ([68988d4](https://github.com/MorpheApp/morphe-patches/commit/68988d4ed5af8c079e44da3562de4cb85f3d18a4))
* **YouTube Music - Settings:** Add a shortcut to change the app language on Android 13+ ([b3b5c11](https://github.com/MorpheApp/morphe-patches/commit/b3b5c11b85e2ddc15e18da2b3e27f1e35b70dfd5))
* **YouTube Music - Third-party lyrics:** SponsorBlock segments as lyrics offset ([#3575](https://github.com/MorpheApp/morphe-patches/issues/3575)) ([a900dfa](https://github.com/MorpheApp/morphe-patches/commit/a900dfa93b330f5a6c4ecc81a47fe2e09fa378fe))
* **YouTube Music:** Add `Enable audio/video switch` patch ([#3471](https://github.com/MorpheApp/morphe-patches/issues/3471)) ([87942b7](https://github.com/MorpheApp/morphe-patches/commit/87942b73da43a5fb1f8bf1bc46aea092badc12cb))
* **YouTube Music:** Add `Playlist track tap action` patch ([#3446](https://github.com/MorpheApp/morphe-patches/issues/3446)) ([66b7e78](https://github.com/MorpheApp/morphe-patches/commit/66b7e7817fb56938a2b6e7bd5a06a4cb2e52e409))
* **YouTube:** Add `Copy text` patch ([#3592](https://github.com/MorpheApp/morphe-patches/issues/3592)) ([f5312eb](https://github.com/MorpheApp/morphe-patches/commit/f5312eb35e275bddddd49696ae277f09d11efbeb))
* **YouTube:** Add `Disable continue watching prompt` patch ([#3580](https://github.com/MorpheApp/morphe-patches/issues/3580)) ([255d917](https://github.com/MorpheApp/morphe-patches/commit/255d917abc874f12382943edff0340425053ef83))
* **YouTube:** Add `Force system font` patch ([#3579](https://github.com/MorpheApp/morphe-patches/issues/3579)) ([3968284](https://github.com/MorpheApp/morphe-patches/commit/3968284900ab15a9d04575b359272759891d19c8))

### 🚀 Updated App Support

* **Reddit:** Add experimental support for `2026.41.0` ([4e56069](https://github.com/MorpheApp/morphe-patches/commit/4e56069f64125347959f7a8b1efeffa3e8fac1d6))
* **YouTube:** Add support for `21.20.405` ([4cb3bd8](https://github.com/MorpheApp/morphe-patches/commit/4cb3bd872d57f036dce22692dcfb76f80df5ec20))


Skipped:  
Patches: MorpheApp/patches-1.47.0.mpp    
