#!/bin/bash

# Codex 代理设置脚本
# 用于配置 Codex 的网络代理

set -e

echo "🌐 Codex 代理设置脚本"
echo "======================"
echo ""

# 颜色定义
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

SHELL_CONFIG=""
if [ -f "$HOME/.zshrc" ]; then
    SHELL_CONFIG="$HOME/.zshrc"
elif [ -f "$HOME/.bash_profile" ]; then
    SHELL_CONFIG="$HOME/.bash_profile"
elif [ -f "$HOME/.bashrc" ]; then
    SHELL_CONFIG="$HOME/.bashrc"
fi

if [ -z "$SHELL_CONFIG" ]; then
    echo -e "${RED}❌ 未找到 shell 配置文件${NC}"
    exit 1
fi

echo "检测到配置文件: $SHELL_CONFIG"
echo ""

# 检查是否已有代理设置
if grep -q "HTTP_PROXY\|HTTPS_PROXY" "$SHELL_CONFIG" 2>/dev/null; then
    echo -e "${YELLOW}⚠️  检测到已有代理设置${NC}"
    echo "当前设置:"
    grep -E "HTTP_PROXY|HTTPS_PROXY" "$SHELL_CONFIG" | head -4
    echo ""
    read -p "是否要更新代理设置? (y/n): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "已取消"
        exit 0
    fi
fi

# 获取代理地址
echo "请输入代理地址（例如: http://127.0.0.1:7890）"
read -p "HTTP/HTTPS 代理: " PROXY_URL

if [ -z "$PROXY_URL" ]; then
    echo -e "${RED}❌ 代理地址不能为空${NC}"
    exit 1
fi

# 验证代理格式
if [[ ! $PROXY_URL =~ ^https?:// ]]; then
    echo -e "${YELLOW}⚠️  代理地址格式可能不正确，建议使用 http:// 或 https:// 开头${NC}"
    read -p "是否继续? (y/n): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 0
    fi
fi

# 备份配置文件
cp "$SHELL_CONFIG" "$SHELL_CONFIG.backup.$(date +%Y%m%d_%H%M%S)"
echo -e "${GREEN}✅ 已备份配置文件${NC}"

# 移除旧的代理设置
sed -i.bak '/HTTP_PROXY\|HTTPS_PROXY\|http_proxy\|https_proxy/d' "$SHELL_CONFIG"

# 添加新的代理设置
echo "" >> "$SHELL_CONFIG"
echo "# Codex 代理设置" >> "$SHELL_CONFIG"
echo "export HTTP_PROXY=\"$PROXY_URL\"" >> "$SHELL_CONFIG"
echo "export HTTPS_PROXY=\"$PROXY_URL\"" >> "$SHELL_CONFIG"
echo "export http_proxy=\"$PROXY_URL\"" >> "$SHELL_CONFIG"
echo "export https_proxy=\"$PROXY_URL\"" >> "$SHELL_CONFIG"

echo -e "${GREEN}✅ 代理设置已添加${NC}"
echo ""
echo "新的代理设置:"
echo "  HTTP_PROXY=$PROXY_URL"
echo "  HTTPS_PROXY=$PROXY_URL"
echo ""
echo -e "${YELLOW}⚠️  请运行以下命令使配置生效:${NC}"
echo "  source $SHELL_CONFIG"
echo ""
echo "或者重新打开终端"

# 测试连接
echo "测试连接..."
source "$SHELL_CONFIG"
if curl -I --connect-timeout 5 --proxy "$PROXY_URL" https://chatgpt.com &>/dev/null; then
    echo -e "${GREEN}✅ 连接测试成功！${NC}"
else
    echo -e "${YELLOW}⚠️  连接测试失败，请检查代理是否正常运行${NC}"
    echo "   确保代理软件已启动，并且端口正确"
fi

