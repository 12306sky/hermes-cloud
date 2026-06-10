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

# Write env vars from Railway env into .env
python3 << 'PYEOF'
import os
path = os.path.join(os.environ.get('HERMES_HOME', '/data/hermes'), '.env')
with open(path, 'w') as f:
    for key in ['DEEPSEEK_API_KEY', 'OPENAI_API_KEY',
                'WEIXIN_ACCOUNT_ID', 'WEIXIN_TOKEN',
                'WEIXIN_BASE_URL', 'WEIXIN_CDN_BASE_URL', 'WEIXIN_DM_POLICY',
                'WEIXIN_ALLOW_ALL_USERS', 'WEIXIN_ALLOWED_USERS']:
        val = os.environ.get(key, '')
        if val:
            f.write(f'{key}={val}\n')
print(f'.env written to {path}')
PYEOF

echo "[entrypoint] Running: hermes gateway run"
exec hermes gateway run
