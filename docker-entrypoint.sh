#!/bin/bash
set -e

# Ensure Hermes home exists
mkdir -p "$HERMES_HOME"
mkdir -p "$HERMES_HOME/weixin/accounts"
mkdir -p "$HERMES_HOME/memories"
mkdir -p "$HERMES_HOME/skills"
mkdir -p "$HERMES_HOME/workspace"
mkdir -p "$HERMES_HOME/logs"

# Write env vars from Railway env
python3 -c "
import os
path = os.path.join(os.environ.get('HERMES_HOME',''), '.env')
with open(path, 'w') as f:
    for key in ['DEEPSEEK_API_KEY', 'WEIXIN_ACCOUNT_ID', 'WEIXIN_TOKEN', 
                'WEIXIN_BASE_URL', 'WEIXIN_CDN_BASE_URL', 'WEIXIN_DM_POLICY',
                'OPENAI_API_KEY']:
        val = os.environ.get(key, '')
        if val:
            f.write(f'{key}={val}\n')
"

# Run Hermes
exec hermes "$@"
