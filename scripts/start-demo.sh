#!/usr/bin/env bash
set -euo pipefail

docker compose up -d
./scripts/register-connectors.sh

echo "Demo is running. See README.md for psql test commands."
