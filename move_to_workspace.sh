#!/bin/bash

direction="$1"

# Validate direction argument
if [[ "$direction" != "+" && "$direction" != "-" ]]; then
  echo "Invalid argument, use + for next workspace or - for previous one"
  exit 1
fi

# Validate active window
current_window_address=$(hyprctl activewindow -j | jq -r '.address')
if [[ "$current_window_address" == "null" ]]; then
  echo "No active window"
  exit 1
fi

# Get current workspace name
current_workspace_name=$(hyprctl activeworkspace -j | jq -r '.name')

### START USER CHANGE - WORKSPACES LIST
workspaces=("main" "gaming" "coding" "terminal" "media") # your workspaces e.g. ("main" "gaming" "coding")
### END   USER CHANGE

count=${#workspaces[@]}

index=-1
for i in "${!workspaces[@]}"; do
  if [[ "${workspaces[$i]}" == "$current_workspace_name" ]]; then
    index=$i
    break
  fi
done

if [[ $index -lt 0 ]]; then
  echo "Invalid workspace index: $index, should be >= 0"
  exit 1
fi

if [[ "$direction" == "+" ]]; then
  next=$(( (index + 1) % count ))
else
  next=$(( (index - 1 + count) % count ))
fi

target_workspace_name="${workspaces[$next]}"

# Change to target workspace, it ensures us that the workspace is open
hyprctl dispatch workspace "name:$target_workspace_name"

# Move window to target workspace
hyprctl dispatch movetoworkspace "name:$target_workspace_name","address:$current_window_address"
