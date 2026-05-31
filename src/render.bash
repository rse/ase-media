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
    --no-mp4 \
    --no-audio \
    --poster-quality 80 \
    --ratio 1200:1400 \
    --video-widths   1200  600 \
    --video-bitrates 2000 1000 \
    -- \
    ../dst/$session.mp4

mv ../dst/$session.hls/poster.jpg \
   ../dst/$session.jpg

