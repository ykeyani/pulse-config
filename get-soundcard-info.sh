#!/usr/bin/env bash

# codec path
CODEC=/proc/asound/card1/codec#0

# find rates
cat $CODEC | grep rates | sort | uniq | sed -e 's/^[ \t]*//'
# find bits
cat $CODEC | grep bits | sort | uniq | sed -e 's/^[ \t]*//'
lscpu | grep "Byte Order"
# find buffer size
pactl list sinks | egrep 'buffer_size|fragment_size' | sed -e 's/^[ \t]*//'