#!/usr/bin/env bash

set -euo pipefail

CONF_DIR="/etc/amnezia/amneziawg"
SERVICE_PREFIX="awg-quick@"

# Find active service (if any)
ACTIVE=$(
sudo systemctl list-units \
      --type=service \
      --state=active \
    | grep awg-quick@ | awk '{print $1}'
)

if [[ -n "$ACTIVE" ]]; then
  # VPN is active → stop it
  sudo systemctl stop "$ACTIVE"
  exit 0
fi

# VPN inactive → pick random config
CONF=$(ls "$CONF_DIR"/*.conf 2>/dev/null | shuf -n 1)

if [[ -z "$CONF" ]]; then
  exit 1
fi

NAME=$(basename "$CONF" .conf)
sudo systemctl start "${SERVICE_PREFIX}${NAME}.service"
