# https://github.com/argoproj/argo-helm/tree/main
chart:
	helm pull argo/argo-cd && \
	ls *.tgz | xargs -n1 tar -xvf && \
	rm *.tgz

list:
	helm search repo argo

install:
	helm upgrade --create-namespace --install argo-cd ./argo-cd