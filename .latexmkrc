# latexmk configuration — honored identically by the Docker build (`make pdf`)
# and a local TeX install (`make local`). See the Makefile / README.

$pdf_mode   = 1;          # build a PDF directly with pdflatex
$out_dir    = 'build';    # keep generated files out of the repo root
$bibtex_use = 2;          # run the bibliography tool, clean its output on -C

# biblatex uses biber (backend=biber in diplom.tex); latexmk picks it up from
# the .bcf automatically. Pin the commands explicitly so behaviour is identical
# everywhere.
$pdflatex = 'pdflatex -synctex=1 -interaction=nonstopmode -file-line-error %O %S';
$biber    = 'biber %O %S';
