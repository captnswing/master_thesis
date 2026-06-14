#!/usr/bin/env bash
#
# Visual-fidelity check: render the modern build and the canonical 1996
# PostScript original to PNGs and stitch side-by-side images for eyeballing.
# Runs inside the Docker image (needs ghostscript, poppler-utils, imagemagick).
# Invoked by `make diff`.
#
set -euo pipefail

BUILD=build
ORIG_PS=${1:-Pruefungsamt.bw.ps}   # canonical 1996 text (41 pp); pass .color.ps for the plates
NEW_PDF=$BUILD/diplom.pdf
OUT=$BUILD/compare
DPI=100

[ -f "$NEW_PDF" ] || { echo "error: $NEW_PDF not found — run 'make pdf' first" >&2; exit 1; }
[ -f "$ORIG_PS" ] || { echo "error: $ORIG_PS not found" >&2; exit 1; }

rm -rf "$OUT"
mkdir -p "$OUT/new" "$OUT/orig" "$OUT/sidebyside"

echo ">> converting canonical PostScript -> PDF"
ps2pdf "$ORIG_PS" "$BUILD/orig.pdf"

echo ">> rasterizing both documents at ${DPI} dpi"
pdftoppm -r "$DPI" -png "$NEW_PDF"      "$OUT/new/page"
pdftoppm -r "$DPI" -png "$BUILD/orig.pdf" "$OUT/orig/page"

echo ">> stitching side-by-side images (left = 1996 original, right = modern)"
shopt -s nullglob
for f in "$OUT"/new/page-*.png; do
    base=$(basename "$f")
    orig="$OUT/orig/$base"
    [ -f "$orig" ] || continue
    montage "$orig" "$f" -tile 2x1 -geometry +4+4 -background '#888888' \
        "$OUT/sidebyside/$base"
done

echo
echo "Done. Compare images in $OUT/sidebyside/ (left = 1996 original | right = modern)."
echo "Note: page numbering differs between the two — align by content, not index."
