#!/usr/bin/env bash
#
# Set up my preferred local environment on macOS.
#
# Idempotent: safe to run multiple times.
#
#   ./setup.sh
#
set -euo pipefail

DOTFILES="$HOME/.dotfiles"

casks=(
  font-fira-code-nerd-font
  kitty
)

brews=(
  coreutils            # GNU utils (gsort, etc.)
  cowsay
  fortune
  lolcat
  pure                 # the zsh prompt
  zsh-autosuggestions  # fish-like inline suggestions
  zsh-syntax-highlighting
  pyenv
  pyenv-virtualenv
  fzf
  the_silver_searcher  # ag
  ctags
  neovim
)

# --- Homebrew ----------------------------------------------------------------

if ! command -v brew >/dev/null 2>&1; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Make sure brew is on PATH for the rest of this script (Apple Silicon vs Intel)
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# --- oh-my-zsh ---------------------------------------------------------------

if [[ ! -d "$DOTFILES/.oh-my-zsh" ]]; then
  echo "Installing oh-my-zsh..."
  RUNZSH=no KEEP_ZSHRC=yes ZSH="$DOTFILES/.oh-my-zsh" \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# --- Brew packages -----------------------------------------------------------

echo "Installing casks..."
brew install --cask "${casks[@]}" 2>&1 | grep -v "already installed" || true

echo "Updating Homebrew..."
brew update

echo "Installing formulae..."
brew install "${brews[@]}" 2>&1 | grep -v "already installed" || true

# --- Symlinks ----------------------------------------------------------------

echo "Linking config files..."

mkdir -p ~/.config/kitty ~/.config/nvim ~/Documents

# -h prevents following an existing symlink at the destination (otherwise
# ln writes inside the linked dir and creates a self-referential symlink).
link() {
  local src=$1 dst=$2
  ln -Fhsv "$src" "$dst"
}

link "$DOTFILES/.zshrc"      ~/.zshrc
link "$DOTFILES/.vim"        ~/.vim
link "$DOTFILES/.vim/.vimrc" ~/.vimrc
link "$DOTFILES/.vim"        ~/.config/nvim
link "$DOTFILES/.vim/.vimrc" ~/.config/nvim/init.vim
link "$DOTFILES/.oh-my-zsh"  ~/.oh-my-zsh
link "$DOTFILES/kitty.conf"  ~/.config/kitty/kitty.conf
link "$DOTFILES/iterm_profiles" ~/Documents/iterm_profiles

# --- Backup directories used by vim ------------------------------------------

mkdir -p ~/.backups/{swaps,backups,undofiles}

# --- vim-plug + plugins ------------------------------------------------------

if [[ ! -f ~/.vim/autoload/plug.vim ]]; then
  echo "Installing vim-plug..."
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

if [[ ! -f ~/.local/share/nvim/site/autoload/plug.vim ]]; then
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

echo "Installing vim plugins..."
nvim --headless +PlugInstall +qall 2>/dev/null || vim +PlugInstall +qall

echo
echo "* * * * * * * * * * * * * * * * SETUP COMPLETE * * * * * * * * * * * * * * * * *"
echo
echo "Open a new terminal or run: exec zsh"
