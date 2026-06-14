# Reproducible build for the 1996 Diplomarbeit.
#
# Default path needs ONLY Docker — no local TeX install required:
#
#     make pdf      build build/diplom.pdf inside the pinned TeXLive image
#     make diff     render the new PDF next to the canonical 1996 PostScript
#     make shell    interactive shell in the build container
#     make local    build with a locally-installed latexmk (no Docker)
#     make clean      remove the build/ directory
#     make distclean  clean + drop the locally-built Docker image
#
# The actual build command lives in one place (the `local` rule + .latexmkrc);
# `pdf` just runs `make local` inside the container, so there is no duplication.

IMAGE   := thesis-tex
STAMP   := .docker-image-stamp
LATEXMK := latexmk           # configured via .latexmkrc

# Run a command in the pinned image, as the host user, with the repo mounted.
# HOME=/tmp gives latexmk/biber a writable cache dir.
DOCKER_RUN := docker run --rm -u $(shell id -u):$(shell id -g) \
		-e HOME=/tmp -v "$(CURDIR)":/work -w /work $(IMAGE)

.PHONY: all pdf local diff shell image clean distclean
.DEFAULT_GOAL := pdf

all: pdf

# ---- Docker-first (default) -------------------------------------------------
pdf: $(STAMP)
	$(DOCKER_RUN) make local

diff: pdf
	$(DOCKER_RUN) bash scripts/compare.sh

shell: $(STAMP)
	docker run --rm -it -u $(shell id -u):$(shell id -g) \
		-e HOME=/tmp -v "$(CURDIR)":/work -w /work $(IMAGE) bash

image: $(STAMP)
$(STAMP): Dockerfile
	docker build -t $(IMAGE) .
	@touch $(STAMP)

# ---- Local fallback (requires a TeX install on the host) --------------------
local:
	$(LATEXMK) diplom.tex

# ---- Housekeeping -----------------------------------------------------------
clean:
	rm -rf build
	rm -f betterbib_cache.sqlite   # stray cache if betterbib was run from the repo root

distclean: clean
	-docker image rm $(IMAGE) 2>/dev/null || true
	rm -f $(STAMP)
