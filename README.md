# dotfiles

My macOS shell, editor, and terminal config.

## What's here

- **`.zshrc`** — zsh + [oh-my-zsh](https://ohmyz.sh/) + [pure](https://github.com/sindresorhus/pure) prompt
- **`.vim/.vimrc`** — vim/nvim config, plugins managed by [vim-plug](https://github.com/junegunn/vim-plug)
- **`kitty.conf`** — [kitty](https://sw.kovidgoyal.net/kitty/) terminal config
- **`iterm_profiles/`** — iTerm2 colors and exported profile (legacy, kept around)
- **`setup.sh`** — idempotent installer for a fresh Mac

## Setup

```sh
git clone git@github.com:liamitus/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./setup.sh
```

Then open a new terminal (or `exec zsh`).

## Local overrides

Anything machine-specific or secret goes in `~/.localzsh`, which is sourced
from `.zshrc` if it exists and is gitignored.

```sh
# ~/.localzsh
export OPENAI_API_KEY=...
alias work="cd ~/dev/work-project"
```

## Updating vim plugins

Inside vim/nvim:

```
:PlugUpdate
```
