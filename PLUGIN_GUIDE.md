# Sing-box Config Plugin 发布指南

本指南说明如何将此插件发布供其他用户安装使用。

## 📦 插件 vs Skill 对比

| 特性 | Skill | Plugin（本项目） |
|------|-------|-----------------|
| 安装方式 | `git clone` 到 `~/.claude/skills/` | `/plugin install` 命令 |
| 官方市场 | ❌ 无 | ✅ 有 Marketplace 系统 |
| 版本管理 | 手动 | ✅ 自动（语义化版本） |
| 命名空间 | `/skill-name` | `/plugin:skill-name` |
| 分发渠道 | GitHub 直接克隆 | Marketplace + GitHub |
| 更新机制 | 手动 `git pull` | `/plugin update` 命令 |
| 适用场景 | 个人/项目特定 | 团队/社区分享 |

**本项目采用 Plugin 方式，提供更专业的分发体验。**

## 🚀 发布流程

### 第 1 步：准备 GitHub 仓库

```bash
cd singbox-config-plugin

# 初始化 Git
git init
git add .
git commit -m "feat: Initial release of Sing-box Config Plugin"

# 创建 GitHub 仓库（使用 gh CLI）
gh repo create singbox-config-plugin --public --source=. --remote=origin
git push -u origin main
```

或在 GitHub 网站手动创建：https://github.com/new

### 第 2 步：更新配置中的 URL

编辑以下文件，将 `your-username` 替换为你的 GitHub 用户名：

1. **[.claude-plugin/plugin.json](singbox-config-plugin/.claude-plugin/plugin.json)**
   ```json
   "repository": {
     "url": "https://github.com/YOUR-USERNAME/singbox-config-plugin"
   }
   ```

2. **[README.md](singbox-config-plugin/README.md)** 中的所有 `your-username`

### 第 3 步：创建 Release

```bash
# 创建版本标签
git tag -a v1.0.0 -m "Release v1.0.0: First stable version"
git push origin v1.0.0

# 使用 gh CLI 创建 Release
gh release create v1.0.0 \
  --title "v1.0.0 - 首个稳定版本" \
  --notes "## 功能特性

- ✅ 支持 v2ray/clash 订阅转换
- ✅ 支持多种协议（SS/SSR/VMess/VLESS/Trojan/Hysteria/TUIC/WireGuard）
- ✅ 自动地区分组
- ✅ 完整的 DNS 和路由规则
- ✅ 支持 Sing-box 1.11 和 1.12

## 安装

\`\`\`bash
# 方式 1: 通过 Plugin 命令
/plugin marketplace add YOUR-USERNAME/singbox-config-plugin
/plugin install singbox-config@singbox-tools

# 方式 2: 手动克隆
git clone https://github.com/YOUR-USERNAME/singbox-config-plugin ~/.claude/plugins/singbox-config
\`\`\`

## 使用

\`\`\`bash
/singbox-config
\`\`\`
"
```

## 📢 用户安装方式

发布后，用户有两种安装方式：

### 方式 A：通过 Plugin 命令（推荐）

```bash
# 1. 在 Claude Code 中添加你的 Marketplace
/plugin marketplace add your-username/singbox-config-plugin

# 2. 安装插件
/plugin install singbox-config@singbox-tools

# 3. 使用
/singbox-config
```

### 方式 B：手动克隆

```bash
# macOS/Linux
git clone https://github.com/your-username/singbox-config-plugin ~/.claude/plugins/singbox-config

# Windows
git clone https://github.com/your-username/singbox-config-plugin %USERPROFILE%\.claude\plugins\singbox-config
```

然后启用插件：
```bash
/plugin enable singbox-config
```

## 🔄 发布新版本

```bash
# 1. 更新 plugin.json 中的版本号
# 编辑 .claude-plugin/plugin.json：
{
  "version": "1.1.0"  # 更新版本号
}

# 2. 提交更改
git add .
git commit -m "feat: Add support for new protocol"

# 3. 创建新标签
git tag -a v1.1.0 -m "Release v1.1.0: Add new features"
git push origin main v1.1.0

# 4. 创建 Release
gh release create v1.1.0 --title "v1.1.0" --notes "更新内容..."
```

用户更新：
```bash
/plugin update singbox-config
```

## 📁 项目结构说明

