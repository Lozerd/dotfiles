#!/usr/bin/env bash

set -euo pipefail

CONF_DIR="/etc/amnezia/amneziawg"
SERVICE_PREFIX="awg-quick@"

# Find active service (if any)
UNITS=$(
  systemctl list-units \
      --type=service \
      --all \
      --no-legend |
  awk '/^[● ]*awg-quick@/ {print $1}'
)

if [[ -n "$UNITS" ]]; then
  for unit in $UNITS; do
    sudo systemctl stop "$unit" 2>/dev/null || true
    sudo systemctl reset-failed "$unit" 2>/dev/null || true
  done
  exit 0
fi

sudo resolvconf -u

# VPN inactive → pick random config
CONF=$(ls "$CONF_DIR"/*.conf 2>/dev/null | shuf -n 1)

[ -z "$CONF" ] && exit 1

NAME=$(basename "$CONF" .conf)
sudo systemctl start "${SERVICE_PREFIX}${NAME}.service"
