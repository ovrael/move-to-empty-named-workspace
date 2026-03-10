# Move to empty named workspace
Simple script for Hyprland to move current active window for named workspace, even though if it's empty.

# Update script!

You should edit the script with your named workspaces.

> Line 22

```ini
workspaces=() # your workspaces e.g. ("main" "gaming" "coding")
```

### My workspaces example

```ini
workspaces=("main" "gaming" "coding" "terminal" "media")
```


# Remember
Make it executable:

```bash
chmod +x ./move_to_workspace.sh
``` 

to be able to use it!


# Usage

Script takes 1 argument, single character:

\+ for the next workspace

\- for the previous workspace


> Script can be used in Hyprland as below:

### My hyprland config example

```ini
bind = $mainMod SHIFT, right, exec, ~/.config/hypr/scripts/move_to_workspace.sh +
bind = $mainMod SHIFT, left, exec, ~/.config/hypr/scripts/move_to_workspace.sh -
```

