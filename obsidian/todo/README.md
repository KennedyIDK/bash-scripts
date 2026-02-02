# todo

Add items to a markdown todo table with urgency levels and status tracking. Can be used from the terminal or via a system-wide hotkey dialog (rofi or zenity).

## Usage

```bash
todo [OPTIONS] <item(s)>
```

### Options

```
-u <urgency>    Set urgency level (see shortcodes below)
-s <status>     Set status (0-9)
-v              Quickview todo file
-e              Open todo file in editor
-h              Show help message
```

### Urgency Shortcodes

| Code | Urgency     |
|------|-------------|
| a    | asap        |
| w    | week        |
| m    | month       |
| s    | season      |
| h    | six months  |
| y    | year        |
| e    | eventually  |

### Examples

```bash
todo Buy groceries                      # prompts for urgency
todo -u w Fix broken window             # urgency: week
todo -u a -s 3 Urgent task              # urgency: asap, status: 3
todo -u m Task 1, Task 2, Task 3        # multiple items
```

### Hotkey Usage

Bind the script to a system-wide hotkey. When triggered without arguments, a text input dialog appears. Flags can be included in the input:

```
Buy groceries -u w
Fix window -u a -s 2
```

## Dependencies

### External Commands

- rofi or zenity (for hotkey dialog, optional)
- notify-send (for notifications)

### Required Functions

- script_setup
- check_required_commands
- print_exit_code
- err
- warn
- deb
- trim_lead_trail_whitespace
- remove_duplicates_from_array
- extract_lines_between_markers

To install all required functions to `$HOME/bin/.functions`:

```bash
mkdir -p ~/bin/.functions && cd ~/bin/.functions && for func in script_setup check_required_commands print_exit_code err warn deb trim_lead_trail_whitespace remove_duplicates_from_array extract_lines_between_markers; do curl -sO https://raw.githubusercontent.com/KennedyIDK/bash-scripts/main/.functions/$func; done
```

## Installation

To install the script to `$HOME/bin`:

```bash
curl -o ~/bin/todo https://raw.githubusercontent.com/KennedyIDK/bash-scripts/main/obsidian/todo/todo && chmod u+x ~/bin/todo
```

## Configuration

### Variables

Edit the script to configure the following variables:

- `_TODO_FILE` - Path to your todo markdown file (default: `$HOME/notes/TODO.md`)
- `_DELIMITER` - Character used to separate multiple items (default: `,`)
- `_NOTIFICATION_ICON` - Path to notification icon
- `_NOTIFICATION_EXPIRE_TIME` - Notification display duration in milliseconds (default: `2000`)

### Todo File Format

The script expects a markdown file with a table structure:

```markdown
# To Do List

| Date       | Item          | Urgency | Status | Notes |
| ---------- | ------------- | ------- | ------ | ----- |
| 2024-01-15 | Example task  | week    | 0      |       |

<!-- End of Todo Table -->
```

Items are inserted at the top of the table and automatically sorted by urgency level.
