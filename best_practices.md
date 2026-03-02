# Bash Best Practices

## Naming Conventions

### Function Naming

- Use `snake_case` consistently (you already do this - good!)
- Add a consistent verb prefix per module:
  - `spellpouch_*` for functions meant to be called via spellpouch
  - `ls_install_*` or `install_ls_*` for language server functions
  - `runtime_install_*` for runtime installation functions

### Current Inconsistencies

| Module | Current Pattern | Recommended |
|--------|-----------------|-------------|
| `runtime.sh` | `erlang_elixir()`, `python()` | `runtime_install_erlang_elixir()`, `runtime_install_python()` |
| `language_server.sh` | `install_elixir_ls()` | Already good, be consistent with `ls_install_*` |
| `emacs_manager.sh` | `download_src()`, `build_src()` | Good - keep using action verbs |
| `tree_sitter.sh` | `find_tree_sitter_version()` | Good - keep `find_` prefix |

## Directory Handling

### Problem

Using `cd` without saving/restoring location leaves shell in different directory:

```bash
cd "${emacs_src_dir}/emacs-${version}/"  # Leaves shell in different directory
```

### Solution

Use subshells or save/restore:

```bash
# Option 1: Subshell (recommended for isolated commands)
(cd "${emacs_src_dir}/emacs-${version}/" && ./configure ...)

# Option 2: Save and restore
pushd "${emacs_src_dir}/emacs-${version}/" > /dev/null
./configure
popd > /dev/null
```

## Sourcing

### Problem

Sourcing full bashrc can cause issues:

```bash
source ~/.bashrc  # BAD - loads full shell config, can cause unexpected behavior
```

### Solution

Source only what you need:

```bash
# For asdf
source "$HOME/.asdf/asdf.sh" 2>/dev/null || true

# Or rely on PATH and verify commands exist
if ! command -v asdf &> /dev/null; then
    echo "asdf not found"
    return 1
fi
```

## Error Handling

### Current Issues

- Inconsistent use of `return 1`, `exit 0`, or nothing
- Some functions don't report failures

### Recommendation

```bash
# Use return codes consistently
function my_function() {
    local result=0
    
    if ! some_command; then
        echo "Error: something failed" >&2
        return 1
    fi
    
    return 0
}

# Check return values properly
if ! my_function; then
    echo "Function failed"
fi
```

## Variable Handling

### Problem

Declaring `local` but using variable globally:

```bash
local OPTIND opt _pouch wd=$(pwd)  # wd used globally after local declaration
```

### Solution

Be explicit about scope:

```bash
local wd
wd=$(pwd)  # Or use subshell to avoid polluting global scope
```

## Hardcoded Values

### Problem

Values like tree-sitter version hardcoded in multiple places:

```bash
tree_sitter_version="0.25.10"  # Magic number
```

### Solution

Use constants or configuration:

```bash
declare -r TREE_SITTER_VERSION_29_4="0.25.10"
```

## Colors

### Problem

Repeated ANSI escape codes:

```bash
echo -e "\033[31m Error message\e[m"
```

### Solution

Define color variables:

```bash
declare -r RED='\033[0;31m'
declare -r NC='\033[0m' # No Color

echo -e "${RED}Error message${NC}"
```

## ShellCheck

Consider running [ShellCheck](https://www.shellcheck.net/) on your scripts:

```bash
shellcheck spells/*.sh reagents/*/*.sh
```

This will catch many common issues automatically.