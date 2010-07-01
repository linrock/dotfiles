#!/bin/sh

nitrogen --restore              # set backgrounds
unclutter -jitter 20 &          # hide inactive mouse
xcompmgr &                      # for compositing/transparency
xbindkeys &                     # custom hot keys
urxvtd -q -f                    # urxvt daemon

# start_trayer.sh &               # a script to invoke trayer
# parcellite &                    # clipboard management
# xscreensaver -no-splash &       # start up xscreensaver

xsetroot -cursor_name left_ptr  # use a real mouse pointer
xset r rate 200 50              # set keystroke repeat rate
xset m 0                        # disable mouse acceleration

exec xmonad
