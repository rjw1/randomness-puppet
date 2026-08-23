#!/bin/bash
# Check IPv6 connectivity and restart systemd-networkd if it's gone AWOL.
#
# Pings a literal IPv6 address first (no DNS dependency) then falls back
# to a hostname lookup, so a resolver hiccup alone won't trigger a restart.
set -uo pipefail

PING_BIN=$(command -v ping6 || command -v ping)
TARGETS=("2001:4860:4860::8888" "google.com")

for target in "${TARGETS[@]}"; do
  if "$PING_BIN" -6 -c 1 -W 5 "$target" >/dev/null 2>&1; then
    exit 0
  fi
done

logger -t ipv6-watchdog "IPv6 connectivity check failed against: ${TARGETS[*]}; restarting systemd-networkd"
systemctl restart systemd-networkd
