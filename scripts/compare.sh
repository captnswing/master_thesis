#!/usr/bin/env bash
#
# Visual-fidelity check, page-aligned to the 1996 submission. Invoked by `make diff`.
# Runs inside the Docker image (needs ghostscript, poppler-utils, imagemagick).
#
# The 1996 thesis was submitted as TWO PostScript files: Pruefungsamt.bw.ps (the 41
# black-and-white pages) and Pruefungsamt.color.ps (the 6 color plates, printed
# separately and interleaved into the b/w text). The modern build is a single
# 47-page PDF with every figure inline. A naive page-by-page diff therefore drifts
# after the first color plate.
#
# This script reconstructs the complete 47-page original by inserting the color
# plates back into the b/w text at their original positions, so the comparison is
# 1:1 with build/diplom.pdf. The plate positions (physical pages) are fixed and
# documented in the old 00README — printed pages 3, 12, 16, 25, 32, 33, which map
# to physical pages 4, 13, 17, 26, 33, 34 (the title page is unnumbered). They hold
# as long as the build stays 47 pages with unchanged pagination; the count is
# checked and a mismatch warns rather than silently misaligning.
#
set -euo pipefail

BUILD=build
NEW=$BUILD/diplom.pdf
OUT=$BUILD/compare
RECON=$BUILD/_recon
DPI=110
COLOR_PAGES="4 13 17 26 33 34"   # physical positions of the 6 color plates

[ -f "$NEW" ] || { echo "error: $NEW not found — run 'make pdf' first" >&2; exit 1; }

rm -rf "$OUT" "$RECON"
mkdir -p "$OUT/new" "$OUT/orig" "$OUT/sidebyside" "$RECON"

echo ">> converting the 1996 PostScript originals to PDF"
ps2pdf Pruefungsamt.bw.ps    "$RECON/bw.pdf"
ps2pdf Pruefungsamt.color.ps "$RECON/color.pdf"

bwN=$(pdfinfo "$RECON/bw.pdf"    | awk '/Pages/{print $2}')
colN=$(pdfinfo "$RECON/color.pdf" | awk '/Pages/{print $2}')
newN=$(pdfinfo "$NEW"            | awk '/Pages/{print $2}')
total=$((bwN + colN))
echo "   b/w=$bwN  color=$colN  ->  reconstructed=$total   new=$newN"
[ "$total" -eq "$newN" ] || echo "   WARNING: reconstructed ($total) != new ($newN) pages — alignment may be off." >&2

echo ">> interleaving the color plates back into the b/w text"
pdfseparate "$RECON/bw.pdf"    "$RECON/bw-%d.pdf"
pdfseparate "$RECON/color.pdf" "$RECON/color-%d.pdf"
seq_files=(); bp=1; cp=1
for i in $(seq 1 "$total"); do
    if [[ " $COLOR_PAGES " == *" $i "* ]]; then
        seq_files+=("$RECON/color-$cp.pdf"); cp=$((cp + 1))
    else
        seq_files+=("$RECON/bw-$bp.pdf");    bp=$((bp + 1))
    fi
done
pdfunite "${seq_files[@]}" "$RECON/orig.pdf"

echo ">> rasterizing both documents at ${DPI} dpi"
pdftoppm -r "$DPI" -png "$NEW"          "$OUT/new/page"
pdftoppm -r "$DPI" -png "$RECON/orig.pdf" "$OUT/orig/page"

echo ">> stitching side-by-side images (left = 1996 original, right = modern)"
shopt -s nullglob
for f in "$OUT"/new/page-*.png; do
    base=$(basename "$f")
    orig="$OUT/orig/$base"
    [ -f "$orig" ] || continue
    montage "$orig" "$f" -tile 2x1 -geometry +4+4 -background '#888888' "$OUT/sidebyside/$base"
done

echo
echo "Done. Page-aligned comparison in $OUT/sidebyside/ (left = 1996 original | right = modern)."
