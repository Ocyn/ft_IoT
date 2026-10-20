#!/bin/bash
set -e
SERVER_IP=$1
TOKEN=$2

# Check if arg are correctly set up
echo ">>> ARGS reçus : SERVER_IP='${SERVER_IP}' TOKEN='${TOKEN}'"

# [ -f /usr/local/bin/k3s-uninstall.sh ] && /usr/local/bin/k3s-uninstall.sh || true

# Auto install script in server mode
curl -sfL https://get.k3s.io | sh -s - server \
	--token="${TOKEN}" \
	--node-ip="${SERVER_IP}" \
	--bind-address="${SERVER_IP}" \
	--advertise-address="${SERVER_IP}" 

SERVER_NAME=$(hostname -s | tr '[:upper:]' '[:lower:]')

# Wait for the server to be up
until sudo kubectl get node "${SERVER_NAME}" >/dev/null 2>&1; do
  sleep 2
done

# Check k3s running status
sudo systemctl status k3s --no-pager

# Pour que kubectl ne necessite pas sudo
sudo chmod 644 /etc/rancher/k3s/k3s.yaml

# Add master role to server
kubectl label node "${SERVER_NAME}" node-role.kubernetes.io/master=master --overwrite

# Check if Server and Worker node are linked
kubectl get nodes -o wide

# Deploy the application
kubectl apply -f /home/vagrant/apps/app1.yaml
kubectl rollout status deployment/web
kubectl get pods -o wide

# Test the application
curl http://app1.localhost
