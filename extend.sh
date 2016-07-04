#!/bin/bash

SCALE=1.4

EXT=`xrandr --current | sed 's/^\(.*\) connected.*$/\1/p;d' | grep -v ^eDP | head -n 1`
INT=`xrandr --current | sed 's/^\(.*\) connected.*$/\1/p;d' | grep -v ^DP | head -n 1`

#ext_w=`xrandr | sed 's/^'"${EXT}"' [^0-9]* \([0-9]\+\)x.*$/\1/p;d'`
#ext_h=`xrandr | sed 's/^'"${EXT}"' [^0-9]* [0-9]\+x\([0-9]\+\).*$/\1/p;d'`

ext_w=`xrandr | grep -C1 ${EXT} | grep \* | cut -d' ' -f4 | cut -d'x' -f1`
ext_h=`xrandr | grep -C1 ${EXT} | grep \* | cut -d' ' -f4 | cut -d'x' -f2`

int_w=`xrandr | grep -C1 ${INT} | grep \* | cut -d' ' -f4 | cut -d'x' -f1`
int_h=`xrandr | grep -C1 ${INT} | grep \* | cut -d' ' -f4 | cut -d'x' -f2`

# off_w=`echo $(( ($int_w-$ext_w)/2 )) | sed 's/^-//'`

ext_w_scaled=`expr $ext_w*$SCALE/1 | bc`
ext_h_scaled=`expr $ext_h*$SCALE/1 | bc`

echo "ext_w : $ext_w"
echo "ext_w_scaled : $ext_w_scaled"
echo "ext_h : $ext_h"
echo "ext_h_scaled : $ext_h_scaled"
echo "int_w : $int_w"
echo "int_h : $int_h"
echo "xrandr --output eDP-1 --auto --pos 2520x0 --scale 1x1 --output DP-2 --auto --scale 1.5x1.5 --pos 0x0 --fb 5080x1600"
xrandr --output ${INT} --auto --pos ${ext_w_scaled}x0 --scale 1x1  --output ${EXT} --auto --scale ${SCALE}x${SCALE} --pos 0x0 --fb $((int_w + ext_w_scaled))x${int_h}
