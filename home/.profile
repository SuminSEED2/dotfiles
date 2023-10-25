if [ "$(uname)" == 'Darwin' ]; then
    export MY_IS_MAC=1
fi

if [[ "$(uname -r)" == *microsoft* ]]; then
    export MY_IS_WSL=1
fi

if [ -n "$SSH_CONNECTION" ]; then
    export MY_IS_SSH=1
fi

if [ -f "$HOME/.env" ]; then
    . "$HOME/.env"
fi

# init brew
if [ -f "/opt/homebrew/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
if [ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# anyenv
export PATH="$HOME/.anyenv/bin:$PATH"
if [ -n "`builtin command -v anyenv 2>/dev/null`" ]; then
    eval "$(anyenv init -)"
    # goenv の go コマンドが brew の go よりも後に来ちゃうのを防ぐダメに明示的に置いておく
    export PATH="$HOME/.anyenv/envs/goenv/shims":$PATH
    # いらないかも
    # if [ -n "`builtin command -v pyenv 2>/dev/null`" ]; then
    #     if [ -d "$(pyenv root)/plugins/pyenv-virtualenv" ] ; then
    #         eval "$(pyenv virtualenv-init -)"
    #     fi
    # fi
fi

if [ -n "$MY_IS_WSL" ] && [ "$MY_IS_WSL" -eq 1 ] ; then
    export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"
    export PATH="$PATH:/mnt/c/Program Files/Oracle/VirtualBox"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -n "`builtin command -v brew 2>/dev/null`" ]; then
    export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
fi

# export GOENV_DISABLE_GOPATH=1
# export GOPATH=$HOME/go

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

if [ -n "$MY_IS_SSH" ] && [ "$MY_IS_SSH" -eq 1 ] ; then
    agent="$HOME/.ssh/agent"
    if [ -S "$SSH_AUTH_SOCK" ]; then
        case $SSH_AUTH_SOCK in
            /tmp/*/agent.[0-9]*)
                ln -snf "$SSH_AUTH_SOCK" $agent && export SSH_AUTH_SOCK=$agent
        esac
    elif [ -S $agent ]; then
        export SSH_AUTH_SOCK=$agent
    fi
    unset agent
fi
