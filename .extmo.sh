#!/usr/bin/env sh
if xrandr | grep -qs "VGA1\ connected"; then
	xrandr --output VGA1 --right-of LVDS1 --auto
	sh ~/.fehbg
else
	xrandr --auto
	sh ~/.fehbg
fi
