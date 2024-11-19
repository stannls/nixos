#!/bin/sh

# Force exit in case of error
#set -Eeou pipefail
#trap 'error_handler' ERR

error_handler() {
  echo "I/O error, script terminated"
}

main() {
  old_stat=''
  new_stat=''
  while true
  do
    player_status=$(playerctl -p spotify status 2> /dev/null)
    if [ "$player_status" = "Playing" ]; then
      new_stat="$(playerctl -p spotify metadata artist) - $(playerctl -p spotify metadata title)"
    elif [ "$player_status" = "Paused" ]; then
      new_stat=" $(playerctl -p spotify metadata artist) - $(playerctl -p spotify metadata title)"
    fi

    if [ "$new_stat" != "$old_stat" ]; then
      old_stat="$new_stat"
      echo "$new_stat"
    fi
    sleep 1
  done
}

main
