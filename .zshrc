# zmodload zsh/zprof

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="minimal"

[[ $commands[brew] ]] && NVM_HOMEBREW=$(brew --prefix nvm)

zstyle ':omz:update' frequency 7

zstyle ':omz:plugins:nvm' lazy yes

zstyle ':omz:plugins:aws' lazy yes
zstyle ':omz:plugins:rbenv' lazy yes
zstyle ':omz:plugins:helm' lazy yes
zstyle ':omz:plugins:kubectl' lazy yes
zstyle ':omz:plugins:helm' lazy yes
zstyle ':omz:plugins:git' lazy yes


# Force the plugin to load when using nvim
zstyle ':omz:plugins:nvm' lazy-cmd nvim

plugins=(
        git
        nvm
        aws
        rbenv
        kubectl
        helm
)

fpath=(~/.zsh/completion $fpath)

[ -s "$ZSH/oh-my-zsh.sh" ] && source $ZSH/oh-my-zsh.sh

# User configuration

alias config='/usr/bin/git --git-dir=/Users/anthonydugarte/.cfg/ --work-tree=/Users/anthonydugarte'

# Custom scripts
[ -s "$HOME/bin" ] && export PATH=$HOME/bin:$PATH

# Android
export ANDROID_HOME=$HOME/Library/Android/sdk
[ -s "$ANDROID_HOME" ] && export PATH="$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH"

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

# Golang
[[ $commands[go] ]] && export PATH="$PATH:$(go env GOPATH)/bin"

export PATH="/usr/local/smlnj/bin:$PATH"

# k8s krew plugin manager
[ -s "$HOME/.krew" ] && export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

[ -s "$HOMEBREW_PREFIX/opt/openal-soft/lib/pkgconfig" ] && export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$HOMEBREW_PREFIX/opt/openal-soft/lib/pkgconfig"

# Created by `pipx` on 2024-07-22 04:09:02
export PATH="$PATH:$HOME/.local/bin"

# zprof

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
