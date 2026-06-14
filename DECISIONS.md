# Decisions

Why this repo is set up the way it is. Newest decisions first. Operational rules
derived from these live in [CLAUDE.md](CLAUDE.md).

## Background

A 1996 Physics *Diplomarbeit*. Over the years it was migrated to GitHub and its
LaTeX modernized (LaTeX2e, `biblatex`/`biber`, UTF-8). The recurring pain was
re-installing and re-learning a LaTeX toolchain on every new machine, and output
drifting from the original as 1996 packages disappeared. The **original 1996
LaTeX 2.09 source no longer exists**; the only canonical artifacts are the two
PostScript files submitted to the examination office (`Pruefungsamt.{bw,color}.ps`,
`dvipsk 5.58c`, 600 dpi, 1996-03-11): 41 pages b/w text + 6 color plates = the
46-page print, color pages 3/12/16/25/32/33.

---

## Reproducible build via a digest-pinned Docker TeXLive

`make pdf` builds inside a `texlive/texlive` image pinned **by digest**, so the
whole toolchain is frozen and works on any machine that has only Docker (the dev
machine has Docker but no TeX). A `make local` host-`latexmk` path remains as a
fallback. **Why digest-pin:** reproducibility forever — a re-pull can't silently
change the toolchain. CI uses the same digest.

## Fidelity = faithful-but-clean

Pixel-perfect reproduction is impossible (no 1996 source), so the target is a
clean modern build that respects the original layout. Added **`lmodern`** only
(vector Latin Modern ≈ the 1996 Computer Modern; kills blurry bitmap fonts). **No
layout-altering packages** and `\epsfig` kept as-is, to avoid shifting line/page
breaks away from the original. `make diff` rasterizes the build next to a
**reconstructed** 1996 original for a page-aligned comparison: the 1996 submission
was a 41-page b/w file (`bw.ps`) plus 6 color plates printed separately (`color.ps`);
`scripts/compare.sh` interleaves the plates back into the b/w text at their original
physical positions (4, 13, 17, 26, 33, 34 — the `00README` color pages) to rebuild
the full 47-page document, which lines up 1:1 with the modern build. Verified: all
text is embedded Type-1 vector, 0 undefined refs, ~1 inherited overfull box, 47
pages, pagination identical to 1996 (TOC page numbers match through the appendices).

## Build output isolated; generated files untracked

All build output goes to `build/` (via `.latexmkrc` `out_dir`), which is
gitignored. Stopped tracking `*.aux/*.toc/*.bbl/diplom.pdf` and removed the stale
capital-`D` `Diplom.*` leftovers from the 1996 dvips run. The PDF is published by
CI instead of committed. **Why:** generated files are noise in diffs and go stale.

## Root file normalized `Diplom.tex` → `diplom.tex`

The root file was tracked capital-`D` but referenced lowercase everywhere.
Invisible on case-insensitive macOS; **would break CI on case-sensitive Linux.**
Normalized to lowercase to match the toolchain and output name.

## 1996 manual print-finishing automated in source; `00README` removed

`00README` listed manual edits to the *generated* `.bbl`/`.toc` before printing —
exactly the thing lost on every rebuild. Moved them into the source so `make pdf`
reproduces them: `\thispagestyle{plain}` on the contents and bibliography pages,
and `\DefineBibliographyStrings{german}{mathesis = {Diplomarbeit}}` (the four
cited German theses are Diplomarbeiten, not "Magisterarb."). The color-page note
is preserved in the README; `00README` deleted (history keeps it).

## Citation style matched to the 1996 `apasc` look

The modern `biblatex authoryear` default diverged from 1996. Restored:
`uniquename=false, uniquelist=false` (the disambiguation was leaking given names
into citations because the `.bib` stored authors inconsistently); small-caps
surnames (`\mkbibnamefamily` → `\textsc`); comma before the year (`\nameyeardelim`).
Result e.g. "(Hubel, 1989)" in small caps, matching the 1996 reference list.

## Author given names normalized to initials

Standardized every author/editor to initials ("Geisel, T.", "Löwel, S."). **Why
initials and not full names:** it matches the 1996 thesis, it's the only form
universally achievable (many entries only ever had initials — full names can't be
reliably reconstructed), and it needs the fewest edits. Genuinely different people
sharing a surname are kept distinct by their initials (Kim D. S. vs Y. S.; Meadows
D. H. vs D. L.; Pnevmatikos Sp. vs St.; three separate Schmidts).

## Bibliographic data-quality fixes

Found and fixed while normalizing: surname typos cross-checked against keys/known
names — Schmi**dt**→Schmi**tt** (F. O.), Marl**s**burg→Mal**s**burg (Christoph von
der Malsburg), Rittern→Ritter (Helge Ritter), Olavaria→Olavarria, Aieli→Arieli;
trailing-particle bugs (`Sluyters, R. C. Van` → `Van Sluyters, R. C.`; same for Van
Essen); malformed multi-name fields (Krönig/Lang, Rogers/Vemuri with a stray German
"und", Domany/van Hemmen/Schulten); and `et al.` stored as a family name
(`{et al., E. D. Schmidt}` → `{E. D. Schmidt and others}`). Then fixed all 33
`biber --validate-datamodel` violations (series-letter volumes → journal name,
Roman → Arabic volumes, articles carrying book fields, swapped title/booktitle,
wrong entry types). `make bib-lint` now reports `ok`.

Resolved: `bonhoeffer:1995`'s *Arzneimittel-Forschung* journal looked wrong but is
**correct** — verified against PubMed 7763325 (Bonhoeffer T., *Arzneimittelforschung*
1995 Mar;45(3A):351-6). Only its issue number was wrong (`{I}` → `{3A}`).

## Bibliography tooling; betterbib not bulk-run

Added `make bib-lint` (biber validator — the linter) and `make bib-format`
(bibtex-tidy — the formatter). **betterbib is deliberately not part of the
routine:** it canonicalizes against Crossref, which (a) re-expands names to full
forms, undoing the initials convention, and (b) mis-matches the many old/obscure
entries Crossref doesn't index. Kept as a documented targeted spot-check only.
Also removed stale cruft: the 2020 `betterbib_cache.sqlite` and the 1990s
`bibtex/*.html` web exports (dead `ftp://` links; regenerable from the `.bib`).
