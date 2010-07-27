#!/bin/sh

nitrogen --restore              # set backgrounds
unclutter -jitter 20 &          # hide inactive mouse
xcompmgr &                      # for compositing/transparency
xbindkeys &                     # custom hot keys
urxvtd -q -f                    # urxvt daemon

# parcellite &                    # clipboard management

xsetroot -cursor_name left_ptr  # use a real mouse pointer
xset r rate 200 50              # set keystroke repeat rate
xset m 0                        # disable mouse acceleration

exec xmonad
