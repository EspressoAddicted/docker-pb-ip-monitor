# Docker Pushbullet IP Monitor

[Docker Hub: emcniece/pb-ip-monitor/](https://hub.docker.com/r/emcniece/pb-ip-monitor/)

Sends a [Pushbullet](https://www.pushbullet.com/) notification when your external IP address changes.

Uses [ipconfig.io](http://ipconfig.io/) to detect address.

Script runs when starting up, then on 15 minute cron intervals.

## Usage

```sh
docker run -d \
    -e PB_TOKEN="my-pushbullet-api-token" \
    -e NOTE_TITLE="IP Address Changed!" \
    emcniece/pb-ip-monitor
```

## Building

The Makefile contains commands for quick building.

**Optional**: `cp .env-sample .env` and add your token here so you can quickly `source .env` before using the Makefile.

```sh
# List commands
make

# Build image
make image

# Run container
make run

# Run debug mode
make run-debug

# Execute test-parts for cron
make test-cron
```
