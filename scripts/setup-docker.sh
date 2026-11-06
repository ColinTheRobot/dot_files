#!/usr/bin/env bash
set -euo pipefail

mkdir -p ~/.docker/cli-plugins
ln -sfn "$(brew --prefix)/opt/docker-compose/bin/docker-compose" ~/.docker/cli-plugins/docker-compose

if ! colima status >/dev/null 2>&1; then
  colima start --cpu 4 --memory 8 --disk 60 --vm-type vz --mount-type virtiofs
fi

docker context use colima
docker compose version
docker info --format 'Docker {{.ServerVersion}} on {{.OperatingSystem}}'
