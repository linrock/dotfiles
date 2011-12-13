nitrogen --restore &
xbindkeys &
unclutter -jitter 20 &
trayer --edge bottom --align right --SetDockType true --SetPartialStrut true --width 8 --height 23 --transparent true --alpha 0 --tint 0x000000 --expand true --monitor 0 &
# redshift -l 37.4:-122 -t 6000:4800 -m vidmode &
# xcompmgr -cCfF -r0 -D3 &
# urxvtd -q -f -o

xset r rate 160 65
xset m 0
xsetroot -cursor_name left_ptr
# xrandr --output Monitor1 --auto --right-of Monitor0

# exec awesome
exec xmonad
