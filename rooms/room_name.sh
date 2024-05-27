#!/usr/bin/env bash
# This list out all room name from available rooms in this folder and output it into room_name.txt
# Please run this using Bash. If you are on Windows, install WSL.

shopt -s extglob
file_name="room_name.txt"

for room in *; do
  if [[ "$room" == *.tscn ]]; then
    num=${room//[^0-9]/}
    [[ $num -lt 10 ]] && num="0${num}"
    echo "$num: $(cat $room | grep "room_name = " | sed 's/room_name = //g;s/\"//g')" >> .tmp
  fi
done

cat .tmp | sort > ${file_name}
rm -f .tmp

less ${file_name}
