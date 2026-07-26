#!/usr/bin/env bash
##
##  Agentic Software Engineering (ASE)
##  Copyright (c) 2025-2026 Dr. Ralf S. Engelschall <rse@engelschall.com>
##  Licensed under GPL 3.0 <https://spdx.org/licenses/GPL-3.0-only>
##

#   take over session argument
session="$1"

#   generate the session recording script
npx -y --package @rse/nunjucks-cli -p @rse/nunjucks-addons -- nunjucks -o $session.tape $session.tape.njk

#   record the session
vhs $session.tape

#   remove the session recording script
rm -f $session.tape

#   preserve the MP4 video format
ffmpeg -i $session.mp4 -filter:v "setpts=0.5*PTS" -y ../dst/$session.mp4

#   generate the HLS video and JPG poster formats
video2hls \
    --output ../dst/$session.hls \
    --output-overwrite \
    --hls-type fmp4 \
    --no-mp4 \
    --no-audio \
    --poster-quality 80 \
    --poster-seek 20s \
    --ratio 1200:1400 \
    --video-widths   1200  600 \
    --video-bitrates 2000 1000 \
    -- \
    ../dst/$session.mp4

#   move poster format to final location
mv ../dst/$session.hls/poster.jpg \
   ../dst/$session.jpg

