#!/usr/bin/env bash

for card in /proc/asound/card[0-9]
do
#  echo -n "card: ";  cat $card/id
  for codec in $card/codec#[0-9]
  do
    cat $codec | grep Codec
    cat $codec | grep rates | sort | uniq | sed -e 's/^[ \t]*//'
    cat $codec | grep bits | sort | uniq | sed -e 's/^[ \t]*//'
  done
done

lscpu | grep "Byte Order"
# find buffer size
pactl list sinks | egrep 'buffer_size|fragment_size' | sed -e 's/^[ \t]*//'