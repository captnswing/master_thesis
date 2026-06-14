# Pinned, reproducible build environment for the thesis.
#
# Pinned by digest so the toolchain is frozen forever (re-pull will not drift).
# Human-readable tag at pin time: texlive/texlive:latest == TeX Live 2026,
# biber 2.21, ghostscript 10.07. To bump: `docker pull texlive/texlive:latest`,
# then `docker image inspect ... --format '{{join .RepoDigests "\n"}}'`.
FROM texlive/texlive@sha256:a78cd7792625e4245dc73cd5db390f0b9e6c2c7c14ac8b6ca59f023ef25ea282

# Extra tools for `make diff` (TeX Live already ships ghostscript).
RUN apt-get update \
    && apt-get install -y --no-install-recommends poppler-utils imagemagick \
    && rm -rf /var/lib/apt/lists/*

# Debian's ImageMagick policy blocks reading/writing PDF and PS by default;
# the diff harness needs both.
RUN for p in /etc/ImageMagick-7/policy.xml /etc/ImageMagick-6/policy.xml; do \
        [ -f "$p" ] && sed -i -E 's/rights="none" pattern="(PDF|PS|EPS)"/rights="read|write" pattern="\1"/' "$p" || true; \
    done

WORKDIR /work
