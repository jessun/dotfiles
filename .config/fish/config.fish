# ===============================
# Author: jessun1990@gmail.com
# Useage: fish shell config file
# Location: ~/.config/fish/config.fish
# ===============================
#
# ======== Var Definition =======
export LOCAL_SOCKS5_PROXY='socks5://127.0.0.1:1080'
export LOCAL_HTTP_PROXY='http://127.0.0.1:1087'
# ===============================
#
# ============= OS ==============

switch (uname)
    case 'Darwin'
        alias vim '/Applications/MacVim.app/Contents/bin/vim'
        if type -q 'nvm' 
            nvm use default
        end
    case 'Linux'
        if type -q 'xsel'
            alias pbcopy 'xsel --clipboard --input'
            alias pbpaste 'xsel --clipboard --output'
        end
        setxkbmap -option caps:swapescape
    case "*"
        echo "unknowon os"
end
# ===============================
# 
# ============ Alias ============
# emacs
if type -q 'emacs'
   alias e='emacs -nw'
end

# git
if type -q 'git'
    alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
    alias git-delete-merged='git branch --merged | egrep -v "(^\*|master)" | xargs git branch -d'
end
 
# proxy
alias usesocks5proxy "export all_proxy='$LOCAL_SOCKS5_PROXY'; export http_proxy='$LOCAL_SOCKS5_PROXY'; export https_proxy='$LOCAL_SOCKS5_PROXY'; git config --global http.proxy '$LOCAL_SOCKS5_PROXY'; git config --global https.proxy '$LOCAL_SOCKS5_PROXY'"
alias usehttpproxy "export all_proxy='$LOCAL_HTTP_PROXY'; export http_proxy='$LOCAL_HTTP_PROXY'; export https_proxy='$LOCAL_HTTP_PROXY'; git config --global http.proxy '$LOCAL_HTTP_PROXY'; git config --global https.proxy '$LOCAL_HTTP_PROXY'"
alias cleanallproxy "export all_proxy=; export http_proxy=; export https_proxy=; git config --global http.proxy ''; git config --global https.proxy ''"

# shell proxy
alias shellusesocks5proxy "export all_proxy='$LOCAL_SOCKS5_PROXY'; export http_proxy='$LOCAL_SOCKS5_PROXY'; export https_proxy='$LOCAL_SOCKS5_PROXY'"
alias shellusehttpproxy "export all_proxy='$LOCAL_HTTP_PROXY'; export http_proxy='$LOCAL_HTTP_PROXY'; export https_proxy='$LOCAL_HTTP_PROXY'"

# git proxy
if type -q 'git'
    alias gitusehttpproxy "git config --global http.proxy '$LOCAL_HTTP_PROXY'; git config --global https.proxy '$LOCAL_HTTP_PROXY'"
    alias gitusesocks5proxy "git config --global http.proxy '$LOCAL_SOCKS5_PROXY'; git config --global https.proxy '$LOCAL_SOCKS5_PROXY'"
    alias gitcleanproxy "git config --global http.proxy ''; git config --global https.proxy ''"
    if type -q 'vim'
        alias gitfix 'git diff --name-only | uniq | xargs nvim '
    end
    if type -q 'nvim'
        alias gitfix 'git diff --name-only | uniq | xargs nvim '
    end
    if type -q 'code'
        alias codefix 'git diff --name-only | uniq | xargs code '
    end
    if type -q 'code-insiders'
        alias codefix 'git diff --name-only | uniq | xargs code-insiders '
    end
    alias gitdiff 'git difftool'
end
# ===============================
#
# ========== Env Vars ===========
#export TERM="xterm-256color"
export LANG=zh_CN.UTF-8

# Golang
export GO111MODULE=on
export GOPROXY=goproxy.cn,goproxy.io,direct 
if test -e "$HOME/.gvm/environments/default"
    bass source "$HOME/.gvm/environments/default"
end

# Local bin
if test -d "$HOME/.local/bin/"
    set -gx PATH "$HOME/.local/bin/" $PATH
end

# Home bin
if test -d "$HOME/bin/"
    set -gx PATH "$HOME/bin/" $PATH
end

# MEGAsync
if test -d "$HOME/MEGAsync/bin/"
    set -gx PATH "$HOME/MEGAsync/bin/" $PATH
end

# Rust
if test -d "$HOME/.cargo/bin/"
    set -gx PATH "$HOME/.cargo/bin/" $PATH
end
if type -q rustc
    export RUST_SRC_PATH=(rustc --print sysroot)/lib/rustlib/src/rust/library/
end

# ruby env
if test -d "$HOME/.rbenv/bin"
    set -g PATH "$HOME/.rbenv/bin" $PATH
end
if test -d "$HOME/.rbenv/shims"
    set -g PATH "$HOME/.rbenv/shims" $PATH
end

# yarn
if test -d "$HOME/.yarn/bin/"
    set -gx PATH "$HOME/.yarn/bin/" $PATH
end
# ===============================
export GOPRIVATE=actiontech.cloud
export GOINSECURE=actiontech.cloud

thefuck --alias | source
export TERM="screen-256color"
