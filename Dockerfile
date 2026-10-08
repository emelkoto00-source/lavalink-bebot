FROM alpine:3.21 AS youtube_plugin

RUN apk add --no-cache curl jq ca-certificates

RUN set -eux; \
    API="https://api.github.com/repos/lavalink-devs/youtube-source/releases/latest"; \
    URL="$(curl -fsSL "$API" \
      | jq -r '.assets[] | select(.name | test("youtube.*plugin.*\\.jar$"; "i")) | .browser_download_url' \
      | head -n 1)"; \
    if [ -z "$URL" ] || [ "$URL" = "null" ]; then \
      echo "Could not find a YouTube plugin JAR in the latest youtube-source release."; \
      exit 1; \
    fi; \
    echo "Downloading YouTube plugin: $URL"; \
    curl -fL "$URL" -o /youtube-plugin.jar

FROM ghcr.io/lavalink-devs/lavalink:4

COPY application.yml /opt/Lavalink/application.yml
COPY --from=youtube_plugin /youtube-plugin.jar /opt/Lavalink/plugins/youtube-plugin.jar

EXPOSE 2333
