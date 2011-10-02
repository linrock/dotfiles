nitrogen --restore &
xbindkeys &
unclutter -jitter 20 &
redshift -l 37.4:-122 -t 6000:4800 -m vidmode &
# xcompmgr -cCfF -r0 -D3 &
# urxvtd -q -f -o

xset r rate 160 65
xset m 0
xsetroot -cursor_name left_ptr
# xrandr --output Monitor1 --auto --right-of Monitor0

# exec awesome
exec xmonad
