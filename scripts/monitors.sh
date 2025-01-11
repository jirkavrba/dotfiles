#! /bin/bash


configure_monitors() {
	if hyprctl monitors all | grep -q "Monitor DP-1"; then
		echo "Connected, disabling built-in monitor"
		hyprctl keyword monitor eDP-1,disabled
		hyprctl keyword monitor DP-1,3840x2160,0x0,1
	else
		echo "Not connected, enabling built-in monitor"
		hyprctl keyword monitor eDP-1,1920x1200,0x0,1
		hyprctl keyword monitor DP-1,disabled
	fi
}

handle_ipc_message() {
  echo "Received message: $1";

  case $1 in
    monitoradded*) configure_monitors ;;
    monitorremoved*) configure_monitors ;;
  esac
}

handle_ipc_message "monitoradded"

socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle_ipc_message "$line"; done
