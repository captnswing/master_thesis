# CLAUDE.md — working in this repository

This repo is a 1996 Physics *Diplomarbeit* (LaTeX). The goal is a reproducible,
faithful PDF on any machine. Rationale for the choices below is in
[DECISIONS.md](DECISIONS.md); human-facing usage is in [README.md](README.md).

## Build

- **`make pdf` is the build.** It runs inside a pinned `texlive/texlive` Docker
  image — **this repo needs only Docker, no host TeX.** Output goes to `build/`.
- `make local` builds with host `latexmk` (only if a TeX install is present).
- `make diff` rasterizes the PDF next to the canonical 1996 PostScript.
- `make bib-lint` runs biber's datamodel validator; **it must report `ok` for
  every `.bib`.** Run it after any bibliography edit.
- After changing `diplom.tex` or any chapter, rebuild and check `build/diplom.log`
  for new warnings. A clean build is **0 undefined references, 0 font
  substitutions, no Type-3 fonts** (verify fonts with `pdffonts build/diplom.pdf`).

## Hard rules

- **The root file is `diplom.tex` (lowercase).** It is tracked lowercase on
  purpose — macOS is case-insensitive but CI/Linux is not. Never reintroduce a
  capital-`D` `Diplom.*`.
- **Never delete `Pruefungsamt.bw.ps` / `Pruefungsamt.color.ps`.** They are the
  only surviving canonical 1996 artifacts (the original LaTeX 2.09 source is gone)
  and the reference for `make diff`.
- **Don't commit generated files.** Everything builds into `build/` (gitignored);
  `*.aux/*.toc/*.bbl/*.pdf` are not tracked.
- The Docker image is pinned **by digest** in `Dockerfile` (and the same digest in
  `.github/workflows/build.yml`). To bump: `docker pull texlive/texlive:latest`,
  read the digest from `docker image inspect`, update **both** places.

## Fidelity (faithful-but-clean)

- Stay faithful to the 1996 PostScript layout. Use `lmodern` (vector Latin Modern
  ≈ the 1996 Computer Modern). **Do not add layout-altering packages** (`microtype`
  etc.) or rewrite `\epsfig{...}` → `\includegraphics` — they shift line/page
  breaks. Keep `geometry`(A4), `fancyhdr`, `epsfig`, and the `hacks.tex` macros.
- The 1996 manual print-finishing is reproduced in source, not hand-edited into
  generated files: `\thispagestyle{plain}` on the contents (`titel.tex`) and
  bibliography (`diplom.tex`) pages, and
  `\DefineBibliographyStrings{german}{mathesis = {Diplomarbeit}}`.

## Bibliography conventions (`bibtex/*.bib`)

- **Author/editor given names are always initials** ("Löwel, S.", "Hubel, D. H.").
  This matches the 1996 thesis and is the project standard — keep new entries
  consistent.
- Citation style is configured in `diplom.tex` to match the 1996 `apasc` look:
  `biblatex` `authoryear` with `uniquename=false, uniquelist=false`, small-caps
  surnames (`\mkbibnamefamily` → `\textsc`), and a comma before the year
  (`\nameyeardelim`). Don't undo these without reason.
- **Do not bulk-run `betterbib`.** It re-expands names to Crossref's full forms
  (undoing the initials convention) and mis-matches the many pre-Crossref entries.
  Use it only as a targeted spot-check on a single suspect entry.
- Entries must pass `make bib-lint` (biber `--validate-datamodel`): correct entry
  type for its fields, integer `volume`/`number`, mandatory fields present.

## Workflow

- Branch off `main`; open a PR with `gh`. The owner reviews and merges.
- CI (`.github/workflows/build.yml`) builds the PDF in the pinned image and
  uploads it as an artifact (and a Release asset on `v*` tags). Keep it green.
