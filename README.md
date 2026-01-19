# WSL Desktop Notifications for Claude Code

Send Windows desktop notifications from Claude Code running in WSL.

## Features

- **Task Complete**: Get notified when Claude finishes and is waiting for input
- **Permission Required**: Get notified when Claude needs your permission for a tool
- **Error Detection**: Get notified when a tool encounters an error

## Prerequisites

### 1. wsl-notify-send

You must install `wsl-notify-send` for this plugin to work:

1. Download the latest release from [wsl-notify-send releases](https://github.com/stuartleeks/wsl-notify-send/releases)
2. Extract `wsl-notify-send.exe`
3. Place it in a directory on your Windows PATH (e.g., `C:\Windows\System32`)
4. Verify installation from WSL:
   ```bash
   wsl-notify-send.exe "Hello from WSL"
   ```

### 2. jq (JSON parser)

The hook script uses `jq` to parse JSON input. Install if not present:

```bash
sudo apt install jq
```

## Installation

### Option 1: Local Plugin Directory

Copy this plugin to your Claude Code plugins directory:

```bash
cp -r claude-wsl-notifications ~/.claude/plugins/
```

### Option 2: Project Plugin

For project-specific use, place in your project's `.claude-plugin/` directory.

### Option 3: Test with --plugin-dir

```bash
claude --plugin-dir /path/to/claude-wsl-notifications
```

## Usage

Once installed, notifications are automatic:

- **Stop Hook**: Notifies "Claude is ready - Waiting for your input" when Claude completes a task
- **Permission Hook**: Notifies "Permission Required - Claude wants to use: [tool]" when in ask mode

### Test Command

Verify notifications work:

```
/wsl-notify:test
```

## Configuration

No configuration required. The plugin uses the "Claude Code" category for all notifications, which groups them in Windows Action Center.

## Troubleshooting

### Notifications not appearing

1. Verify `wsl-notify-send.exe` is in PATH:
   ```bash
   which wsl-notify-send.exe
   ```

2. Test manually:
   ```bash
   wsl-notify-send.exe "Test" "Message"
   ```

3. Check Windows notification settings - ensure notifications are enabled for WSL

### Permission notifications too frequent

The PreToolUse hook only fires when Claude Code is in "ask" permission mode. If you're using "allow" mode for trusted tools, permission notifications won't appear for those tools.

## How It Works

This plugin uses Claude Code hooks:

- **Stop Hook**: Triggers when Claude finishes its turn
- **PreToolUse Hook**: Triggers before tool execution, checks if permission will be requested

Both hooks call a shared bash script that invokes `wsl-notify-send.exe` with appropriate messages.

## License

MIT
