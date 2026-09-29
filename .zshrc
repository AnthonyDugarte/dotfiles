# zmodload zsh/zprof

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="minimal"

[[ $commands[brew] ]] && NVM_HOMEBREW=$(brew --prefix nvm)

zstyle ':omz:update' frequency 7
zstyle ':omz:update' mode reminder

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
        gpg-agent
)

fpath=($HOME/.zsh/completion $fpath)

[ -s "$ZSH/oh-my-zsh.sh" ] && source $ZSH/oh-my-zsh.sh

# User configuration

alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"

# Custom scripts
[ -s "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"

# Android
export ANDROID_HOME=$HOME/Library/Android/sdk
[ -s "$ANDROID_HOME" ] && export PATH="$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH"

# LLVM
BREW_LLVM_FORMULA="llvm@19"
BREW_LLVM_FORMULA_DIR="$(brew --prefix $BREW_LLVM_FORMULA)"
[ -s $BREW_LLVM_FORMULA_DIR ] \
        && export LDFLAGS="-L$BREW_LLVM_FORMULA_DIR/lib -L$(brew --prefix)/lib" \
        && export CPPFLAGS="-I$BREW_LLVM_FORMULA_DIR/include  -I$(brew --prefix)/include" \
        && export PATH="$BREW_LLVM_FORMULA_DIR/bin:$PATH"

# Python
[ -s "$HOME/Library/Python/3.9/bin" ] && export PATH="$HOME/Library/Python/3.9/bin:$PATH"

# PSQL
[ -s "/Applications/Postgres.app/Contents/Versions/latest/bin" ] && export PATH="/Applications/Postgres.app/Contents/Versions/latest/bin:$PATH"

# Ogre
[ -s "$HOME/Code/ogre/dist/sdk" ] && export OGRE_DIR="$HOME/Code/ogre/dist/sdk"

# Golang
[[ $commands[go] ]] && export PATH="$PATH:$(go env GOPATH)/bin"

# k8s krew plugin manager
[ -s "$HOME/.krew" ] && export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

[ -s "$HOMEBREW_PREFIX/opt/openal-soft/lib/pkgconfig" ] && export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$HOMEBREW_PREFIX/opt/openal-soft/lib/pkgconfig"

# Created by `pipx` on 2024-07-22 04:09:02
[ -s "$HOME/.local/bin" ] && export PATH="$PATH:$HOME/.local/bin"

# # # lazy loaded by omz
# # nvm
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# # GPG TTY
# export GPG_TTY=$(tty)


# ## Auto activate virtualenv if .env folder is found in the current directory
# function cd() {
#   builtin cd "$@"
#
#   if [[ -z "$VIRTUAL_ENV" ]] ; then
#     ## If env folder is found then activate the vitualenv
#       if [[ -d ./.venv ]] ; then
#         source ./.venv/bin/activate
#       fi
#   else
#     ## check the current folder belong to earlier VIRTUAL_ENV folder
#     # if yes then do nothing
#     # else deactivate
#       parentdir="$(dirname "$VIRTUAL_ENV")"
#       if [[ "$PWD"/ != "$parentdir"/* ]] ; then
#         deactivate
#       fi
#   fi
# }

# if [[ -z "$VIRTUAL_ENV" ]] ; then
#    ## If env folder is found then activate the vitualenv
#      if [[ -d ./.venv ]] ; then
#        source ./.venv/bin/activate
#      fi
# fi

