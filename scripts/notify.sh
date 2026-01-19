#!/bin/bash
# WSL Desktop Notification Script for Claude Code
# Sends Windows toast notifications using wsl-notify-send

set -euo pipefail

# Find wsl-notify-send.exe - check PATH first, then common locations
WSL_NOTIFY=""
if command -v wsl-notify-send.exe &> /dev/null; then
    WSL_NOTIFY="wsl-notify-send.exe"
elif [[ -x "/mnt/c/Users/geg42/bin/wsl-notify-send.exe" ]]; then
    WSL_NOTIFY="/mnt/c/Users/geg42/bin/wsl-notify-send.exe"
else
    echo "wsl-notify-send.exe not found" >&2
    exit 0  # Exit silently to not block Claude
fi

# Check if jq is available (needed to parse hook input)
if ! command -v jq &> /dev/null; then
    echo "jq not found - install with: sudo apt install jq" >&2
    exit 0  # Exit silently to not block Claude
fi

# Read JSON input from stdin
input=$(cat)

# Parse hook event name
hook_event=$(echo "$input" | jq -r '.hook_event_name // "unknown"')

case "$hook_event" in
    "Stop")
        "$WSL_NOTIFY" -c "Claude Code" "Claude is ready - Waiting for your input"
        ;;
    "PreToolUse")
        # Only notify if permission mode is "ask" (user will be prompted)
        permission_mode=$(echo "$input" | jq -r '.permission_mode // "allow"')
        if [[ "$permission_mode" == "ask" ]]; then
            tool_name=$(echo "$input" | jq -r '.tool_name // "unknown tool"')
            "$WSL_NOTIFY" -c "Claude Code" "Permission Required: $tool_name"
        fi
        ;;
    *)
        # Unknown event, do nothing
        ;;
esac

exit 0
