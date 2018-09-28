MY_PATH="`dirname \"$0\"`"

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
fi

if brew ls --versions ruby > /dev/null; then
	echo "Ruby found in Cellar"
else
	echo "Installing Ruby..."
	brew install ruby
fi

echo "Installing lolcat..."
gem install lolcat

echo "Installing pyenv..."
brew install pyenv
brew install --HEAD pyenv-virtualenv

echo "Adding symlinks..."
ln -Fsv ~/.dotfiles/.zshrc ~/.zshrc
ln -Fsv ~/.dotfiles/.zsh ~/.zsh
ln -Fsv ~/.dotfiles/.vim ~/.vim
ln -Fsv ~/.dotfiles/.vim/.vimrc ~/.vimrc
ln -Fsv ~/.dotfiles/.zsh ~/.zsh
ln -Fsv ~/.dotfiles/.oh-my-zsh ~/.oh-my-zsh
ln -Fsv ~/.dotfiles/iterm_profiles ~/Documents/iterm_profiles

echo "Installing custom fonts..."
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

echo "Installing vim plugins..."
source ~/.dotfiles/.vim/update.sh all

echo "Reload the shell from zshrc..."
source ~/.zshrc
