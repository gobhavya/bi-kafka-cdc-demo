#!/usr/bin/env bash
set -euo pipefail

CONNECT_URL="${CONNECT_URL:-http://localhost:8083}"

printf "Waiting for Kafka Connect at %s" "$CONNECT_URL"
until curl -fsS "$CONNECT_URL/connectors" >/dev/null 2>&1; do
  printf "."
  sleep 5
done
printf "\nKafka Connect is ready.\n"

register_connector() {
  local file=$1
  local name
  name=$(python3 -c "import json; print(json.load(open('$file'))['name'])")

  if curl -fsS "$CONNECT_URL/connectors/$name" >/dev/null 2>&1; then
    echo "Updating connector: $name"
    python3 -c "import json; print(json.dumps(json.load(open('$file'))['config']))" \
      | curl -fsS -X PUT -H "Content-Type: application/json" --data @- "$CONNECT_URL/connectors/$name/config" >/dev/null
  else
    echo "Creating connector: $name"
    curl -fsS -X POST -H "Content-Type: application/json" --data @"$file" "$CONNECT_URL/connectors" >/dev/null
  fi
}

register_connector "connectors/debezium-postgres-source.json"
register_connector "connectors/jdbc-postgres-sink.json"

echo "Registered connectors:"
curl -fsS "$CONNECT_URL/connectors" && echo
