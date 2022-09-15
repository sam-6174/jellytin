#!/usr/bin/env bash
set -euo pipefail

##
# This is a helper script to run docker-compose
# commands against all the stacks in this repo
#
# for example:
#   `./all.sh up -d`
#   `./all.sh ps`
#   `./all.sh down`
##

dir_path() {
  # https://stackoverflow.com/a/43919044
  a="/$0"; a="${a%/*}"; a="${a:-.}"; a="${a##/}/"; BINDIR=$(cd "$a"; pwd)
  echo "$BINDIR"
}
DIR_PATH=`dir_path`

for COMPOSE_DIR in 'cloudflare_tunnel' 'authentik' 'authentik_ldap' 'nginx_proxy_manager'; do
  (cd "$DIR_PATH/$COMPOSE_DIR" && docker-compose "$@") || echo '^^ ERROR ^^'
  echo ''
done
