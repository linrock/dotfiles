#!/bin/sh

nitrogen --restore              # set backgrounds
xcompmgr &                      # for compositing/transparency
urxvtd -q -f                    # urxvt daemon

xset r rate 200 45              # set keystroke repeat rate
xset m 0                        # disable mouse acceleration
xsetroot -cursor_name left_ptr  # use a real mouse pointer

# exec xterm
# exec gnome-session
# exec startkde
# exec startxfce4
# exec openbox-session
exec xmonad
