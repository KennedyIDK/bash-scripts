# agent

A wrapper for [age](https://github.com/FiloSottile/age) that simplifies usage. Supports both key-based and password-based encryption, with options for bundling multiple files prior to encryption.

## Usage

```bash
agent [OPTIONS] <input_files>
```

### Options

```bash
    -b <bundle_name>   Bundle input files into a single file before encrypting
    -d                 Decrypt mode (default is encrypt)
    -p                 Use password-based encryption (default is key-based)
    -r                 Remove original file after successful encryption
    -q                 Quiet mode (no output to terminal)
    -h                 Show this help message
```

## External Commands

- [age](https://github.com/FiloSottile/age)

## Required Functions

- script_setup
- check_required_commands
- print_exit_code
- err
- warn
- deb
- ansify_string
- remove_duplicates_from_array

To install all required functions to `$HOME/bin/.functions`:

```bash
mkdir -p ~/bin/.functions && cd ~/bin/.functions && for func in script_setup ansify_string check_required_commands print_exit_code err warn deb remove_duplicates_from_array; do curl -sO https://raw.githubusercontent.com/KennedyIDK/bash-scripts/main/.functions/$func; done
```

## Installation

To install the script to `$HOME/bin`:

```bash
curl -o ~/bin/agent https://raw.githubusercontent.com/KennedyIDK/bash-scripts/main/other/agent/agent && chmod u+x ~/bin/agent
```

## Configuration

- Make sure you have `age` setup and have generated the required keys if you plan to use key based encryption.
- To use password based encryption instead, or by default, change the `_PASSWORD_MODE` variable to `true`.
- To remove the original file by default, rather than prompt the user, update the `_REMOVE_ORGINAL` variable to `true`.
- To suppress output messages by default update the `_QUIET_MODE` variable to `true`.
