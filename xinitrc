xcompmgr -fF -D 4.2 &
nitrogen --restore &
xbindkeys &
unclutter -jitter 20 &
urxvtd -q -f -o

xset r rate 200 50
xset m 0
xsetroot -cursor_name left_ptr
# xrandr --output Monitor1 --auto --right-of Monitor0 

exec xmonad
