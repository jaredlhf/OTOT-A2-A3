#Create Cluster
kind create cluster --name kind-1 --config k8s/kind/cluster-config.yaml
kubectl cluster-info
kubectl get nodes

#Create Deployment
kubectl apply -f ./k8s/manifests/k8s/backend-deployment.yaml
kubectl get deploy/backend --watch
kubectl get po -lapp=backend --watch

#Create Service
kubectl apply -f ./k8s/manifests/k8s/backend-service.yaml
kubectl get svc 

#Create Ingress Controller
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
kubectl -n ingress-nginx get deploy --watch

#Create Ingress
kubectl apply -f k8s/manifests/k8s/backend-ingress.yaml
kubectl get ingress --watch
kubectl describe ingress 


kubectl port-forward service/backend 8080:8080