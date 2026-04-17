#!/bin/bash
# Claude Code 别名安装脚本
# 运行此脚本将自动配置 glm 和 kimi 命令别名

CONFIG_DIR="$HOME/Desktop/编程/Claude Code配置"
SHELL_RC="$HOME/.zshrc"

# 检查是否已存在配置
if grep -q "# Claude Code 配置别名" "$SHELL_RC" 2>/dev/null; then
    echo "⚠️  别名配置已存在，正在更新..."
    # 删除旧配置
    sed -i '' '/# Claude Code 配置别名/,/# Claude Code 配置结束/d' "$SHELL_RC"
fi

# 添加新配置
cat >> "$SHELL_RC" << 'EOF'

# Claude Code 配置别名 (由 setup_aliases.sh 生成)
# GLM (智谱) 命令
glm() {
    source "$HOME/Desktop/编程/Claude Code配置/glm.sh"
    claude "$@"
}

# Kimi (月之暗面) 命令  
kimi() {
    source "$HOME/Desktop/编程/Claude Code配置/kimi.sh"
    claude "$@"
}
# Claude Code 配置结束
EOF

echo "✅ 别名配置完成！"
echo ""
echo "📌 使用方法："
echo "   glm  - 使用智谱 GLM-4.7 启动 Claude Code"
echo "   kimi - 使用月之暗面 Kimi-K2 启动 Claude Code"
echo ""
echo "⚠️  请执行以下命令使配置生效："
echo "   source ~/.zshrc"
echo ""
echo "或者重新打开一个新的终端窗口"

