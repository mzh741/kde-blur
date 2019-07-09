 
#! /bin/bash
while true; do
sleep 0.5
a=$(xprop -id $(xprop -root _NET_ACTIVE_WINDOW | cut -d ' ' -f 5) WM_NAME | sed -e 's/.*"\(.*\)".*/\1/')

# can have more ids for the same window name!
ids=$(xdotool search -name "$a")
id_arr=($(echo $ids | tr " " "\n"))

for id in "${id_arr[@]}" 
do
xprop -id "$id" -f _KDE_NET_WM_BLUR_BEHIND_REGION 32c -set _KDE_NET_WM_BLUR_BEHIND_REGION 0
done

set -u
done
