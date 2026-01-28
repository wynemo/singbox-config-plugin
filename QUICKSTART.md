# 🚀 快速开始

## 一键发布

最简单的方式 - 只需一条命令：

```bash
cd singbox-config-plugin
./publish-plugin.sh
```

脚本会自动完成：
1. ✅ 初始化 Git 仓库
2. ✅ 创建 GitHub 仓库
3. ✅ 更新配置文件中的用户名
4. ✅ 推送代码到 GitHub
5. ✅ 创建 v1.0.0 Release
6. ✅ 生成用户安装命令

## 用户如何安装你的插件

### 方式 1: 通过 Plugin 命令（推荐）⭐

用户在 Claude Code 中运行：

```bash
# 1. 添加你的 Marketplace
/plugin marketplace add YOUR-USERNAME/singbox-config-plugin

# 2. 安装插件
/plugin install singbox-config@singbox-tools

# 3. 使用
/singbox-config
```

### 方式 2: 手动克隆

```bash
# macOS/Linux
git clone https://github.com/YOUR-USERNAME/singbox-config-plugin ~/.claude/plugins/singbox-config

# Windows
git clone https://github.com/YOUR-USERNAME/singbox-config-plugin %USERPROFILE%\.claude\plugins\singbox-config
```

然后在 Claude Code 中启用：
```bash
/plugin enable singbox-config
```

## Plugin vs Skill 对比

| 特性 | Skill（旧方式） | Plugin（本项目）✨ |
|------|----------------|-------------------|
| 安装命令 | `git clone` 到 `~/.claude/skills/` | `/plugin install` |
| 版本管理 | 手动 | 自动 |
| 更新方式 | `git pull` | `/plugin update` |
| 官方市场 | ❌ | ✅ |
| 命名空间 | `/skill-name` | `/plugin:skill-name` |
| 适用场景 | 个人使用 | 社区分享 |

**Plugin 提供更专业的分发体验！**

## 目录结构

```
singbox-config-plugin/
├── .claude-plugin/              # 插件配置 ⭐
│   ├── plugin.json             # 插件元数据（必需）
│   └── marketplace.json        # Marketplace 配置
├── skills/                      # Skills 目录 ⭐
│   └── singbox-config/         # 你的 skill（必需）
│       ├── skill.md            # Skill 定义
│       ├── cli.js              # CLI 入口
│       ├── test.js             # 协议解析
│       ├── 1.11/               # Sing-box 1.11 支持
│       └── 1.12/               # Sing-box 1.12 支持
├── README.md                    # 用户文档
├── PLUGIN_GUIDE.md             # 详细发布指南
├── QUICKSTART.md               # 本文件
├── LICENSE                      # MIT 许可证
├── .gitignore                   # Git 忽略规则
└── publish-plugin.sh           # 一键发布脚本 ⭐
```

## 发布前准备

运行 `./publish-plugin.sh` 前确保：

- [ ] 已安装 [GitHub CLI](https://cli.github.com/) (`gh` 命令)
- [ ] 已登录 GitHub: `gh auth login`
- [ ] 准备好 GitHub 用户名

## 发布后推广

### 1. 在 tech-notes 仓库添加链接

编辑 `science/sing-box/` 目录的文档：

```markdown
## Claude Code 插件

使用 Claude Code？安装我们的插件快速生成配置：

\`\`\`bash
/plugin marketplace add YOUR-USERNAME/singbox-config-plugin
/plugin install singbox-config@singbox-tools
\`\`\`

详见：https://github.com/YOUR-USERNAME/singbox-config-plugin
```

### 2. 制作 YouTube 视频

在 [@ggdbin](https://www.youtube.com/@ggdbin/) 发布：
- 插件安装教程
- 配置生成演示
- 实际使用案例

### 3. 社交媒体分享

- **Twitter/X**: 使用 `#ClaudeCode` 标签
- **Reddit**: r/ClaudeAI
- **V2EX**: 技术节点
- **少数派**: 效率工具专题

### 4. GitHub 优化

在仓库添加 Topics：
- `claude-code`
- `claude-plugin`
- `singbox`
- `v2ray`
- `proxy-tools`

## 常见问题

### Q: 如何更新插件版本？

```bash
# 1. 更新 .claude-plugin/plugin.json 中的 version
# 2. 提交更改
git add .
git commit -m "feat: Add new feature"

# 3. 创建新标签
git tag -a v1.1.0 -m "Release v1.1.0"
git push origin main v1.1.0

# 4. 创建 Release
gh release create v1.1.0 --title "v1.1.0" --notes "更新内容..."
```

用户更新：`/plugin update singbox-config`

### Q: 如何测试插件？

```bash
# 创建软链接到 Claude plugins 目录
ln -s "$(pwd)" ~/.claude/plugins/singbox-config

# 在 Claude Code 中测试
/plugin enable singbox-config
/singbox-config

# 测试完成后移除
rm ~/.claude/plugins/singbox-config
```

### Q: 插件和 Skill 有什么区别？

- **Skill**: 简单的命令扩展，通过 `git clone` 安装到 `~/.claude/skills/`
- **Plugin**: 正式的插件系统，通过 `/plugin install` 安装，支持版本管理和自动更新

Plugin 是更专业的分发方式，适合社区分享。

### Q: 用户如何卸载插件？

```bash
/plugin uninstall singbox-config
```

## 需要帮助？

- **详细发布指南**: 查看 [PLUGIN_GUIDE.md](PLUGIN_GUIDE.md)
- **用户文档**: 查看 [README.md](README.md)
- **Skill 说明**: 查看 [skills/singbox-config/skill.md](skills/singbox-config/skill.md)

## 官方文档

- [Plugin 开发文档](https://code.claude.com/docs/en/plugins.md)
- [Marketplace 指南](https://code.claude.com/docs/en/plugin-marketplaces.md)
- [Skill 开发文档](https://code.claude.com/docs/en/skills.md)

---

准备好了？运行 `./publish-plugin.sh` 开始发布！🎉
