# If you come from bash you might have to change your $PATH.
export PATH="$HOME/bin:/usr/local/bin:$PATH"
export PATH="$HOME/dev/google-cloud-sdk/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/dev/scripts:$PATH"

export PYTHON_BIN_PATH="$(python3 -m site --user-base)/bin"
export PATH="$PATH:$PYTHON_BIN_PATH"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export GOPATH=~/dev/go
export PATH=$PATH:$GOPATH/bin

# Exports
export SYMBIONT_REPOS_PATH="$HOME/dev/"
export GOPATH="$HOME/go"
export SAILFISH_CONTRACT_PATH=~/dev/symbiont-node/src/stdlib:~/dev/private-equity/contracts:~/dev/symbiont-node/src/sailfish

# Local, non-git-committed exports
source ~/.dotfiles/.localzsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
ZSH_THEME="bullet-train"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh
source ~/.iterm2_shell_integration.zsh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
   export EDITOR='vim'
fi

# Compilation flags
 export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias zshconfig="v ~/.zshrc"
alias v=vim

# pip should only run if there is a virtualenv currently activated
export PIP_REQUIRE_VIRTUALENV=false

alias mt="cd $HOME/dev/go/src/github.com/liamitus/mercury-tax"
alias mtrun="mt && dev_appserver.py app/app.yaml"

#export DJANGO_SETTINGS_MODULE=app.settings
#alias si="cd ~/Workspace/seedinvest && source seedinvest/settings/local_environment.sh && source bin/activate"
#alias sis="si && ./manage.py shell_plus"
#alias cel='python manage.py celeryd -l info --settings=seedinvest.settings.local_settings_file_used'
#alias grun='grunt watch'
#alias tunnel='ssh -D 10013 ubuntu@ec2-54-208-139-18.compute-1.amazonaws.com'
#alias loadsi="si && source seedinvest/settings/local_environment.sh && memcached -d && (redis-server /usr/local/etc/redis.conf --daemonize yes) && (/usr/local/sbin/rabbitmq-server -detached)"
#alias run='python manage.py runserver --settings=seedinvest.settings.local_liam'
#alias si_swarm='python manage.py si_swarm --settings=seedinvest.settings.local_liam'
#alias test='python manage.py test seedinvest --settings=seedinvest.settings.local_test'
#alias mq=/usr/local/sbin/rabbitmq-server
#alias elasticsearch=/usr/local/bin/elasticsearch
#alias silocal="~/Workspace/scripts/start_local.sh iTerm2 liam"
#alias s='si && grunt prepare_statics'

alias pyclean="find . -name \*.pyc -delete"

# Symbiont-specific aliases
alias pe="cd ~/dev/private-equity"
alias sf="cd ~/dev/symbiont-node/src/sailfish && pyenv activate sailfish"
alias cb="cd ~/dev/symbiont-node/src/capybara"
alias sl="cd ~/dev/symbiont-node/src/stdlib && pyenv activate sailfish"
alias ass="cd ~/dev/assembly"
alias rundocker="docker run --name state-db -p 5432:5432 -d us.gcr.io/development-148212/txe-postgres:v3.0.0"

eval "$(hub alias -s)"

# fish-like autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

fortune | cowsay -f `cowsay -l | gsort -R | head -1` | lolcat

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/dev/gocloud/google-cloud-sdk/path.zsh.inc" ]; then source "$HOME/dev/gocloud/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/dev/gocloud/google-cloud-sdk/completion.zsh.inc" ]; then source "$HOME/dev/gocloud/google-cloud-sdk/completion.zsh.inc"; fi

#Pyenv setup
export PATH="~/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export GPG_TTY=$(tty)
