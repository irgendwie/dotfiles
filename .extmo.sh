#!/usr/bin/env sh
if xrandr | grep -qs "VGA1\ connected"; then
	xrandr --output VGA1 --left-of LVDS1 --mode 1024x768
	sh ~/.fehbg
else
	xrandr --auto
	sh ~/.fehbg
fi
