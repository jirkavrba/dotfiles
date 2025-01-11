#! /bin/bash

if hyprctl monitors all | grep -q "Monitor DP-1"; then
	echo "Connected, disabling built-in monitor"
	hyprctl keyword monitor eDP-1,disabled
	hyprctl keyword monitor DP-1,3840x2160,0x0,1
else
	echo "Not connected, enabling built-in monitor"
	hyprctl keyword monitor eDP-1,1920x1200,0x0,1
	hyprctl keyword monitor DP-1,disabled
fi

