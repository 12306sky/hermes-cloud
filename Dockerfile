FROM python:3.11-slim

# 预装编译依赖（hermes-agent 有些包需要编译）
RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc libffi-dev && rm -rf /var/lib/apt/lists/*

# 安装 hermes-agent（包含 hermes CLI）
RUN pip install --no-cache-dir hermes-agent

# 验证安装
RUN hermes --version

ENV HERMES_HOME=/data/hermes

WORKDIR /app

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 9119

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["gateway", "run"]
