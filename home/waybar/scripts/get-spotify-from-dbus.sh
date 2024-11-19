#!/bin/sh
# A little script to fetch current playing song from spotify

base_bus="gdbus introspect -r --session -o / --only-properties -d org.mpris.MediaPlayer2.spotify"
running=`$base_bus | grep -Eo 'PlaybackStatus\s=\s.(Playing|Paused).;'`

if [[ $running ]]; then
    metadata="$base_bus | grep 'Metadata'"
    song=`$metadata | grep -Eo 'title.:\s<[^,]+>' | grep -Eo '<.+>'`
    artist=`$metadata | grep -Eo 'artist.:\s<[^,]+>' | grep -Eo '<.+>'`
    echo "🎶  ${song:2:-2} - ${artist:3:-3}"
else
    echo "🎶  Spotify is not running."
fi
