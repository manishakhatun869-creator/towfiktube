#!/usr/bin/env bash
# Regenerate the Towfik Youtube adaptive icon PNGs and preview.
# Requires ImageMagick (magick or convert). The generated PNGs are committed so
# GitHub Actions and Morphe do not need ImageMagick installed.
set -euo pipefail
cd "$(dirname "$0")"
if command -v magick >/dev/null 2>&1; then
  image_tool=magick
else
  image_tool=convert
fi

workdir="$(mktemp -d)"
trap 'rm -rf "$workdir"' EXIT

# Artwork stays inside the Android adaptive-icon safe area (center 66%).
"$image_tool" -size 432x432 'gradient:#192d50-#080e20' -rotate 90 \
  -gravity center -crop 432x432+0+0 +repage "$workdir/background.png"
"$image_tool" -size 432x432 xc:none \
  -fill '#fa3153' -draw 'roundrectangle 94,109 338,250 54,54' \
  -fill white -font DejaVu-Sans-Bold -pointsize 108 \
  -gravity northwest -annotate +139+120 'T' \
  -draw 'polygon 247,151 247,209 298,180' \
  -gravity north -font DejaVu-Sans-Bold -pointsize 50 \
  -annotate +0+267 'Towfik' \
  -font DejaVu-Sans -pointsize 31 -annotate +0+326 'Youtube' \
  "$workdir/foreground.png"

for spec in mdpi:108 hdpi:162 xhdpi:216 xxhdpi:324 xxxhdpi:432; do
  dpi="${spec%%:*}"
  size="${spec##*:}"
  directory="icons/mipmap-$dpi"
  mkdir -p "$directory"
  "$image_tool" "$workdir/background.png" -resize "${size}x${size}" \
    "$directory/morphe_adaptive_background_custom.png"
  "$image_tool" "$workdir/foreground.png" -resize "${size}x${size}" \
    "$directory/morphe_adaptive_foreground_custom.png"
done
"$image_tool" "$workdir/background.png" "$workdir/foreground.png" \
  -compose over -composite logo-preview.png
