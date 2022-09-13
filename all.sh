#!/usr/bin/env bash
set -euo pipefail

UP_OR_DOWN="$1"
if [ "$UP_OR_DOWN" != "up" ] && [ "$UP_OR_DOWN" != "down" ]; then
  echo "all.sh expected \$1 of 'up' or 'down' but found '$UP_OR_DOWN'" >&2
  exit 1
fi

dir_path() {
  # https://stackoverflow.com/a/43919044
  a="/$0"; a="${a%/*}"; a="${a:-.}"; a="${a##/}/"; BINDIR=$(cd "$a"; pwd)
  echo "$BINDIR"
}
DIR_PATH=`dir_path`

COMPOSE_ARGS=()
if [ "$UP_OR_DOWN" = "up" ]; then
  COMPOSE_ARGS+=('-d')
fi

for COMPOSE_DIR in 'cloudflare_tunnel' 'authentik' 'nginx_proxy_manager'; do
  echo "Bringing $UP_OR_DOWN '$COMPOSE_DIR'..."
  (cd "$DIR_PATH/$COMPOSE_DIR" && docker-compose "$UP_OR_DOWN" ${COMPOSE_ARGS[@]+"${COMPOSE_ARGS[@]}"}) || echo '^^ ERROR ^^'
  echo ''
done
