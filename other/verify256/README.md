# verify256

Compare SHA256 checksums from command line or file.

## Usage

```bash
verify256 <filename> <expected_sha256_sum|sum_file.txt>
```

### Options

```bash
-q, --quiet    Suppress output
```

### Examples

Compare with checksum provided directly:
```bash
verify256 file.txt 1234abcd5678ef90...
```

Compare with checksum from a file:
```bash
verify256 file.txt expected_sum.txt
```

Use quiet mode (exits with code 0 on success, 16 on mismatch):
```bash
verify256 -q file.txt checksum.txt
```

## Required Functions

- script_setup
- ansify_string
- check_required_commands
- print_exit_code
- err
- warn
- deb

To install all required functions to `$HOME/bin/.functions`:

```bash
mkdir -p ~/bin/.functions && cd ~/bin/.functions && for func in script_setup ansify_string check_required_commands print_exit_code err warn deb; do curl -sO https://raw.githubusercontent.com/KennedyIDK/bash-scripts/main/.functions/$func; done
```

## Installation

To install the script to `$HOME/bin`:

```bash
curl -o ~/bin/verify256 https://raw.githubusercontent.com/KennedyIDK/bash-scripts/main/other/verify256/verify256 && chmod u+x ~/bin/verify256
```
