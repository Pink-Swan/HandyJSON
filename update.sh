#!/bin/bash

# 设置你的提交用户名和邮箱
GIT_USER="chantu.lhl"
GIT_EMAIL="chantu.lhl@gmail.com"

# 获取当前分支名
BRANCH=$(git rev-parse --abbrev-ref HEAD)

# 检查远程是否有更改
git fetch origin $BRANCH

# 比较本地与远程仓库的提交
LOCAL=$(git rev-parse $BRANCH)
REMOTE=$(git rev-parse origin/$BRANCH)
BASE=$(git merge-base $BRANCH origin/$BRANCH)

# 如果本地与远程有差异
if [ $LOCAL = $REMOTE ]; then
    echo "No remote changes. Proceeding with local commit."
    
    # 设置本地提交用户名和邮箱
    git config user.name "$GIT_USER"
    git config user.email "$GIT_EMAIL"
    
    # 添加文件并提交
    git add .
    git commit -m "Updated"

    # 提交到远程仓库
    git push origin $BRANCH
elif [ $LOCAL = $BASE ]; then
    echo "Pulling latest changes from remote..."
    git pull origin $BRANCH
else
    echo "There are unmerged changes. Please resolve conflicts."
fi
