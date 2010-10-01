#!/bin/sh

nitrogen --restore              # set backgrounds
unclutter -jitter 20 &          # hide inactive mouse
xcompmgr -Ff -D4.2 &            # for compositing/transparency
xbindkeys &                     # custom hot keys
urxvtd -q -f -o

xsetroot -cursor_name left_ptr  # use a real mouse pointer
xset r rate 175 60              # set keystroke repeat rate
xset m 0                        # disable mouse acceleration

exec xmonad
