# shoplist

Add items to shopping list using a system-wide hotkey. Displays a text input dialog (rofi or zenity) and appends items as markdown checkboxes to your shopping list file.

## Usage

Bind the script to a system-wide hotkey in your window manager or desktop environment. When triggered, a text input dialog appears. Enter one or more items separated by commas and press Enter.

### Input Format

- Single item: `milk`
- Multiple items: `milk, bread, eggs`

## Dependencies

### External Commands

- rofi or zenity (for input dialog)
- notify-send (for notifications)

### Required Functions

- script_setup
- check_required_commands
- print_exit_code
- err
- warn
- deb
- remove_duplicates_from_array
- reverse_array
- trim_lead_trail_whitespace

To install all required functions to `$HOME/bin/.functions`:

```bash
mkdir -p ~/bin/.functions && cd ~/bin/.functions && for func in script_setup check_required_commands print_exit_code err warn deb remove_duplicates_from_array reverse_array trim_lead_trail_whitespace; do curl -sO https://raw.githubusercontent.com/KennedyIDK/bash-scripts/main/.functions/$func; done
```

## Installation

To install the script to `$HOME/bin/obsidian`:

```bash
mkdir -p ~/bin/obsidian && curl -o ~/bin/obsidian/shoplist https://raw.githubusercontent.com/KennedyIDK/bash-scripts/main/obsidian/shoplist/shoplist && chmod u+x ~/bin/obsidian/shoplist
```

## Configuration

### Variables

Edit the script to configure the following variables:

- `_SHOPLIST_FILE` - Path to your shopping list markdown file (default: `$HOME/notes/SHOP.md`)
- `_INPUT_DELIMITER` - Character used to separate multiple items (default: `,`)
- `_NOTIFICATION_ICON` - Path to notification icon (optional)
- `_NOTIFICATION_EXPIRE_TIME` - Notification display duration in milliseconds (default: `2000`)

### Shopping List File Format

The script looks for a `## Shopping List` header in your markdown file and inserts items directly below it as checkbox list items:

```markdown
## Shopping List

- [ ] eggs
- [ ] bread
- [ ] milk
```
