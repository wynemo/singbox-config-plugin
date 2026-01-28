#!/bin/bash

# Sing-box Config Plugin 一键发布脚本
# 自动化整个发布流程

set -e

echo "🚀 Sing-box Config Plugin 发布助手"
echo "===================================="
echo ""

# 检查是否在正确的目录
if [ ! -f ".claude-plugin/plugin.json" ]; then
    echo "❌ 错误: 请在 singbox-config-plugin 目录下运行此脚本"
    exit 1
fi

# 检查是否已经是 git 仓库
if [ -d .git ]; then
    echo "⚠️  检测到已存在 git 仓库"
    read -p "是否继续？这将推送到远程仓库 (y/n): " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "❌ 取消发布"
        exit 1
    fi
else
    echo "📦 初始化 Git 仓库..."
    git init
    git add .
    git commit -m "feat: Initial release of Sing-box Config Plugin"
fi

# 询问 GitHub 用户名
read -p "请输入你的 GitHub 用户名: " github_username

if [ -z "$github_username" ]; then
    echo "❌ 错误: GitHub 用户名不能为空"
    exit 1
fi

# 更新所有文件中的 your-username
echo "📝 更新配置文件..."

# 使用 sed 替换（兼容 macOS 和 Linux）
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    sed -i '' "s|your-username|$github_username|g" .claude-plugin/plugin.json
    sed -i '' "s|your-username|$github_username|g" README.md
    sed -i '' "s|your-username|$github_username|g" PLUGIN_GUIDE.md
    sed -i '' "s|YOUR-USERNAME|$github_username|g" PLUGIN_GUIDE.md
else
    # Linux
    sed -i "s|your-username|$github_username|g" .claude-plugin/plugin.json
    sed -i "s|your-username|$github_username|g" README.md
    sed -i "s|your-username|$github_username|g" PLUGIN_GUIDE.md
    sed -i "s|YOUR-USERNAME|$github_username|g" PLUGIN_GUIDE.md
fi

echo "✅ 配置文件已更新"
echo ""

# 提交更改
git add .
git commit -m "chore: Update repository URLs" || true

# 检查是否安装了 gh CLI
if ! command -v gh &> /dev/null; then
    echo "⚠️  未检测到 GitHub CLI (gh)"
    echo ""
    echo "请手动完成以下步骤："
    echo ""
    echo "1. 在 GitHub 上创建新仓库: singbox-config-plugin"
    echo "2. 运行以下命令："
    echo "   git remote add origin https://github.com/$github_username/singbox-config-plugin.git"
    echo "   git branch -M main"
    echo "   git push -u origin main"
    echo ""
    echo "安装 GitHub CLI: https://cli.github.com/"
    exit 0
fi

# 使用 gh CLI 创建仓库
echo "🔐 检查 GitHub 授权..."
gh auth status || gh auth login

echo "📦 创建 GitHub 仓库..."
gh repo create singbox-config-plugin \
    --public \
    --description "Claude Code Plugin: 将 v2ray/clash 订阅转换为 Sing-box 配置" \
    --source=. \
    --remote=origin || {
        echo "⚠️  仓库可能已存在，尝试添加 remote..."
        git remote add origin "https://github.com/$github_username/singbox-config-plugin.git" 2>/dev/null || true
    }

echo "⬆️  推送到 GitHub..."
git branch -M main
git push -u origin main

# 询问是否创建 Release
read -p "是否创建 v1.0.0 Release? (y/n): " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "🏷️  创建 Release v1.0.0..."
    git tag -a v1.0.0 -m "Release v1.0.0: First stable version"
    git push origin v1.0.0

    gh release create v1.0.0 \
        --title "v1.0.0 - 首个稳定版本" \
        --notes "## 功能特性

- ✅ 支持 v2ray/clash 订阅转换
- ✅ 支持多种协议（SS/SSR/VMess/VLESS/Trojan/Hysteria/TUIC/WireGuard）
- ✅ 自动地区分组
- ✅ 完整的 DNS 和路由规则
- ✅ 支持 Sing-box 1.11 和 1.12

## 安装

### 方式 1: 通过 Plugin 命令（推荐）

\`\`\`bash
/plugin marketplace add $github_username/singbox-config-plugin
/plugin install singbox-config@singbox-tools
\`\`\`

### 方式 2: 手动克隆

\`\`\`bash
# macOS/Linux
git clone https://github.com/$github_username/singbox-config-plugin ~/.claude/plugins/singbox-config

# Windows
git clone https://github.com/$github_username/singbox-config-plugin %USERPROFILE%\.claude\plugins\singbox-config
\`\`\`

然后启用插件：
\`\`\`bash
/plugin enable singbox-config
\`\`\`

## 使用

在 Claude Code 中运行：
\`\`\`bash
/singbox-config
\`\`\`
"
fi

echo ""
echo "✅ 插件发布完成！"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📥 用户安装命令（方式 1 - 推荐）："
echo "   /plugin marketplace add $github_username/singbox-config-plugin"
echo "   /plugin install singbox-config@singbox-tools"
echo ""
echo "📥 用户安装命令（方式 2）："
echo "   git clone https://github.com/$github_username/singbox-config-plugin ~/.claude/plugins/singbox-config"
echo "   /plugin enable singbox-config"
echo ""
echo "🔗 仓库地址:"
echo "   https://github.com/$github_username/singbox-config-plugin"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📢 下一步建议："
echo "   1. 在 tech-notes 仓库中添加插件链接"
echo "   2. 在 YouTube (@ggdbin) 上制作使用教程"
echo "   3. 在社交媒体分享（使用 #ClaudeCode 标签）"
echo "   4. 在 GitHub 仓库添加 Topics: claude-code, claude-plugin, singbox"
echo ""
echo "🎉 祝你的插件受欢迎！"
echo ""
