# Codex OpenAI 账户配置指南

## 🔍 问题分析

当使用 **OpenAI 账户登录** Codex 时，Codex 使用的是自己的模型系统（如 `gpt-5.2-codex`），而不是标准的 OpenAI API。这可能导致配置问题。

## ✅ 解决方案

### 方案一：使用 Codex 内置模型（推荐）

Codex 使用 OpenAI 账户登录时，**不需要配置 model_provider**，Codex 会自动使用内置模型。

**步骤**：

1. **简化配置文件**，移除或注释掉 model_provider：

```toml
# ==========================================
# 默认模型配置
# ==========================================
# 使用 OpenAI 账户登录时，Codex 会自动使用内置模型
# 不需要设置 model_provider 和 model
# model_provider = "openai"
# model = "gpt-4-turbo"

# 审批模式
approval_mode = "suggest"
model_reasoning_effort = "medium"  # low, medium, high
```

2. **在 Codex 中切换模型**：

启动 Codex 后，使用内置命令切换模型：
```
/model
```

然后选择可用的模型（如 `gpt-5.2-codex`）。

### 方案二：配置标准 OpenAI API（如果需要）

如果你需要使用标准的 OpenAI API（需要 API Key）：

1. **获取 OpenAI API Key**：
   - 访问 https://platform.openai.com/api-keys
   - 创建新的 API Key

2. **设置环境变量**：
```bash
export OPENAI_API_KEY="sk-..."
echo 'export OPENAI_API_KEY="sk-..."' >> ~/.zshrc
source ~/.zshrc
```

3. **配置 model_provider**：
```toml
model_provider = "openai"
model = "gpt-4-turbo"  # 或 gpt-4, gpt-3.5-turbo
```

## 🛠️ 故障排查

### 错误：`404 Not Found`

**原因**：
- Codex 尝试使用配置的 model_provider，但该 provider 不可用
- 使用 OpenAI 账户登录时，应该让 Codex 使用内置模型系统

**解决**：
1. 移除配置文件中的 `model_provider` 和 `model` 设置
2. 在 Codex 中使用 `/model` 命令选择模型
3. 确保已正确登录 OpenAI 账户

### 错误：`模型不存在`

**原因**：
- 配置的模型名称不正确
- 使用了不支持的模型名称

**解决**：
- 使用 Codex 内置的 `/model` 命令查看可用模型
- 不要手动配置模型名称，让 Codex 自动管理

## 📋 推荐配置（OpenAI 账户登录）

```toml
# Codex CLI 配置文件
# 适用于使用 OpenAI 账户登录的情况

# ==========================================
# 默认配置
# ==========================================
# 注意：使用 OpenAI 账户登录时，不需要设置 model_provider
# Codex 会自动使用内置模型系统
# 使用 /model 命令在 Codex 中切换模型

# 审批模式
approval_mode = "suggest"
model_reasoning_effort = "medium"

# ==========================================
# 历史记录配置
# ==========================================
[history]
persistence = "save-all"
max_turns = 50
retention_days = 30

# ==========================================
# 其他模型提供商（可选，用于切换）
# ==========================================
[model_providers.openai]
name = "openai"
base_url = "https://api.openai.com/v1"
env_key = "OPENAI_API_KEY"
wire_api = "responses"

[model_providers.glm]
name = "zhipu"
base_url = "https://open.bigmodel.cn/api/coding/paas/v4"
env_key = "ZHIPUAI_API_KEY"
wire_api = "responses"
```

## 🎯 使用步骤

1. **更新配置文件**：
```bash
cp ~/Desktop/编程/Claude\ Code配置/codex/config.toml ~/.codex/config.toml
```

2. **编辑配置文件**，移除或注释掉 `model_provider` 和 `model`：
```bash
code ~/.codex/config.toml
```

3. **启动 Codex**：
```bash
codex
```

4. **在 Codex 中切换模型**：
```
/model
```

5. **选择模型**（如 `gpt-5.2-codex medium`）

## ⚠️ 重要提示

- **OpenAI 账户登录**：Codex 使用自己的认证系统，不需要 API Key
- **模型选择**：使用 `/model` 命令在 Codex 内部切换，不要手动配置
- **订阅要求**：确保你的 OpenAI 账户有 Codex 访问权限（Plus/Pro/Business 等）

---

*最后更新: 2024.12*

