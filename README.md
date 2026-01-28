# Sing-box Config Plugin for Claude Code

将 v2ray/clash 订阅或 URI 转换为 Sing-box 完整配置的 Claude Code 插件。

## 🚀 快速安装

```bash
# 1. 添加 Marketplace
/plugin marketplace add wynemo/singbox-config-plugin

# 2. 安装插件
/plugin install singbox-config@singbox-tools

# 3. 使用
/singbox-config
```

## 📋 功能特性

- ✅ 支持多种代理协议（SS/SSR/VMess/VLESS/Trojan/Hysteria/TUIC/WireGuard）
- ✅ 自动按地区分组节点（港/台/日/新/美）
- ✅ 包含完整的 DNS 和路由规则
- ✅ 支持 Sing-box 1.11 和 1.12 版本
- ✅ 支持 Clash API 面板

## 🔧 环境要求

需要安装 Node.js 或 Bun：

| 平台 | Node.js | Bun（可选，速度更快） |
|------|---------|---------------------|
| macOS | `brew install node` | `brew install oven-sh/bun/bun` |
| Windows | `winget install OpenJS.NodeJS` | `powershell -c "irm bun.sh/install.ps1 \| iex"` |
| Linux | [nodejs.org](https://nodejs.org/) | `curl -fsSL https://bun.sh/install \| bash` |

检查安装：
```bash
node --version    # 应显示 v14.0.0 或更高
# 或
bun --version     # 应显示 1.0.0 或更高
```

## 💡 使用方法

### 在 Claude Code 中使用

1. 启动 Claude Code
2. 输入命令：
   ```
   /singbox-config
   ```
3. 按照提示提供订阅内容或 URI
4. 插件会自动生成配置并保存

### 直接使用 CLI

```bash
cd ~/.claude/plugins/singbox-config/skills/singbox-config

# 从标准输入读取
echo "订阅内容" | node cli.js

# 指定 Sing-box 版本
echo "订阅内容" | node cli.js -v 1.12

# 从文件读取并输出到文件
node cli.js -i subscription.txt -o config.json

# 使用 Bun（更快）
bun cli.js -i subscription.txt -o config.json -v 1.11
```

### 命令行参数

| 参数 | 说明 | 默认值 |
|------|------|--------|
| `-v, --version` | Sing-box 版本 (1.11 或 1.12) | 1.11 |
| `-i, --input` | 输入文件路径 | stdin |
| `-o, --output` | 输出文件路径 | stdout |
| `-h, --help` | 显示帮助信息 | - |

## 📥 输入格式

支持以下三种输入格式：

1. **Base64 编码的 v2ray 订阅**
   ```
   dmxlc3M6Ly8xMjM0NTY3OC4uLg==
   ```

2. **多行 URI（每行一个节点）**
   ```
   vmess://eyJhZGQiOi...
   vless://uuid@host:port...
   ss://base64@host:port...
   ```

3. **混合格式**
   ```
   # 既有 base64 订阅
   # 又有单独的 URI
   ```

## 📤 输出特性

生成的配置包含：

- **节点分组**：自动按地区分组
  - 🇭🇰 香港节点
  - 🇹🇼 台湾节点
  - 🇯🇵 日本节点
  - 🇸🇬 新加坡节点
  - 🇺🇸 美国节点

- **DNS 配置**：智能 DNS 分流
- **路由规则**：完整的国内外分流规则
- **Clash API**：支持 Web 面板管理

## 🏗️ 插件结构

```
singbox-config-plugin/
├── .claude-plugin/
│   └── marketplace.json        # Marketplace 配置
├── plugins/
│   └── singbox-config/
│       ├── .claude-plugin/
│       │   └── plugin.json     # 插件元数据
│       └── skills/
│           └── singbox-config/
│               ├── skill.md    # Skill 定义
│               ├── cli.js      # CLI 入口
│               ├── test.js     # 协议解析
│               ├── 1.11/       # Sing-box 1.11 支持
│               └── 1.12/       # Sing-box 1.12 支持
├── README.md                   # 本文件
├── LICENSE                     # MIT 许可证
└── PLUGIN_GUIDE.md             # 插件开发指南
```

## 🔄 更新插件

```bash
# 通过 Plugin 命令更新
/plugin update singbox-config

# 或手动更新
cd ~/.claude/plugins/singbox-config
git pull
```

## 🐛 问题排查

### 插件无法找到

确保插件已启用：
```bash
/plugin list                    # 查看所有插件
/plugin enable singbox-config   # 启用插件
```

### Node.js 未安装

错误信息：`command not found: node`

解决方案：
```bash
# macOS
brew install node

# Windows
winget install OpenJS.NodeJS
```

### 配置生成失败

1. 检查输入格式是否正确
2. 确认订阅内容有效
3. 查看详细错误信息

## 📚 参考资源

- **在线工具**: https://singbox-to-uri.pages.dev/singbox_full_config
- **视频教程**: https://www.youtube.com/watch?v=OEhebRFrzA4
- **原始项目**: https://github.com/wynemo/v2ray-to-sing-box
- **Sing-box 文档**: https://sing-box.sagernet.org/

## 📺 相关视频

订阅我的 YouTube 频道获取更多教程：
👉 https://www.youtube.com/@ggdbin/

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📄 许可证

MIT License - 详见 [LICENSE](LICENSE) 文件

## 👤 作者

Tommy Green ([@ggdbin](https://www.youtube.com/@ggdbin/))

---

⭐ 如果这个插件对你有帮助，请给个 Star！
