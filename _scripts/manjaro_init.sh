#!/bin/sh
sudo pacman-mirrors -m rank -c China
sudo pacman -S base-devel socat bison

sudo yay --noconfirm



sudo yay -S  --noconfirm \
    fish fisher tmux fzf git \
    rustup ripgrep gitui rust-analyzer fd \
    neovim-nightly-bin python-neovim \
    pnpm yarn npm \
    tmux-plugin-manager \
    go
