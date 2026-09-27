# Towfik Youtube

An **unofficial, non-root YouTube APK** built from the original YouTube APK using
[Morphe patches](https://github.com/MorpheApp/morphe-patches). This repository is
an APK build pipeline, **not the Android app's source code**. The app's behavior
and the existing patching/downloading logic have not been rewritten.

The output is named **Towfik Youtube**, uses the distinct install package
`com.towfik.youtube`, and has a custom T/play launcher and notification icon.
The original `com.google.android.youtube` IDs in `apps/*/youtube.json` are
**intentionally unchanged**: they identify the unmodified APK to download.
The Morphe GmsCore/Clone app and Custom branding patches change the output APK.
For sign-in, install a compatible [GmsCore](https://github.com/ReVanced/GmsCore)
on your non-root device. This build does not replace the official YouTube app.

## Get the APK

Run **Actions → Build Towfik Youtube release APK → Run workflow** on the branch
containing this workflow (or let the daily 06:00 UTC schedule run after merging
it to the default branch). After a successful run, download the **one release
APK** from [Releases](https://github.com/manishakhatun869-creator/towfiktube/releases/tag/towfik-youtube). The workflow also
attaches the same APK as a run artifact. It fails if patching produces no APK,
if signing fails, or if the APK has the wrong installed package/launcher label.
No debug APK, YouTube Music APK, or manifest is published by this workflow.

> The workflow must exist on the repository's default branch for GitHub's
> manual dispatch button and schedule to appear. Until then, review/merge this
> branch or use GitHub's available workflow controls for your repository.

## Change the branding

Edit `branding/youtube.json` for the display name, package name, or icon folder.
The icon folder contains adaptive background and foreground PNGs per Android
DPI, plus a white notification vector. If you change the package ID, also
update the expected value in `.github/workflows/patch.yml`'s verification step.
`patches/youtube-morphe.txt` leaves Morphe's default patch selection intact.
Do not replace the package IDs in the downloader configs with your output ID.

## Signing

For initial builds, the existing repository's **public example keystore** signs
APKs. It is not private or unique to you. For your own updates, generate and
keep a private Android JKS keystore securely, then set **all four** repository
Actions secrets:

- `APK_KEYSTORE_BASE64`: base64 of the JKS file (one line)
- `APK_KEYSTORE_PASSWORD`: store password
- `APK_KEY_ALIAS`: signing key alias
- `APK_KEY_PASSWORD`: key password

The workflow decodes the keystore to the temporary runner and never commits it.
Keep a backup: changing keys later prevents Android from installing updates over
previous APKs signed with the old key. Existing installs signed with the public
example key must be uninstalled before switching to your private key.

## Scope and attribution

This builder downloads third-party APKs and [Morphe Desktop and patches](https://github.com/MorpheApp/).
Towfik Youtube is **not affiliated with YouTube or Morphe**. Morphe's upstream
copyright, license notices, and source credits remain with the upstream tools;
this project is not a fork of the Morphe patch source. See [LICENSE](LICENSE)
for this repository's license. Use these builds at your own risk.
