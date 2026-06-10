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

# Copy config.yaml into HERMES_HOME if not already there
if [ ! -f "$HERMES_HOME/config.yaml" ] && [ -f /app/config.yaml ]; then
    cp /app/config.yaml "$HERMES_HOME/config.yaml"
    echo "[entrypoint] config.yaml copied to $HERMES_HOME"
fi

# Write .env - explicitly set WEIXIN_ALLOW_ALL_USERS and DeepSeek key
cat > "$HERMES_HOME/.env" << ENVEOF
WEIXIN_ALLOW_ALL_USERS=true
DEEPSEEK_API_KEY=${DEEPSEEK_API_KEY:-}
WEIXIN_ACCOUNT_ID=${WEIXIN_ACCOUNT_ID:-}
WEIXIN_TOKEN=${WEIXIN_TOKEN:-}
WEIXIN_BASE_URL=${WEIXIN_BASE_URL:-}
WEIXIN_CDN_BASE_URL=${WEIXIN_CDN_BASE_URL:-}
WEIXIN_DM_POLICY=${WEIXIN_DM_POLICY:-pairing}
ENVEOF

# Also export for subprocesses
export WEIXIN_ALLOW_ALL_USERS=true
export GATEWAY_ALLOW_ALL_USERS=true

echo "[entrypoint] .env written"
echo "[entrypoint] Running: hermes gateway run"
exec hermes gateway run
