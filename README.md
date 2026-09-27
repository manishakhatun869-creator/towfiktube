# Towfik Youtube

An **unofficial, non-root YouTube APK** built from the original YouTube APK using
[Morphe patches](https://github.com/MorpheApp/morphe-patches). This repository is
an APK build pipeline, **not the Android app's source code**. The app's behavior
and existing patching/downloading logic have not been rewritten.

The output is named **Towfik Youtube**, uses the separate install package
`com.towfik.youtube`, and has a custom T/play launcher and notification icon.
The original `com.google.android.youtube` IDs in `apps/*/youtube.json` are
**intentionally unchanged**: they identify the unmodified APK to download.
Morphe's GmsCore/Clone app and Custom branding patches change the output APK.
For sign-in on a non-root device, install a compatible
[GmsCore](https://github.com/ReVanced/GmsCore). This build does not replace the
original YouTube app.

## Build the debug-test APK

Choose **Actions → Build Towfik Youtube debug APK → Run workflow**. After it
finishes, open the workflow run and download the **towfik-youtube-debug-apk**
artifact. The ZIP contains `Towfik-Youtube-debug.apk`. The workflow runs only
when manually dispatched; it does **not** create or update a GitHub Release,
run on a schedule, or upload any other APK. Artifacts are kept for seven days.

> This is a **debug-key-signed test APK**, not a Gradle `debug` variant: this
> repository patches the production YouTube APK and has no Android app source
> from which to compile a debuggable variant. The workflow makes a temporary
> Android debug keystore on each run and never commits it. Keys change between
> runs, so uninstall an older test build before installing the next one. It
> also cannot update an APK signed with the previous public/release keystore.
>
> Do not distribute this APK as a production release.

The build fails if no patched APK is created, its signature cannot be verified,
or its installed package/launcher name does not match the Towfik branding.
The workflow must be available on the repository's default branch for GitHub's
manual Run workflow button to appear; merge this branch first if needed.

## Change the branding

Edit `branding/youtube.json` to change the display name, package name, or icon
folder. The icon folder contains adaptive background and foreground PNGs per
Android DPI and a notification vector. If you change the package ID or name,
also change the checks in `.github/workflows/patch.yml`. Do not replace the
original package IDs in the downloader configs with your output ID.
`patches/youtube-morphe.txt` leaves Morphe's default patch selection intact.

## Scope and attribution

This builder downloads third-party APKs and [Morphe Desktop and patches](https://github.com/MorpheApp/).
Towfik Youtube is **not affiliated with YouTube or Morphe**. Morphe's upstream
copyright, license notices, and source credits remain with the upstream tools;
this project is not a fork of the Morphe patch source. See [LICENSE](LICENSE)
for this repository's license. Use these builds at your own risk.
