# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="minimal"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# Export custom scripts
export PATH=$HOME/bin:$PATH

# Add autoload of bash commands completition
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit

# Add AWS CLI Completition
[[ $commands[aws_completer] ]] && complete -C 'aws_completer' aws

# Android
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH="$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH"

# Add rbenv
eval "$(rbenv init - zsh)"

# zsh completition path
fpath=(~/.zsh/completion $fpath)
# zsh start compinit
autoload -Uz compinit && compinit -i

# LLVM
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib -L/opt/homebrew/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include  -I/opt/homebrew/include"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

# Python
export PATH="/Users/anthonydugarte/Library/Python/3.9/bin:$PATH"

# PSQL
export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"

# Love
alias love="/Applications/love.app/Contents/MacOS/love"

export OGRE_DIR="$HOME/Code/ogre/dist/sdk"

[[ $commands[kubectl] ]] && source <(kubectl completion zsh)
[[ $commands[helm] ]] && source <(helm completion zsh)

# Golang
[[ $commands[go] ]] && export PATH="$PATH:$(go env GOPATH)/bin"

