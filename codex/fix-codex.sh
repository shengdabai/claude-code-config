#!/bin/bash

# Codex 配置修复脚本
# 用途: 修复 wire_api 配置和模型名称问题

set -e

echo "🔧 Codex 配置修复脚本"
echo "===================="
echo ""

# 颜色定义
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# 1. 检查配置文件是否存在
CONFIG_DIR="$HOME/.codex"
CONFIG_FILE="$CONFIG_DIR/config.toml"
SOURCE_CONFIG="$(dirname "$0")/config.toml"

echo "📋 步骤 1: 检查配置文件..."
if [ ! -f "$CONFIG_FILE" ]; then
    echo -e "${YELLOW}⚠️  配置文件不存在，正在创建...${NC}"
    mkdir -p "$CONFIG_DIR"
    if [ -f "$SOURCE_CONFIG" ]; then
        cp "$SOURCE_CONFIG" "$CONFIG_FILE"
        echo -e "${GREEN}✅ 配置文件已创建${NC}"
    else
        echo -e "${RED}❌ 源配置文件不存在: $SOURCE_CONFIG${NC}"
        exit 1
    fi
else
    echo -e "${GREEN}✅ 配置文件已存在${NC}"
fi

# 2. 检查 wire_api 配置
echo ""
echo "📋 步骤 2: 检查 wire_api 配置..."
if grep -q 'wire_api = "responses"' "$CONFIG_FILE"; then
    echo -e "${GREEN}✅ wire_api 配置已存在${NC}"
else
    echo -e "${YELLOW}⚠️  正在添加 wire_api 配置...${NC}"
    # 为每个 model_provider 添加 wire_api
    sed -i.bak '/\[model_providers\./a\
wire_api = "responses"  # 修复 deprecated "chat" API 警告
' "$CONFIG_FILE"
    echo -e "${GREEN}✅ wire_api 配置已添加${NC}"
fi

# 3. 检查模型名称
echo ""
echo "📋 步骤 3: 检查模型名称..."
if grep -q 'model = "glm-4.5"' "$CONFIG_FILE"; then
    echo -e "${YELLOW}⚠️  检测到可能不存在的模型名称 glm-4.5，建议修改为 glm-4${NC}"
    read -p "是否自动修改为 glm-4? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        sed -i.bak 's/model = "glm-4.5"/model = "glm-4"/g' "$CONFIG_FILE"
        echo -e "${GREEN}✅ 模型名称已修改为 glm-4${NC}"
    fi
else
    echo -e "${GREEN}✅ 模型名称检查通过${NC}"
fi

# 4. 检查 API Key 环境变量
echo ""
echo "📋 步骤 4: 检查 API Key 环境变量..."
SHELL_CONFIG=""
if [ -f "$HOME/.zshrc" ]; then
    SHELL_CONFIG="$HOME/.zshrc"
elif [ -f "$HOME/.bash_profile" ]; then
    SHELL_CONFIG="$HOME/.bash_profile"
elif [ -f "$HOME/.bashrc" ]; then
    SHELL_CONFIG="$HOME/.bashrc"
fi

if [ -z "$SHELL_CONFIG" ]; then
    echo -e "${YELLOW}⚠️  未找到 shell 配置文件${NC}"
else
    echo "检查 $SHELL_CONFIG..."
    
    # 检查各个 API Key
    KEYS_MISSING=0
    
    if ! grep -q "ZHIPUAI_API_KEY" "$SHELL_CONFIG" 2>/dev/null; then
        echo -e "${YELLOW}⚠️  ZHIPUAI_API_KEY 未设置${NC}"
        KEYS_MISSING=1
    else
        echo -e "${GREEN}✅ ZHIPUAI_API_KEY 已配置${NC}"
    fi
    
    if [ "$KEYS_MISSING" -eq 1 ]; then
        echo ""
        echo -e "${YELLOW}💡 提示: 请手动添加 API Key 到 $SHELL_CONFIG${NC}"
        echo "例如:"
        echo '  export ZHIPUAI_API_KEY="你的API密钥"'
        echo ""
        read -p "是否现在添加? (y/n): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            read -p "请输入 ZHIPUAI_API_KEY: " API_KEY
            echo "" >> "$SHELL_CONFIG"
            echo "# Codex API Key" >> "$SHELL_CONFIG"
            echo "export ZHIPUAI_API_KEY=\"$API_KEY\"" >> "$SHELL_CONFIG"
            echo -e "${GREEN}✅ API Key 已添加到 $SHELL_CONFIG${NC}"
            echo -e "${YELLOW}⚠️  请运行: source $SHELL_CONFIG${NC}"
        fi
    fi
fi

# 5. 验证配置
echo ""
echo "📋 步骤 5: 验证配置..."
if [ -f "$CONFIG_FILE" ]; then
    echo -e "${GREEN}✅ 配置文件验证通过${NC}"
    echo ""
    echo "当前配置摘要:"
    echo "---"
    grep -E "^(model_provider|model|wire_api)" "$CONFIG_FILE" | head -5
    echo "---"
else
    echo -e "${RED}❌ 配置文件验证失败${NC}"
    exit 1
fi

# 6. 完成提示
echo ""
echo -e "${GREEN}✅ 修复完成！${NC}"
echo ""
echo "下一步操作:"
echo "1. 如果修改了 API Key，请运行: source $SHELL_CONFIG"
echo "2. 重新启动终端或运行: codex"
echo "3. 如果仍有问题，请查看: 故障排查.md"
echo ""

