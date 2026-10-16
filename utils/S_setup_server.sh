#!/bin/bash
set -e
SERVER_IP=$1
TOKEN=$2

echo ">>> ARGS reçus : SERVER_IP='${SERVER_IP}' TOKEN='${TOKEN}'"

# export TOKEN=$(cat K3S_TOKEN)

curl -sfL https://get.k3s.io | sh -s - server \
	--token="${TOKEN}" \
	--node-ip="${SERVER_IP}" \
	--bind-address="${SERVER_IP}" \
	--advertise-address="${SERVER_IP}"

until sudo kubectl get node jcuzinSW >/dev/null 2>&1; do
  sleep 4
done

# sudo kubectl get nodes -o wide

# sudo sudo cat /var/lib/rancher/k3s/server/node-token >> ~/SERVER_TOKEN