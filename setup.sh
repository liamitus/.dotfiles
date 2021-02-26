# Set up my preferred local environment on mac.
#
# This script is idempotent.
#
# Run the set up process:
#
#   ./setup.sh
#

install_with_brew_cask=(

  # Terminal font
  font-source-code-pro

  # Kitty terminal. Uses GPU instead of CPU and is waaaaaay faster than iterm
  kitty

)

install_with_brew=(

  # gsort
  coreutils

  # Languages
  ruby

  # MOTD
  cowsay
  fortune
  lolcat

  # Python environment management
  pyenv
  pyenv-virtualenv

  # Ack-like grep but optimized for programmers
  the_silver_searcher
  fzf

  # Development helper
  ctags

  # Neovim
  neovim

)

if [ ! -f "`which brew`" ]; then
  echo "Installing homebrew..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Installing Oh-my-zsh..."
CHECK_ZSH_INSTALLED=$(grep /zsh$ /etc/shells | wc -l)
if [ ! $CHECK_ZSH_INSTALLED -ge 1 ]; then
	echo "* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *"
	echo "*                                                                       *"
	echo "*      Run this script twice if oh-my-zsh wasn't already installed      *"
	echo "*         because this next part will prevent the rest of the           *"
	echo "*                     of the setup from completing.                     *"
	echo "*                                                                       *"
	echo "* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *"
	sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  # Yes, really.
fi

echo "Tapping homebrew/cask-fonts..."
brew tap homebrew/cask-fonts

echo "Installing brew cask packages..."
for pkg in ${install_with_brew_cask[@]}; do
  if brew list --cask --versions $pkg > /dev/null; then
    echo "$pkg found in brew cask Cellar"
    brew uninstall $pkg
  fi
  echo "Installing $pkg..."
  brew cask install $pkg
done


echo "Installing brew packages..."
brew update
for pkg in ${install_with_brew[@]}; do
  if brew ls --versions $pkg > /dev/null; then
    echo "$pkg found in brew Cellar"
    brew reinstall $pkg
  else
    echo "Installing $pkg..."
    brew install $pkg
  fi
done


# Custom stuff not installed with brew

echo "Installing amplify..."
curl -sL https://aws-amplify.github.io/amplify-cli/install | bash

echo "Creating backup folders..."
mkdir -p ~/.backups/swaps
mkdir -p ~/.backups/undofiles
mkdir -p ~/.backups/backups

echo "Adding symlinks..."
ln -Fsv ~/.dotfiles/.zshrc ~/.zshrc
ln -Fsv ~/.dotfiles/.zsh ~/.zsh
ln -Fsv ~/.dotfiles/.vim ~/.vim
ln -Fsv ~/.dotfiles/.vim/.vimrc ~/.vimrc
ln -Fsv ~/.dotfiles/.zsh ~/.zsh
ln -Fsv ~/.dotfiles/.oh-my-zsh ~/.oh-my-zsh
ln -Fsv ~/.dotfiles/iterm_profiles ~/Documents/iterm_profiles
ln -Fsv ~/.dotfiles/kitty.conf ~/.config/kitty/kitty.conf 

echo "Installing custom fonts..."
rm -rf fonts
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

echo "Installing vim plugins..."
source ~/.dotfiles/.vim/update.sh all
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Creating vim backups directory..."
mkdir -p ~/.backups/swaps
mkdir -p ~/.backups/backups
mkdir -p ~/.backups/undofiles
 
echo "Sharing vim config with neovim..."
mkdir -p ~/.config/
ln -Fsv ~/.dotfiles/.vim ~/.config/nvim
ln -Fsv ~/.dotfiles/.vim/.vimrc ~/.config/nvim/init.vim

echo "Cleaning up..."
# Really not sure why these get created. I'm probably doing something stupid.
rm .vim/.vim
rm .oh-my-zsh/.oh-my-zsh
rm .zsh/.zsh
rm iterm_profiles/iterm_profiles

echo "
* * * * * * * * * * * * * * * * SETUP COMPLETE * * * * * * * * * * * * * * * * *
"
$SHELL
