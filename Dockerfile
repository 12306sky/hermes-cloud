FROM python:3.11-slim

RUN pip install hermes-agent==0.16.0

ENV HERMES_HOME=/data/hermes

WORKDIR /app

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 9119

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["gateway", "run"]
