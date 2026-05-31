#!/usr/bin/env bash
##
##  Agentic Software Engineering (ASE)
##  Copyright (c) 2025-2026 Dr. Ralf S. Engelschall <rse@engelschall.com>
##  Licensed under GPL 3.0 <https://spdx.org/licenses/GPL-3.0-only>
##

session="$1"

npx nunjucks -p @rse/nunjucks-addons -o $session.tape $session.tape.njk

vhs $session.tape

rm -f $session.tape

mv $session.mp4 ../dst/
mv $session.gif ../dst/

video2hls \
    --output ../dst/$session.hls \
    --output-overwrite \
    --hls-type fmp4 \
    --poster-quality 80 \
    --video-widths   1920 1280 854 640 428 \
    --video-bitrates 4500 2500 1300 800 400 \
    -- \
    ../dst/$session.mp4