```
singbox-config-plugin/              # 插件根目录
├── .claude-plugin/                  # 插件配置目录 ⭐
│   ├── plugin.json                 # 插件元数据（必需）
│   └── marketplace.json            # Marketplace 配置
├── skills/                          # Skills 目录 ⭐
│   └── singbox-config/             # 你的 skill
│       ├── skill.md                # Skill 定义（必需）
│       ├── cli.js                  # CLI 入口
│       ├── test.js                 # 协议解析
│       ├── 1.11/                   # Sing-box 1.11 支持
│       └── 1.12/                   # Sing-box 1.12 支持
├── README.md                        # 用户文档
├── PLUGIN_GUIDE.md                  # 本文件（发布指南）
├── LICENSE                          # MIT 许可证
├── .gitignore                       # Git 忽略规则
└── package.json                     # 可选：NPM 元数据
```

⭐ = 必需文件/目录

## 🏷️ 版本号规范

使用语义化版本号（Semantic Versioning）：

- **1.0.0** → **1.0.1** : Bug 修复
- **1.0.0** → **1.1.0** : 新增功能（向后兼容）
- **1.0.0** → **2.0.0** : 重大变更（不兼容）

示例：
```bash
# Bug 修复
git tag v1.0.1 -m "fix: Resolve parsing error"

# 新功能
git tag v1.1.0 -m "feat: Add support for Hysteria2"

# 重大变更
git tag v2.0.0 -m "feat!: Require Node.js 18+"
```

## 📋 发布前检查清单

- [ ] 所有文件中的 `your-username` 已替换
- [ ] `plugin.json` 中的版本号正确
- [ ] 环境要求（Node.js/Bun）已在 README 中说明
- [ ] 所有必需文件都已包含
- [ ] LICENSE 文件存在
- [ ] 本地测试通过
- [ ] Git 标签与版本号一致
- [ ] Release 说明清晰完整

## 🧪 本地测试

发布前在本地测试：

```bash
# 1. 创建软链接到 Claude plugins 目录
ln -s "$(pwd)" ~/.claude/plugins/singbox-config

# 2. 在 Claude Code 中启用
/plugin enable singbox-config

# 3. 测试 skill
/singbox-config

# 4. 完成测试后移除软链接
rm ~/.claude/plugins/singbox-config
```

## 🌐 推广渠道

### 1. GitHub Topics

在仓库设置中添加以下标签：
- `claude-code`
- `claude-plugin`
- `singbox`
- `v2ray`
- `clash`
- `proxy-tools`

### 2. Tech-notes 仓库

在你的 tech-notes 仓库中添加链接：

编辑 `science/sing-box/` 目录下的文档：
```markdown
## Claude Code 插件

使用 Claude Code？安装我们的插件快速生成配置：

\`\`\`bash
/plugin marketplace add your-username/singbox-config-plugin
/plugin install singbox-config@singbox-tools
\`\`\`

详见：https://github.com/your-username/singbox-config-plugin
```

### 3. YouTube 视频

在 [@ggdbin](https://www.youtube.com/@ggdbin/) 频道发布：
- 安装和使用教程
- 配置生成演示
- 与在线工具对比

### 4. 社交媒体

- Twitter/X: 使用 `#ClaudeCode` 标签
- Reddit: r/ClaudeAI
- V2EX: [技术节点](https://www.v2ex.com/go/tech)
- 少数派等技术社区

## 🔗 官方资源

- **Plugin 开发文档**: https://code.claude.com/docs/en/plugins.md
- **Marketplace 指南**: https://code.claude.com/docs/en/plugin-marketplaces.md
- **Skill 开发文档**: https://code.claude.com/docs/en/skills.md

## 💬 用户反馈

建议在 GitHub 仓库启用：
- **Issues**: 接收 bug 报告和功能请求
- **Discussions**: 用户交流和问答
- **Wiki**: 详细文档和教程

## 📊 统计和分析

在 README 中添加 badge：

```markdown
![GitHub stars](https://img.shields.io/github/stars/your-username/singbox-config-plugin)
![GitHub issues](https://img.shields.io/github/issues/your-username/singbox-config-plugin)
![GitHub license](https://img.shields.io/github/license/your-username/singbox-config-plugin)
```

## 🎯 后续维护

1. **定期更新**
   - 跟进 Sing-box 新版本
   - 支持新的代理协议
   - 修复用户报告的 bug

2. **文档维护**
   - 保持 README 更新
   - 添加常见问题解答
   - 提供详细的示例

3. **社区管理**
   - 及时回复 Issues
   - 审查和合并 PR
   - 感谢贡献者

---

准备好了吗？运行以下命令开始发布：

```bash
cd singbox-config-plugin
git init
git add .
git commit -m "feat: Initial release"
gh repo create singbox-config-plugin --public --source=. --remote=origin
git push -u origin main
git tag -a v1.0.0 -m "Release v1.0.0"
git push origin v1.0.0
```

🎉 祝发布顺利！
