# 🤖 Claude Code & Codex 优化配置中心

本文件夹包含 Claude Code 和 Codex CLI 的完整优化配置，专为编程新手设计。

## 📁 文件结构

```
Claude Code配置/
├── README.md           # 本说明文档
├── install.sh          # 一键安装脚本
├── CLAUDE.md           # 项目规则模板 (复制到项目根目录)
├── settings.json       # Claude Code 高级配置
├── glm.sh             # 智谱 GLM 启动脚本
├── kimi.sh            # 月之暗面 Kimi 启动脚本
├── setup_aliases.sh   # Shell 别名安装脚本
└── codex/
    ├── config.toml     # Codex 配置文件
    └── instructions.md # Codex 自定义指令
```

## 🚀 快速安装

### 方式一：一键安装（推荐）

```bash
cd ~/Desktop/编程/Claude\ Code配置
chmod +x install.sh
./install.sh
```

### 方式二：手动安装

```bash
# 1. 复制 Claude Code 配置
mkdir -p ~/.claude
cp settings.json ~/.claude/

# 2. 复制 Codex 配置
mkdir -p ~/.codex
cp codex/config.toml ~/.codex/
cp codex/instructions.md ~/.codex/

# 3. 复制 CLAUDE.md 到你的项目
cp CLAUDE.md /你的项目路径/
```

## 💻 使用方法

### Claude Code

```bash
# 使用智谱 GLM-4.7 (国内推荐)
glm

# 使用月之暗面 Kimi
kimi
```

### Codex CLI

```bash
# 安装 Codex (首次需要)
npm install -g @openai/codex

# 启动 Codex
codex
```

## 📋 配置说明

### 1. CLAUDE.md - 项目规则

复制到项目根目录后，Claude Code 会自动读取并遵循这些规则：

- ✅ 中文回复 + 技术术语附英文
- ✅ 代码带中文注释
- ✅ 新手友好的解释方式
- ✅ 思路 → 代码 → 测试 的回复结构

### 2. settings.json - Claude Code 配置

| 配置项 | 说明 |
|--------|------|
| `permissions` | 预授权常用命令（git, npm, python等）|
| `alwaysThinkingEnabled` | 开启深度思考模式 |
| `promptSuggestionEnabled` | 开启智能提示建议 |

### 3. Codex config.toml - Codex 配置

| 配置项 | 说明 |
|--------|------|
| `model_provider` | 默认使用智谱 GLM |
| `approval_mode` | 审批模式，新手建议用 suggest |
| `model_providers` | 多模型支持（GLM/Kimi/DeepSeek）|

## 🎓 新手使用技巧

### Claude Code 快捷指令

| 指令 | 效果 |
|------|------|
| `简单版` | 获取最简洁的代码实现 |
| `详细版` | 获取带完整注释的代码 |
| `解释` | 像给新手讲课一样解释 |
| `优化` | 优化现有代码 |
| `测试` | 生成测试代码 |

### 常用命令

```bash
# 在 Claude Code 中查看状态
/status

# 切换模型
/model

# 初始化项目规则
/init

# 清空对话
/clear
```

## 🔧 高级功能

### MCP 工具扩展

Claude Code 支持通过 MCP (Model Context Protocol) 扩展功能：

```bash
# 添加 MCP 服务器 (示例)
claude mcp add <server-name> -s user --transport stdio -- <command>
```

### 多代理协作

使用 CodexMCP 实现 Claude Code + Codex 协作：

```bash
claude mcp add codex -s user --transport stdio -- uvx --from git+https://github.com/GuDaStudio/codexmcp.git codexmcp
```

## 📚 参考资源

- [Claude Code 官方文档](https://docs.anthropic.com/zh-CN/docs/claude-code)
- [智谱 GLM 配置文档](https://docs.bigmodel.cn/cn/guide/develop/claude)
- [Codex CLI 文档](https://github.com/openai/codex)

## ⚠️ 注意事项

1. **API Key 安全**: 请勿将 API Key 提交到 Git 仓库
2. **网络要求**: 使用时确保网络畅通
3. **配置更新**: 修改配置后需重启终端生效

## 🐛 常见问题

### Q: glm/kimi 命令无效？
A: 重新打开终端，或执行 `source ~/.zshrc`

### Q: 如何切换模型？
A: 在 Claude Code 中输入 `/model` 或使用不同的启动命令

### Q: Codex 连接失败？
A: 检查 `~/.codex/config.toml` 中的 API Key 环境变量是否正确设置

---

*配置版本: 2024.12 | 适用于 Claude Code 2.0+*
