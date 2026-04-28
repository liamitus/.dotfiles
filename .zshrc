# Homebrew (Apple Silicon at /opt/homebrew, Intel at /usr/local)
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# PATH
typeset -U path
path=(
  $HOME/bin
  $HOME/.local/bin
  $HOME/dev/scripts
  $HOME/Applications/bin
  $path
)

# Editor
export EDITOR=${${SSH_CONNECTION:+vim}:-nvim}
export LANG=en_US.UTF-8
export GPG_TTY=$(tty)

# Local, machine-specific overrides (not committed)
[[ -f ~/.localzsh ]] && source ~/.localzsh

# oh-my-zsh — pure handles the prompt, so no theme here
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
ENABLE_CORRECTION="true"
plugins=(
  git
  colored-man-pages
  command-not-found
)
source $ZSH/oh-my-zsh.sh

# Pure prompt — fast, minimal, works on light or dark terminals
fpath+=("$(brew --prefix)/share/zsh/site-functions")
autoload -U promptinit && promptinit
prompt pure

# zsh-autosuggestions (fish-like inline suggestions)
[[ -f $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && \
  source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Lazy-load nvm (slow to source eagerly)
export NVM_DIR="$HOME/.nvm"
nvm() {
  unfunction nvm
  [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
  [[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"
  nvm "$@"
}

# pyenv
if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init -)"
  command -v pyenv-virtualenv-init >/dev/null 2>&1 && eval "$(pyenv virtualenv-init -)"
fi

# Go
export GOPATH="$HOME/go"
path+=("$GOPATH/bin")

# Google Cloud SDK
if [[ -f "$HOME/dev/gocloud/google-cloud-sdk/path.zsh.inc" ]]; then
  source "$HOME/dev/gocloud/google-cloud-sdk/path.zsh.inc"
  source "$HOME/dev/gocloud/google-cloud-sdk/completion.zsh.inc"
fi

# Amplify CLI
[[ -d "$HOME/.amplify/bin" ]] && path+=("$HOME/.amplify/bin")

# ghcup (Haskell)
[[ -f "$HOME/.ghcup/env" ]] && source "$HOME/.ghcup/env"

# fzf — Ctrl+R history search, Ctrl+T file search, Alt+C cd
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh) 2>/dev/null
fi

# kitty completion
if command -v kitty >/dev/null 2>&1; then
  autoload -Uz compinit && compinit
  kitty + complete setup zsh | source /dev/stdin
fi

# Aliases
alias v=nvim
alias zshconfig="v ~/.zshrc"
alias pyclean="find . -name '*.pyc' -delete"
alias ml="cd ~/dev/moonlambo"
alias mt="cd $HOME/dev/go/src/github.com/liamitus/mercury-tax"
alias ctags="$(brew --prefix)/bin/ctags"

# pip outside a virtualenv is fine
export PIP_REQUIRE_VIRTUALENV=false

# Welcome message — interactive shells only, skip in CI/scripts/embedded shells
if [[ -o interactive && -z $CI && -z $CLAUDECODE ]]; then
  if (( $+commands[fortune] )) && (( $+commands[cowsay] )) && (( $+commands[lolcat] )); then
    fortune | cowsay -f $(cowsay -l | tail -n +2 | tr ' ' '\n' | gsort -R | head -1) | lolcat
  fi
fi

# zsh-syntax-highlighting must be sourced last
[[ -f $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && \
  source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
