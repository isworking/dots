#!/usr/bin/env bash

# Author: Heavily rewritten by ChatGPT (from @sejjy's script)
# Purpose: Rofi-based volume controller using pactl

# Rofi config
config="$HOME/.config/rofi/volume-menu.rasi"

# Get current default sink
default_sink=$(pactl get-default-sink)

# Get current volume and mute status
volume_info=$(pactl get-sink-volume "$default_sink" | awk '{print $5}')
mute_status=$(pactl get-sink-mute "$default_sink" | awk '{print $2}')

# Convert volume to number
volume_num=$(echo "$volume_info" | tr -d '%')

# Icon logic
get_volume_icon() {
  if [[ "$mute_status" == "yes" ]]; then
    echo "󰝟 Muted"
  elif [[ "$volume_num" -eq 0 ]]; then
    echo "󰝟 0%"
  elif [[ "$volume_num" -le 30 ]]; then
    echo "󰕿 $volume_info"
  elif [[ "$volume_num" -le 70 ]]; then
    echo "󰖀 $volume_info"
  else
    echo "󰕾 $volume_info"
  fi
}

# Menu options
options=$(
  echo "󰝝  Volume Up"
  echo "󰝞  Volume Down"
  echo "󰖁  Toggle Mute"
  echo "$(get_volume_icon)"
)

# Show rofi menu
selected=$(echo -e "$options" | rofi -dmenu -i -config "$config" -p "🔊 Volume" || exit)

case "$selected" in
  *"Volume Up"*)
    pactl set-sink-volume "$default_sink" +5%
    ;;
  *"Volume Down"*)
    pactl set-sink-volume "$default_sink" -5%
    ;;
  *"Toggle Mute"*)
    pactl set-sink-mute "$default_sink" toggle
    ;;
  *)
    exit
    ;;
esac

# Optionally redisplay menu (loop)
exec "$0"
