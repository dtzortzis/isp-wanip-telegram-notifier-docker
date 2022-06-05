# ISP WAN IP - Telegram Notifier | Docker Container Version
[Docker Hub: dtzortzis/isp-wanip-telegram-notifier](https://hub.docker.com/r/dtzortzis/isp-wanip-telegram-notifier)

Sends a [Telegram](https://telegram.org/) notification message when your WAN IP address changes.

Uses [ipconfig.io](http://ipconfig.io/) to detect if you WAN IP address changed.

Script uses [alpine](https://hub.docker.com/_/alpine) to runs, after docker container starting up, every 15 minutes scrips checking if the WAN IP Address has changed.

## Telegram Guides
* For information how to obtain Telegram BOT API Token check the following [guide](https://core.telegram.org/bots).
* For information about Telegram BOT API usage and configuration check the following [guide](https://core.telegram.org/bots/api).
* For information how to obtain Telegram ChatID check the following [guide](https://docs.influxdata.com/kapacitor/v1.6/event_handlers/telegram/).

## Usage
```sh
docker run -d \
	--name isp-wanip-telegram-notifier \
    -e TG_API_Token="XXXXXXXXXX:XXXXXXXX_XXXXXXXXXXXXXXXXXXXX-XXXXX" \
    -e TG_Chat_ID="XXXXXXXXXX" \
    dtzortzis/isp-wanip-telegram-notifier
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

## License
MIT