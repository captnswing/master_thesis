# Diplomarbeit — *Sequentielle Bifurkation visueller Reizrepräsentationen* (1996)

My Physics *Diplomarbeit* (master's thesis), submitted February 1996 at the
Institut für Theoretische Physik, Goethe-Universität Frankfurt — on the formation
of ocular-dominance and orientation-preference maps in the primary visual cortex
via an elastic-net model.

This repo keeps the source alive and reproducibly buildable on modern machines,
without re-learning a LaTeX toolchain on every new computer.

## Read it

Don't want to build anything? Read it online or grab the PDF:

<a href="https://captnswing.github.io/master-thesis/">
  <img src="https://captnswing.github.io/master-thesis/cover.png" alt="Cover — page 1 of the thesis" width="300" align="right">
</a>

- **[📖 Read online](https://captnswing.github.io/master-thesis/)** — GitHub Pages reader,
  rebuilt on every push to `main`.
- **[⬇ Download diplom.pdf](https://github.com/captnswing/master-thesis/releases/latest/download/diplom.pdf)** —
  latest tagged release.

Each `v*` tag triggers CI to build the PDF in the pinned image and attach it to the
[GitHub release](https://github.com/captnswing/master-thesis/releases); every push to
`main` republishes the [online reader](https://captnswing.github.io/master-thesis/) and
the cover above. (The cover/reader links go live after the first Pages deploy.)

<br clear="right">


## Build it

The build needs **only Docker** — no local TeX install:

```sh
make pdf      # -> build/diplom.pdf  (builds the pinned TeXLive image on first run)
make diff     # render the new PDF next to the 1996 original, side by side
make shell    # interactive shell inside the build container
make clean    # remove build/
```

`make pdf` builds a pinned `texlive/texlive` Docker image on first run (later runs
reuse it) and writes `build/diplom.pdf`.

Have a TeX distribution already (MacTeX / TeX Live with `latexmk` + `biber`)? Skip
Docker:

```sh
make local    # -> build/diplom.pdf using your host latexmk
```

GitHub Actions also builds the PDF on every push in the same pinned image and
uploads it as an artifact (and, on `v*` tags, attaches it to a
[release](#read-it)) — so you can download a fresh PDF without building anything.

## Provenance & the canonical originals

The LaTeX source has been modernized over the years (LaTeX2e, `biblatex`/`biber`,
UTF-8); the original 1996 LaTeX 2.09 source no longer survives. The **canonical
artifacts** are the two PostScript files submitted to the examination office
(*Prüfungsamt*), produced by `dvipsk 5.58c` at 600 dpi on 1996-03-11:

- **`Pruefungsamt.bw.ps`** — the full 41-page black-and-white text.
- **`Pruefungsamt.color.ps`** — the 6 color figure plates (pages 3, 12, 16, 25,
  32, 33 of the 46-page print, swapped in on a color printer).

They are kept under version control, must not be deleted, and are the reference
for `make diff`. Because no source survives, the modern build aims to be *faithful
but clean* rather than pixel-identical — see [DECISIONS.md](DECISIONS.md).

## Bibliography

Bibliographies live in `bibtex/*.bib`, rendered with `biblatex` + `biber`
(`authoryear`). Author given names are kept as **initials** (matching the 1996
thesis). Two maintenance targets — a linter and a formatter:

```sh
make bib-lint     # biber datamodel validator — should print "ok" per file
make bib-format   # bibtex-tidy formatter (needs node/pnpm); edits in place
```

`betterbib` (Crossref) is **not** part of routine maintenance — it re-expands
names and mis-matches old entries; use it only as a one-off spot-check. Details in
[DECISIONS.md](DECISIONS.md).

## Repo layout

| File / dir | Purpose |
|---|---|
| `diplom.tex` | root document (preamble + `\include`s) — **lowercase on purpose** |
| `hacks.tex` | heading / caption / header macros |
| `titel`, `einleitung`, `biologie`, `modell`, `main`, `zusammenfassung`, `anhang1`, `anhang2` `.tex` | chapters / appendices |
| `pics/*.eps` | figures (Encapsulated PostScript) |
| `bibtex/*.bib` | bibliography databases |
| `Dockerfile`, `.latexmkrc`, `Makefile` | reproducible build toolchain |
| `scripts/compare.sh` | `make diff` rendering pipeline |
| `Pruefungsamt.*.ps` | canonical 1996 submission (do not delete) |
| `CLAUDE.md`, `DECISIONS.md` | contributor/AI working notes and the decision log |

## Contributing

- [CLAUDE.md](CLAUDE.md) — build commands, conventions, and hard rules (also read
  by Claude Code).
- [DECISIONS.md](DECISIONS.md) — why the repo is set up the way it is.
