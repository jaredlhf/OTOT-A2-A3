#install metrics-server
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

#edit TLS, manually add "--kubelet-insecure-tls" to deployment.spec.containers[].args[]
kubectl -nkube-system edit deploy/metrics-server

#restart the deployment
kubectl -nkube-system rollout restart deploy/metrics-server

#apply the backend-hpa.yaml
kubectl apply -f k8s/manifests/k8s/backend-hpa.yaml

#run load test
./test.sh 

#verify HPA scales
kubectl describe hpa

#part2 
#apply zone aware
kubectl apply -f k8s/manifests/k8s/backend-zone-aware.yaml

#verify 
kubectl get po -lapp=backend-zone-aware -owide --sort-by='.spec.nodeName'