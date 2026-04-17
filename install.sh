#!/bin/bash
# Claude Code & Codex 优化配置安装脚本
# 运行方式: bash install.sh

set -e

CONFIG_DIR="$HOME/Desktop/编程/Claude Code配置"
CLAUDE_DIR="$HOME/.claude"
CODEX_DIR="$HOME/.codex"

echo "🚀 开始安装 Claude Code & Codex 优化配置..."
echo ""

# ==========================================
# 1. 配置 Claude Code
# ==========================================
echo "📁 配置 Claude Code..."

# 创建 Claude 配置目录
mkdir -p "$CLAUDE_DIR"

# 复制 settings.json
if [ -f "$CONFIG_DIR/settings.json" ]; then
    cp "$CONFIG_DIR/settings.json" "$CLAUDE_DIR/settings.json"
    echo "   ✅ settings.json 已安装"
else
    echo "   ⚠️  settings.json 未找到"
fi

echo ""

# ==========================================
# 2. 配置 Codex
# ==========================================
echo "📁 配置 Codex CLI..."

# 创建 Codex 配置目录
mkdir -p "$CODEX_DIR"

# 复制 config.toml
if [ -f "$CONFIG_DIR/codex/config.toml" ]; then
    cp "$CONFIG_DIR/codex/config.toml" "$CODEX_DIR/config.toml"
    echo "   ✅ config.toml 已安装"
else
    echo "   ⚠️  config.toml 未找到"
fi

# 复制 instructions.md
if [ -f "$CONFIG_DIR/codex/instructions.md" ]; then
    cp "$CONFIG_DIR/codex/instructions.md" "$CODEX_DIR/instructions.md"
    echo "   ✅ instructions.md 已安装"
else
    echo "   ⚠️  instructions.md 未找到"
fi

echo ""

# ==========================================
# 3. 提示复制 CLAUDE.md
# ==========================================
echo "📋 CLAUDE.md 项目规则文件"
echo "   📌 请手动复制到你的项目根目录:"
echo "   cp \"$CONFIG_DIR/CLAUDE.md\" /你的项目路径/"
echo ""

# ==========================================
# 4. 完成
# ==========================================
echo "=========================================="
echo "✅ 安装完成！"
echo "=========================================="
echo ""
echo "📌 已安装的配置:"
echo "   • Claude Code: ~/.claude/settings.json"
echo "   • Codex CLI: ~/.codex/config.toml"
echo "   • Codex 指令: ~/.codex/instructions.md"
echo ""
echo "📌 使用方法:"
echo "   • 输入 'glm' 启动智谱 GLM 版 Claude Code"
echo "   • 输入 'kimi' 启动月之暗面 Kimi 版 Claude Code"
echo "   • 输入 'codex' 启动 Codex CLI (需先安装)"
echo ""
echo "📌 安装 Codex CLI:"
echo "   npm install -g @openai/codex"
echo ""
echo "🎉 享受智能编程之旅！"

