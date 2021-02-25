# If you come from bash you might have to change your $PATH.
export PATH="$HOME/bin:/usr/local/bin:$PATH"
export PATH="$HOME/dev/google-cloud-sdk/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.pyenv/bin:$PATH"
export PATH="$HOME/.pyenv/versions/3.7.2/bin:$PATH"
export PATH="$HOME/dev/scripts:$PATH"
export PATH="$HOME/Applications/bin:$PATH"

#export PYTHON_BIN_PATH="$(python3 -m site --user-base)/bin"
#export PATH="$PATH:$PYTHON_BIN_PATH"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# This is to fix the Import psycopg2 Library not loaded: libssl.1.0.0.dylib error
export DYLD_FALLBACK_LIBRARY_PATH=/usr/local/Cellar/openssl/1.0.2t/lib

# Exports
export GOPATH="$HOME/go"
export PATH=$PATH:$GOPATH/bin

# Symbiont

export ASSEMBLY_CONTRACT_PATH=~/dev/private-equity/pe/contracts
export SYMBIONT_HOME="$HOME/dev/symbiont-node"
export SYMBIONT_REPOS_PATH="$HOME/dev/"
export DOCKER_REGISTRY_KEY_PATH="$HOME/dev/creds/docker-registry-key.yml"

export SYMBIONT_PACKAGE_DIR="$HOME/dev/symbiont-assembly-v3.3.1-mac"
#export SYMBIONT_HOME="$HOME/dev/symbiont-assembly-v3.3.1-mac"
export PATH="${SYMBIONT_PACKAGE_DIR}/bin:${PATH}"
export KUBECTL_VERSION=1.16.12
export KUSTOMIZE_VERSION=3.3.0

export KUBECONFIG=/Users/liamhowell/.secrets/alternative-assets-multi-dev-1.json
export KUBE_CONFIG_PATH=$KUBECONFIG

alias pe="cd ~/dev/private-equity && pipenv shell"
alias sf="cd ~/dev/symbiont-node/src/sailfish && pipenv shell"
alias cb="cd ~/dev/symbiont-node/src/capybara"
alias sl="cd ~/dev/symbiont-node/src/stdlib && pyenv activate sailfish"
alias ass="cd ~/dev/assembly"
alias rundocker="docker run --name state-db -p 5432:5432 -d us.gcr.io/development-148212/txe-postgres:v3.0.0"
alias txepgb="cd $SYMBIONT_HOME/src/postgres; docker build -t txe-postgres:herpaderp ."
alias txepgstart="docker run -it --rm -p 5432:5432 --name local-pg3 -d txe-postgres:herpaderp  -c shared_preload_libraries='pg_stat_statements' -c pg_stat_statements.track=all"

# Local, non-git-committed exports
if [ -f ~/.localzsh ]; then
  source ~/.localzsh
fi

# Projects

alias ml="cd ~/dev/moonlambo"
alias mt="cd $HOME/dev/go/src/github.com/liamitus/mercury-tax"
alias mtrun="mt && dev_appserver.py app/app.yaml"
alias ctags="`brew --prefix`/bin/ctags"
alias val='ssh -i "~/permissions/Desktop.pem" ubuntu@ec2-3-220-196-196.compute-1.amazonaws.com'

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
ZSH_THEME="bullet-train"

# Reset the prompt every second to update the clock
#TMOUT=1
#TRAPALRM() {
    #zle reset-prompt
#}

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
#if [ -f ~/.iterm2_shell_integration.zsh ]; then
  #source ~/.iterm2_shell_integration.zsh
#fi

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
   export EDITOR='nvim'
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
alias v=nvim

# pip should only run if there is a virtualenv currently activated
export PIP_REQUIRE_VIRTUALENV=false

alias pyclean="find . -name \*.pyc -delete"

# fish-like autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Print welcome message
fortune | cowsay -f `cowsay -l | tail -n +2 | xargs -n1 | gsort -R | head -1` | lolcat

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/dev/gocloud/google-cloud-sdk/path.zsh.inc" ]; then source "$HOME/dev/gocloud/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/dev/gocloud/google-cloud-sdk/completion.zsh.inc" ]; then source "$HOME/dev/gocloud/google-cloud-sdk/completion.zsh.inc"; fi

#Pyenv setup
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export GPG_TTY=$(tty)

if [ -n "$PYENV_COMMAND" ] && [ ! -x "$PYENV_COMMAND_PATH" ]; then
  versions=($(pyenv-whence "${PYENV_COMMAND}" 2>/dev/null || true))
  if [ -n "${versions}" ]; then
    if [ "${#versions[@]}" -gt 1 ]; then
      echo "pyenv-implicit: found multiple ${PYENV_COMMAND} in pyenv. Use version ${versions[0]}." 1>&2
    fi
    PYENV_COMMAND_PATH="${PYENV_ROOT}/versions/${versions[0]}/bin/${PYENV_COMMAND}"
  fi
fi

# Kitty
autoload -Uz compinit
compinit
# Completion for kitty
kitty + complete setup zsh | source /dev/stdin

# Added by Amplify CLI binary installer
export PATH="$HOME/.amplify/bin:$PATH"
