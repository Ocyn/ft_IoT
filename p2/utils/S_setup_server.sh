#!/bin/bash
set -e

# Load environment variables from .env file
set -a
source /tmp/.env
set +a

# SERVER_IP=$1
# TOKEN=$(cat /tmp/TOKEN)

# Check if arg are correctly set up
echo ">>> ARGS reçus : SERVER_IP='${SERVER_IP}' TOKEN='${K3S_TOKEN}'"

# [ -f /usr/local/bin/k3s-uninstall.sh ] && /usr/local/bin/k3s-uninstall.sh || true

# Auto install script in server mode
curl -sfL https://get.k3s.io | sh -s - server \
	--token="${K3S_TOKEN}" \
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

# pour que kubectl ne necessite pas sudo
sudo chmod 644 /etc/rancher/k3s/k3s.yaml

# Add master role to server
kubectl label node "${SERVER_NAME}" node-role.kubernetes.io/master=master --overwrite

# Check if Server and Worker node are linked
kubectl get nodes -o wide


# Deploy the applications and the standard Kubernetes ingresses first.
# Traefik is installed by K3s asynchronously, so the custom IngressRoute
# resources must only be applied after its CRD is available.
kubectl apply -f /home/vagrant/apps/app1.yaml
kubectl apply -f /home/vagrant/apps/app2.yaml
kubectl apply -f /home/vagrant/apps/app3.yaml

until kubectl get crd ingressroutes.traefik.io >/dev/null 2>&1; do
  echo "Waiting for the Traefik IngressRoute CRD..."
  sleep 3
done
kubectl wait --for=condition=Established --timeout=300s crd/ingressroutes.traefik.io

until kubectl -n kube-system get deployment traefik >/dev/null 2>&1; do
  echo "Waiting for the Traefik deployment..."
  sleep 3
done
kubectl -n kube-system wait --for=condition=available --timeout=300s deployment/traefik

kubectl apply -f /home/vagrant/apps/ingress.yaml

# Check if the services are created
kubectl -n default get svc

# Wait for the application to be ready
kubectl rollout status deployment/app-one
kubectl rollout status deployment/app-two
kubectl rollout status deployment/app-three

# Check if the pods are running
kubectl get pods -o wide

# # Attendre que le controller d'ingress soit réellement prêt
# kubectl -n kube-system wait --for=condition=available --timeout=300s deployment/traefik

wait_for_url() {
	url=$1
	echo "wait for $url to be joinable"
	while ! curl -sf --connect-timeout 2 "$url" >/dev/null; do
		sleep 1
	done
	echo "OK"
	
}

# Test the application

wait_for_url http://app1.localhost
wait_for_url http://app2.localhost
wait_for_url http://app3.localhost
