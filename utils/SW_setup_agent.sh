#!/bin/bash
set -e
SERVER_IP=$1
TOKEN=$2

echo ">>> ARGS reçus : SERVER_IP='$1' TOKEN='$2'"

until curl -skf "https://${SERVER_IP}:6443/ping" >/dev/null 2>&1; do
  echo "En attente du serveur K3s..."; sleep 3
done

curl -sfL https://get.k3s.io | sh -s - agent \
  --server="https://${SERVER_IP}:6443" \
  --token="${TOKEN}"

