#!/bin/bash
set -e
SERVER_IP=$1
TOKEN=$2


# export TOKEN=$(cat K3S_TOKEN)

curl -sfL https://get.k3s.io | sh -s - server \
	--token="${TOKEN}" \
	--node-ip="${SERVER_IP}" \
	--bind-address="${SERVER_IP}" \
	--advertise-address="${SERVER_IP}"

until curl -skf "https://${SERVER_IP}:6443/ping" >/dev/null 2>&1; do
  sleep 2
done

# sudo kubectl get nodes -o wide

# sudo sudo cat /var/lib/rancher/k3s/server/node-token >> ~/SERVER_TOKEN