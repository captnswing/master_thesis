# Diplomarbeit — *Sequentielle Bifurkation visueller Reizrepräsentationen* (1996)

My Physics *Diplomarbeit* (master's thesis), submitted 1996, on the formation of
ocular-dominance and orientation-preference maps in the primary visual cortex via
an elastic-net model. This repo keeps the source alive and buildable on modern
machines without re-learning a LaTeX toolchain on every new computer.

## Build it

The default build needs **only Docker** — no local TeX install:

```sh
make pdf      # -> build/diplom.pdf  (builds the pinned TeXLive image on first run)
make diff     # render the new PDF next to the 1996 original for comparison
make shell    # interactive shell inside the build container
make clean    # remove build/
```

First `make pdf` builds a Docker image (a pinned `texlive/texlive` plus a couple
of tools for `make diff`); later runs reuse it. The compiled PDF lands in
`build/diplom.pdf`.

If you *do* have a TeX distribution installed (MacTeX/TeX Live, with `latexmk` and
`biber`), you can skip Docker entirely:

```sh
make local    # -> build/diplom.pdf using your host latexmk
```

GitHub Actions also builds the PDF on every push using the same pinned image and
uploads it as a workflow artifact (and attaches it to a Release on version tags),
so you can download a fresh PDF without building anything locally.

## Provenance & the canonical originals

The LaTeX source in this repo has been modernized over the years (it is LaTeX2e
with `biblatex`/`biber`, `graphicx`, UTF-8, etc.); the original 1996 LaTeX 2.09
source no longer survives. The **canonical artifacts** are the two PostScript
files that were actually submitted to the examination office (*Prüfungsamt*),
produced by `dvipsk 5.58c` at 600 dpi on 1996-03-11:

- **`Pruefungsamt.bw.ps`** — the full 41-page black-and-white text.
- **`Pruefungsamt.color.ps`** — the 6 color figure plates.

These are kept under version control and are the reference for `make diff`.

## Fidelity notes

Because no 1996 source remains, pixel-perfect reproduction is impossible. The goal
is a clean modern build that stays faithful to the original layout:

- `lmodern` provides vector Latin Modern fonts — the faithful descendant of the
  1996 Computer Modern look, without the blurry bitmap fonts.
- The original layout packages (`geometry` A4, `fancyhdr`, `epsfig`, the heading
  macros in `hacks.tex`) are kept as-is; no layout-altering packages were added.
- Use `make diff` to compare the rendered PDF against `Pruefungsamt.bw.ps`
  page-by-page.

## Bibliography maintenance

Bibliographies live in `bibtex/*.bib` and are rendered with `biblatex` +
`biber` (`authoryear` style). To normalize/validate the databases:

```sh
# https://github.com/nschloe/betterbib
pip install betterbib
betterbib-sync bibtex/chaos.bib  | betterbib-journal-abbrev | betterbib-format -b - c.bib
betterbib-sync bibtex/diplom.bib | betterbib-journal-abbrev | betterbib-format -b - d.bib
betterbib-sync bibtex/neuro.bib  | betterbib-journal-abbrev | betterbib-format -b - n.bib

biber --tool --validate-datamodel bibtex/chaos.bib
biber --tool --validate-datamodel bibtex/diplom.bib
biber --tool --validate-datamodel bibtex/neuro.bib
```

## Source layout

| File / dir            | Purpose                                            |
|-----------------------|----------------------------------------------------|
| `diplom.tex`          | root document (preamble + `\include`s)             |
| `hacks.tex`           | heading/caption/header macros                      |
| `titel`, `einleitung`, `biologie`, `modell`, `main`, `zusammenfassung`, `anhang1`, `anhang2` `.tex` | chapters / appendices |
| `pics/*.eps`          | figures (Encapsulated PostScript)                  |
| `bibtex/*.bib`        | bibliography databases                             |
| `Dockerfile`, `.latexmkrc`, `Makefile` | reproducible build toolchain      |
| `scripts/compare.sh`  | `make diff` rendering pipeline                     |
| `Pruefungsamt.*.ps`   | canonical 1996 submission (do not delete)          |
