---
name: test
description: Send a test notification to verify wsl-notify-send is working
allowed-tools:
  - Bash
---

# Test WSL Desktop Notification

Send a test notification to verify the WSL notification system is working correctly.

## Instructions

1. Run the following command to test notifications:

```bash
wsl-notify-send.exe -c "Claude Code" "Test: WSL notifications are working!"
```

2. If the notification appears on Windows, report success to the user.

3. If the command fails with "command not found", inform the user they need to install wsl-notify-send:
   - Download from: https://github.com/stuartleeks/wsl-notify-send/releases
   - Extract `wsl-notify-send.exe` to a directory in Windows PATH (e.g., `C:\Windows\System32`)
   - Or add the directory containing it to PATH

4. Report the result clearly to the user.
