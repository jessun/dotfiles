#!/bin/sh
sudo pacman-mirrors -m rank -c China

yay --noconfirm


yay -S \
    base-devel socat bison\
    fish fishe tmux fzf \
    git \
    ripgrep gitui rust-analyzer fd \
    neovim-nightly-bin python-neovim \
    pnpm yarn npm \
    tmux-plugin-manager \
    rustup \
    rust-analyzer \
    go \
    --noconfirm
