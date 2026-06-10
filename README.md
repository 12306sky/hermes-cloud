# Hermes Agent on Railway

Deploy your Hermes AI agent to Railway for 24/7 availability.

## Environment Variables

Set these in Railway dashboard:

| Variable | Description |
|----------|-------------|
| `DEEPSEEK_API_KEY` | DeepSeek API key |
| `OPENAI_API_KEY` | OpenAI/SiliconFlow API key |
| `WEIXIN_ACCOUNT_ID` | WeChat bot account ID |
| `WEIXIN_TOKEN` | WeChat bot token |
| `WEIXIN_BASE_URL` | WeChat API base URL |
| `WEIXIN_CDN_BASE_URL` | WeChat CDN URL |
| `WEIXIN_DM_POLICY` | DM policy (pairing) |
| `HERMES_HOME` | Data directory (default /data/hermes) |

## Persistent Data

Railway Volume mounts to `/data/hermes` for WeChat sessions, memory, and state.

## Deployment

1. Push this repo to GitHub
2. Connect to Railway
3. Add a Volume at `/data/hermes`
4. Set env vars from your `.env`
5. Deploy!
