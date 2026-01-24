#!/usr/bin/env bash

# 开启严格模式：
# set -e: 遇到错误立即退出
# set -u: 使用未定义的变量时报错
# set -o pipefail: 管道命令中只要有一个失败，整个命令就视为失败
set -euo pipefail

# 检查是否安装了 Homebrew
if ! command -v brew &> /dev/null; then
    echo "❌ Error: Homebrew is not installed."
    exit 1
fi

# 显示帮助信息
usage() {
    echo "Usage: $0 {backup|restore}"
    echo
    echo "Commands:"
    echo "  backup   Generate Brewfile from current system (Overwrite existing)"
    echo "  restore  Install packages listed in Brewfile"
    exit 1
}

# 检查是否有参数，如果没有则显示帮助
if [ $# -eq 0 ]; then
    usage
fi

# 根据传入的第一个参数 ($1) 执行相应逻辑
case "$1" in
    backup)
        echo "📦 Backing up current Homebrew packages to Brewfile..."
        # --describe: 添加注释描述包的作用
        # --force: 如果 Brewfile 已存在，强制覆盖
        brew bundle dump --describe --force
        echo "✅ Backup complete! (Check 'Brewfile' in current directory)"
        ;;
    restore)
        if [ ! -f "Brewfile" ]; then
            echo "❌ Error: 'Brewfile' not found in current directory."
            exit 1
        fi
        echo "♻️  Restoring packages from Brewfile..."
        brew bundle install
        echo "✅ Restore complete!"
        ;;
    *)
        # 如果输入的不是 backup 或 restore
        echo "❌ Invalid command: $1"
        usage
        ;;
esac
