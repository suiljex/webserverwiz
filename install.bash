#!/usr/bin/env bash

[ "$EUID" -ne 0 ] && echo "Please run as root" && exit 1

SCRIPT_NAME=$0
SCRIPT_FULL_PATH=$(dirname "$0")

PACKAGES="nginx certbot"

CMD_INSTALL_PKG="apt-get install -y "
CMD_UPGRADE="apt-get update && apt-get upgrade -y"
CMD_MKDIR="mkdir -p "
CMD_MV="mv "
CMD_SETUID="chmod u+s "

eval ${CMD_UPGRADE}
eval ${CMD_INSTALL_PKG} ${PACKAGES}

eval ${CMD_MKDIR} "/var/www/letsencrypt"
eval ${CMD_MKDIR} "/etc/letsencrypt"
eval ${CMD_MKDIR} "/etc/nginx/conf.d"

eval ${CMD_MV} "${SCRIPT_FULL_PATH}/certctl"        "/usr/bin/certctl"
eval ${CMD_MV} "${SCRIPT_FULL_PATH}/nginx_conf.d/*" "/etc/nginx/conf.d/"

eval ${CMD_SETUID} "/usr/bin/certctl"