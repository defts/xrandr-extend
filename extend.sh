#!/bin/bash

SCALE=1.4

EXT=`xrandr --current | sed 's/^\(.*\) connected.*$/\1/p;d' | grep -v ^eDP | head -n 1`
INT=`xrandr --current | sed 's/^\(.*\) connected.*$/\1/p;d' | grep -v ^DP | head -n 1`

# ext_w=`xrandr | sed 's/^'"${EXT}"' [^0-9]* \([0-9]\+\)x.*$/\1/p;d'`
# ext_h=`xrandr | sed 's/^'"${EXT}"' [^0-9]* [0-9]\+x\([0-9]\+\).*$/\1/p;d'`

ext_w=`xrandr | grep -C1 ${EXT} | grep \* | cut -d' ' -f4 | cut -d'x' -f1`
ext_h=`xrandr | grep -C1 ${EXT} | grep \* | cut -d' ' -f4 | cut -d'x' -f2`

int_w=`xrandr | grep -C1 ${INT} | grep \* | cut -d' ' -f4 | cut -d'x' -f1`
int_h=`xrandr | grep -C1 ${INT} | grep \* | cut -d' ' -f4 | cut -d'x' -f2`

ext_w_scaled=`expr $ext_w*$SCALE/1 | bc`
ext_h_scaled=`expr $ext_h*$SCALE/1 | bc`

# echo "ext_w : $ext_w"
# echo "ext_w_scaled : $ext_w_scaled"
# echo "ext_h : $ext_h"
# echo "ext_h_scaled : $ext_h_scaled"
# echo "int_w : $int_w"
# echo "int_h : $int_h"

xrandr --output ${INT} --auto --pos ${ext_w_scaled}x0 --scale 1x1  --output ${EXT} --auto --scale ${SCALE}x${SCALE} --pos 0x0 --fb $((int_w + ext_w_scaled))x${int_h}
