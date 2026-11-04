# ft_IoT
42 School Inception-of-Things project about k3s and apps deployment setup

# Introdution

In this project, **Inception-Of-Things** consist to learn some DevOps skills by installing and configuring VM with *Vagrant* and auto managed service by *k3s*.


## Project structure

```
p1/
├── .vagrant/
├── utils/
│   ├── .env.example
│   ├── global_setup.sh
│   ├── S_setup_server.sh
│   └── SW_setup_agent.sh
└── Vagrantfile
p2/
├── utils/
│   ├── apps/
│   │   ├── app1.yaml
│   │   ├── app2.yaml
│   │   ├── app3.yaml
│   │   └── template.yml
│   ├── global_setup.sh
│   ├── S_setup_server.sh
│   └── server-config.yaml
└── Vagrantfile
p3/
├── utils/
│   ├── apps/
│   │   ├── app1.yaml
│   │   ├── app2.yaml
│   │   ├── app3.yaml
│   │   └── template.yml
│   ├── global_setup.sh
│   ├── S_setup_server.sh
│   └── server-config.yaml
└── Vagrantfile

.gitignore
README.md
```


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