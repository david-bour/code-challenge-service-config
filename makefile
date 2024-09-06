cluster:
	minikube start --cpus 4 --memory 8192M --namespace='cluster1' --nodes=3 && \
	minikube addons enable metrics-server

argo:
	helm upgrade --create-namespace -n argocd --install argo-cd ./infra-dependencies/argocd/argo-cd

argo-dev:
	helm template ./deployments/root/ccs-dev | kubectl apply -f -

argo-web:
	echo $$(kubectl get secrets -o yaml argocd-initial-admin-secret | yq '.data.password' | base64 -d) | pbcopy
	kubectl port-forward -n argocd svc/argo-cd-argocd-server 9000:443

grafana:
	kubectl port-forward svc/kube-prometheus-stack-grafana -n kube-prometheus-stack 8000:80

prom:
	kubectl port-forward svc/kube-prometheus-stack-prometheus -n kube-prometheus-stack 9090:9090

inspect:
	minikube dashboard

install-dashboard:
	helm install -n kube-prometheus-stack --create-namespace kube-prometheus-stack ./infra-dependencies/kube-prometheus-stack

clean:
	minikube delete --all=true
