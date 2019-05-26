#!/bin/sh
wmctrl -l | cut -c 1-10 >> ~/xporp/cmd
cat ~/xporp/cmd | while read line
do
    xprop -f _KDE_NET_WM_BLUR_BEHIND_REGION 32c -set _KDE_NET_WM_BLUR_BEHIND_REGION 0 -id $line
done
