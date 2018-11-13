# Set up my preferred local environment on mac.
#
# This script is idempotent.
#
# Run the set up process:
#
#   ./setup.sh
#

install_with_brew=(

  # Languages
  ruby

  # Makes rainbow text
  lolcat

  # Python environment management
  pyenv
  pyenv-virtualenv

  # Ack-like grep but optimized for programmers
  the_silver_searcher
  fzf

)

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

echo "Installing brew packages..."
for pkg in ${install_with_brew[@]}; do
  if brew ls --versions $pkg > /dev/null; then
    echo "$pkg found in brew Cellar"
  else
    echo "Installing $pkg..."
    brew install $pkg
  fi
done

# Custom stuff not installed with brew

echo "Adding symlinks..."
ln -Fsv ~/.dotfiles/.zshrc ~/.zshrc
ln -Fsv ~/.dotfiles/.zsh ~/.zsh
ln -Fsv ~/.dotfiles/.vim ~/.vim
ln -Fsv ~/.dotfiles/.vim/.vimrc ~/.vimrc
ln -Fsv ~/.dotfiles/.zsh ~/.zsh
ln -Fsv ~/.dotfiles/.oh-my-zsh ~/.oh-my-zsh
ln -Fsv ~/.dotfiles/iterm_profiles ~/Documents/iterm_profiles

echo "Installing custom fonts..."
rm -rf fonts
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

echo "Installing vim plugins..."
source ~/.dotfiles/.vim/update.sh all

echo "
Reload the shell with:

source ~/.zshrc

Or open a new shell window
"
