cluster:
	minikube start --namespace='cluster1' --nodes=3

argo:
	kubectl create namespace argocd && \
	kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

argo-dev:
	helm template ./deployments/root/ccs-dev | kubectl apply -f -

argo-web:
	echo $$(kubectl get secrets -o yaml argocd-initial-admin-secret | yq '.data.password' | base64 -d) | pbcopy
	kubectl port-forward -n argocd svc/argocd-server 9000:443

clean:
	minikube delete --all=true