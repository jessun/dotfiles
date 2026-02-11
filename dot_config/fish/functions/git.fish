# Git Worktree Clone: 克隆裸仓库并初始化 main 分支
function gwtc
    set url $argv[1]
    # 获取仓库名作为文件夹名 (例如 user/repo -> repo)
    set repo_name (string split -r -m1 / $url)[2]
    set repo_name (string replace ".git" "" $repo_name)

    mkdir -p $repo_name
    cd $repo_name

    # 1. 克隆为 .bare 目录
    git clone --bare $url .bare

    # 2. 设置伪 .git 文件
    echo "gitdir: ./.bare" > .git

    # 3. 修复远程配置，确保能看到所有分支
    git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"

    # 4. 创建主工作区 (尝试使用 main 或 master)
    if git --git-dir=.bare show-ref --verify --quiet refs/remotes/origin/main
        git worktree add main
    else
        git worktree add master
    end
end
