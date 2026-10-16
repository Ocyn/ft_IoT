#!/bin/bash
set -e
SERVER_IP=$1
TOKEN=$2
WORKER_IP=$3

# Check if arg are correctly set up
echo ">>> ARGS reçus : SERVER_IP='$1' TOKEN='$2' WORKER_IP='$3'"

# [ -f /usr/local/bin/k3s-agent-uninstall.sh ] && /usr/local/bin/k3s-agent-uninstall.sh || true

# Auto install in Worker mode
curl -sfL https://get.k3s.io | sh -s - agent \
  --server="https://${SERVER_IP}:6443" \
  --token="${TOKEN}" \
  --node-ip="${WORKER_IP}"

# wait until server is joinable
until curl -skf "https://${SERVER_IP}:6443/ping" 2>&1; do
  sleep 4
done

# Check k3s-agent service running
sudo systemctl status k3s-agent --no-pager