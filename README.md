# Towfik Youtube

An **unofficial, non-root YouTube APK** built from the original YouTube APK using
[Morphe patches](https://github.com/MorpheApp/morphe-patches). This repository is
an APK build pipeline, **not the Android app's source code**. The app's behavior
and existing patching/downloading logic have not been rewritten.

The output is named **Towfik Youtube**, uses the separate install package
`com.towfik.youtube`, and has a custom Towfik/Youtube launcher logo (with a
matching themed and notification icon). See [logo preview](branding/logo-preview.png).
The original `com.google.android.youtube` IDs in `apps/*/youtube.json` are
**intentionally unchanged**: they identify the unmodified APK to download.
Morphe's GmsCore/Clone app and Custom branding patches change the output APK.
For sign-in on a non-root device, install a compatible
[GmsCore](https://github.com/ReVanced/GmsCore). This build does not replace the
original YouTube app.

## Build and download the release APK in Actions

Open **Actions → Build Towfik Youtube release APK → Run workflow**. Select the
branch containing this workflow and start the run. Open the completed run and
download the **towfik-youtube-release-apk** artifact. Its ZIP contains only
`Towfik-Youtube-release.apk` (one universal APK, not a debug-key build). The
artifact remains available for 14 days. This workflow does **not** create a
GitHub Release or any debug APK.

Pushing to this session's `arena/01a0e305-towfiktube` branch also starts a build.
This lets the branch produce an Actions run even though the current GitHub
connection cannot call the workflow-dispatch API. After the workflow is on the
default branch, the normal **Run workflow** button can be used manually.

The build fails if no patched APK is created, its signature cannot be verified,
or the installed package/launcher name does not match the Towfik branding.

## Signing

By default the existing repository's **public example keystore** signs APKs.
It is not private or unique to you. For your own updateable APKs, set **all
four** repository Actions secrets before building:

- `APK_KEYSTORE_BASE64`: one-line base64 of your JKS file
- `APK_KEYSTORE_PASSWORD`: keystore password
- `APK_KEY_ALIAS`: signing key alias
- `APK_KEY_PASSWORD`: key password

The workflow decodes your keystore to the temporary runner only. Back it up:
changing keys prevents Android from updating an existing install signed with
the old key (including builds signed with the public example key).

## Change the branding

Edit `branding/youtube.json` to change the display name, package name, or icon
folder. The icon folder contains adaptive background and foreground PNGs per
Android DPI, plus themed and notification vectors. Regenerate the PNGs with
`bash branding/generate_icons.sh` (requires ImageMagick). If you change the package ID or name,
also change the checks in `.github/workflows/patch.yml`. Do not replace the
original package IDs in the downloader configs with your output ID.
`patches/youtube-morphe.txt` leaves Morphe's default patch selection intact.

## Scope and attribution

This builder downloads third-party APKs and [Morphe Desktop and patches](https://github.com/MorpheApp/).
Towfik Youtube is **not affiliated with YouTube or Morphe**. Morphe's upstream
copyright, license notices, and source credits remain with the upstream tools;
this project is not a fork of the Morphe patch source. See [LICENSE](LICENSE)
for this repository's license. Use these builds at your own risk.
