# 1. Proxy Aliases
alias usehttpproxy="proxy_on"
alias usesocks5proxy="proxy_socks5"
alias cleanallproxy="proxy_off"

# 2. Golang Abbr
abbr -a gomod "go mod vendor; and go mod tidy"

# 3. WSL / Windows Aliases
if grep -q "Microsoft" /proc/version 2>/dev/null; or test -n "$WSL_DISTRO_NAME"
    if test -e '/mnt/c/Users/jessu/AppData/Local/Programs/Microsoft VS Code Insiders/bin/code-insiders'
        alias win-code '/mnt/c/Users/jessu/AppData/Local/Programs/Microsoft\ VS\ Code\ Insiders/bin/code-insiders'
    end

    if test -e '/mnt/c/Users/jessu/AppData/Local/Programs/cursor/resources/app/bin/cursor'
        alias win-cursor '/mnt/c/Users/jessu/AppData/Local/Programs/cursor/resources/app/bin/cursor'
    end

    if test -e '/mnt/d/bins/Windsurf/bin/windsurf'
        alias win-windsurf '/mnt/d/bins/Windsurf/bin/windsurf'
    end
end

# https://github.com/microsoft/inshellisense
test -f ~/.inshellisense/init/fish/init.fish && source ~/.inshellisense/init/fish/init.fish

if type -q eza
    alias ls "eza --git"
    alias ll "eza --git -l"
    alias la "eza --git -la"
    alias tree "eza --tree"
end

if type -q bat
    alias cat "bat"
end

if type -q zoxide
    zoxide init fish | source
end

if type -q git
    abbr -a push-current-git 'git push -u origin HEAD'
    abbr -a pull-git 'git pull --prune'
    abbr -a rebase-main-git 'git rebase -i origin/main'
    abbr -a add-current-git 'git add .'
    abbr -a status-git 'git status'
    abbr -a diff-git 'git diff'
end

if type -q nvim
    abbr -a COC 'COC=true nvim'
    abbr -a coc 'COC=true nvim'
end
