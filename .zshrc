export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="minimal"

plugins=(git)

[ -s "$ZSH/oh-my-zsh.sh" ] && source $ZSH/oh-my-zsh.sh

# User configuration

alias config='/usr/bin/git --git-dir=/Users/anthonydugarte/.cfg/ --work-tree=/Users/anthonydugarte'

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# Custom scripts
[ -s "$HOME/bin" ] && export PATH=$HOME/bin:$PATH

# Add autoload of bash commands completition
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit

# Add AWS CLI Completition
[[ $commands[aws_completer] ]] && complete -C 'aws_completer' aws

# Android
export ANDROID_HOME=$HOME/Library/Android/sdk
[ -s "$ANDROID_HOME" ] && export PATH="$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH"

# Add rbenv
[[ $commands[rbenv] ]] && eval "$(rbenv init - zsh)"

# zsh completition path
fpath=(~/.zsh/completion $fpath)

# zsh start compinit
autoload -Uz compinit && compinit -i

# LLVM
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib -L/opt/homebrew/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include  -I/opt/homebrew/include"
[ -s "/opt/homebrew/opt/llvm/bin" ] && export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

# Python
export PATH="/Users/anthonydugarte/Library/Python/3.9/bin:$PATH"

# PSQL
export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"

# Love
alias love="/Applications/love.app/Contents/MacOS/love"

# Ogre
export OGRE_DIR="$HOME/Code/ogre/dist/sdk"

# Kubectl
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)
[[ $commands[helm] ]] && source <(helm completion zsh)

# Golang
[[ $commands[go] ]] && export PATH="$PATH:$(go env GOPATH)/bin"

export PATH="/usr/local/smlnj/bin:$PATH"

# k8s krew plugin manager
[ -s "$HOME/.krew" ] && export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

