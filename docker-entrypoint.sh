#!/bin/bash
set -e

echo "[entrypoint] Starting Hermes Agent..."
echo "[entrypoint] HERMES_HOME=$HERMES_HOME"

# Ensure Hermes home exists
mkdir -p "$HERMES_HOME"
mkdir -p "$HERMES_HOME/weixin/accounts"
mkdir -p "$HERMES_HOME/memories"
mkdir -p "$HERMES_HOME/skills"
mkdir -p "$HERMES_HOME/workspace"
mkdir -p "$HERMES_HOME/logs"

# Write .env - explicitly force WEIXIN_ALLOW_ALL_USERS=true
cat > "$HERMES_HOME/.env" << ENVEOF
WEIXIN_ALLOW_ALL_USERS=true
DEEPSEEK_API_KEY=${DEEPSEEK_API_KEY:-}
WEIXIN_ACCOUNT_ID=${WEIXIN_ACCOUNT_ID:-}
WEIXIN_TOKEN=${WEIXIN_TOKEN:-}
WEIXIN_BASE_URL=${WEIXIN_BASE_URL:-}
WEIXIN_CDN_BASE_URL=${WEIXIN_CDN_BASE_URL:-}
WEIXIN_DM_POLICY=${WEIXIN_DM_POLICY:-pairing}
ENVEOF

# Also export so os.environ sees it
export WEIXIN_ALLOW_ALL_USERS=true
export GATEWAY_ALLOW_ALL_USERS=true

echo "[entrypoint] .env written with WEIXIN_ALLOW_ALL_USERS=true"
echo "[entrypoint] Env check: WEIXIN_ALLOW_ALL_USERS=$WEIXIN_ALLOW_ALL_USERS"
echo "[entrypoint] Running: hermes gateway run"
exec hermes gateway run
