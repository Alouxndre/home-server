#!/bin/sh
set -eu

PROJECT_DIR="/srv/homeassistant"
COMPOSE_FILE="${PROJECT_DIR}/homeassistant-compose.yml"

if ! command -v docker >/dev/null 2>&1; then
  echo "docker not found; skipping reverse proxy reload"
  exit 0
fi

if [ ! -f "$COMPOSE_FILE" ]; then
  echo "compose file not found at $COMPOSE_FILE; skipping reverse proxy reload"
  exit 0
fi

cd "$PROJECT_DIR"
docker compose -f "$COMPOSE_FILE" exec -T reverse_proxy nginx -s reload ||
  docker compose -f "$COMPOSE_FILE" restart reverse_proxy
