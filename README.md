# bebot Lavalink Server

Standalone Lavalink v4 audio server for bebot.

Recommended layout:

Discord -> bebot (Railway) -> Lavalink (separate Docker host/VPS) -> audio source

The Docker build uses the official Lavalink v4 image and downloads the latest
release JAR from the official `lavalink-devs/youtube-source` GitHub repository
during image build.

## Recommended deployment

Use a separate Docker-capable VPS/host for Lavalink. Your previous direct
YouTube playback attempt was challenged from Railway with "Sign in to confirm
you're not a bot", so putting Lavalink on the same kind of Railway network may
reproduce that source-side block.

## Docker/VPS setup

1. Upload these files to a new GitHub repository.
2. On the VPS/server, clone the repo.
3. Copy `.env.example` to `.env`.
4. Set a strong random password:
   `LAVALINK_PASSWORD=YOUR_LONG_RANDOM_PASSWORD`
5. Run:
   `docker compose up -d --build`
6. Watch startup:
   `docker compose logs -f lavalink`
7. Make TCP port 2333 reachable by bebot.

## Optional Railway test

This repo includes `railway.toml`. You can deploy it on Railway for testing,
but the original YouTube anti-bot challenge may happen again there.

Set:
`LAVALINK_PASSWORD=YOUR_LONG_RANDOM_PASSWORD`

## Values bebot will need later

LAVALINK_HOST=your-host-or-domain
LAVALINK_PORT=2333
LAVALINK_PASSWORD=YOUR_LONG_RANDOM_PASSWORD
LAVALINK_SECURE=false

If you put Lavalink behind HTTPS/WSS:

LAVALINK_PORT=443
LAVALINK_SECURE=true

## Important

Do not put your Discord bot token, Lavalink password, or personal YouTube
cookies in a public GitHub repository.

Before changing bebot again, confirm the Lavalink logs show that the server
started and the YouTube plugin loaded.
