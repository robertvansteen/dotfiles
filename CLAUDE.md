# Dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/). Each top-level directory is a stow package that mirrors the target structure relative to `$HOME`.

## Structure

Each directory maps to `~/` via stow. For example, `zsh/.zshrc` → `~/.zshrc`, `nvim/.config/nvim/` → `~/.config/nvim/`.

| Package | What it configures |
|-|-|
| `aerospace` | AeroSpace tiling window manager |
| `ataman` | AtaMan keybindings (JetBrains) |
| `brewfile` | Homebrew packages and casks |
| `claude` | Claude Code settings and hooks |
| `gh-dash` | GitHub CLI dashboard |
| `git` | Git config, global gitignore |
| `ideavim` | IdeaVim config (JetBrains) |
| `kitty` | Kitty terminal (primary terminal) |
| `nvim` | Neovim (LazyVim framework) |
| `tmux` | Tmux config and custom scripts |
| `worktrunk` | WorkTrunk shell integration |
| `yazi` | Yazi file manager + catppuccin flavor |
| `zsh` | Zsh config (Oh-My-Zsh, aliases, plugins) |

## Key conventions

- **All edits go in `~/dotfiles/`**, never in the home directory. Stow symlinks make changes live automatically.
- **Theming**: Catppuccin Mocha everywhere (kitty, tmux, nvim, yazi).
- **Stow install**: `cd ~/dotfiles && stow --restow .` (or run `setup.sh`).
- **Brewfile**: Source of truth for CLI tools and casks. After adding a package, run `brew bundle --file=~/dotfiles/brewfile/Brewfile`.
- **Tmux prefix**: `Ctrl+Space`. Plugins managed by TPM (`prefix + I` to install).

## Shell setup (zsh)

- **Prompt**: Spaceship (with custom jj section, docker section removed)
- **Oh-My-Zsh plugins**: git, composer, aliases, gh, httpie, laravel, postgres, jj
- **Extra plugins** (via Homebrew): zsh-autosuggestions, zsh-syntax-highlighting
- **Tool inits**: fzf, zoxide, direnv, atuin, fnm (with `--use-on-cd`)
- **`y` function**: Wraps yazi to cd on quit
- **Aliases** are grouped by category: better defaults (eza/bat), docker, claude, tmux, misc

## Claude profiles

- `claudew` → work profile (`~/.claude-work`)
- `claudep` → personal profile (`~/.claude-personal`)
