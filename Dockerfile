FROM openjdk:17-jdk-slim as server-builder

WORKDIR /app/server

COPY server/ .

#Build server
RUN ./gradlew build -x test


COPY main-EA/ .

FROM openjdk:17-jre-slim

#bc ubuntu image
RUN apt-get update && \
    apt-get install -y nginx && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY --from=server-builder /app/server/build/libs/*.jar ./server.jar

COPY --from=flutter-builder /app/flutter/build/web /var/www/html

COPY <<EOF /etc/nginx/sites-available/default
server {
    listen 80;
    server_name _;
}
EOF

EXPOSE 80 8080

COPY <<EOF /app/start.sh
#!/bin/bash
set -e

nginx

exec java -jar server.jar
EOF

RUN chmod +x /app/start.sh

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:80/ || exit 1

CMD ["/app/start.sh"]
