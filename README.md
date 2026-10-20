# ft_IoT
42 School Inception-of-Things project about k3s and apps deployment setup

# Useful commands
```
kubectl get node -o wide
```
```
kubectl get all -n kube-system
```
```
 kubectl delete deployment web && kubectl delete svc web && kubectl apply -f app1.yaml && kubectl rollout status deployment/web
 ```