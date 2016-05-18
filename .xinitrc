#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)
xcolor="neon"

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

[[ -f ~/.xcolors/$xcolor ]] && xrdb -merge ~/.xcolors/$xcolor
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

( /usr/bin/xcompmgr & )
( /usr/bin/redshift -l 48.139:11.566 -t 6500:2500 -m randr & )
( sh ~/.fehbg & )

# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice
exec xmonad
