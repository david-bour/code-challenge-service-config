cluster:
	minikube start --namespace='cluster1' --nodes=3

argo:
	kubectl create namespace argocd && \
	kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

argo-dev:
	helm template ./deployments/root/ccs-dev | kubectl apply -f -

clean:
	minikube delete --all=true