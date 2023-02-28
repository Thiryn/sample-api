
IMAGE_NAME="thiryn/sample-api"
VERSION="0.0.1"

IMAGE="$(IMAGE_NAME):$(VERSION)"

.PHONY: test
test:
	go test ./...

.PHONY: docker-build
docker-build: test
	docker build -f Dockerfile -t $(IMAGE) .

.PHONY: docker-push
docker-push: docker-build
	docker push $(IMAGE)

.PHONY: minikube-start
minikube-start:
	minikube start -p sample-api --memory=2048 --driver=docker --kubernetes-version=v1.22.4 --cni calico
	minikube addons enable metallb -p sample-api
	$(CURDIR)/scripts/udpate-metallb-config.sh

.PHONY: minikube-context
minikube-context:
	minikube update-context -p sample-api

.PHONY: deploy
deploy:
	helm upgrade --create-namespace 	\
		--install 						\
		--dependency-update 			\
		-n team-demo 					\
		sample-api ./deployment/sample-api

.PHONY: minikube-deploy
minikube-deploy: minikube-context deploy

.PHONY: do-install-otomi
install-otomi:
	helm repo add otomi https://otomi.io/otomi-core
	helm repo update
	helm install otomi otomi/otomi \
	--set cluster.k8sVersion="1.23" \
	--set cluster.name=interview \
	--set cluster.provider=digitalocean \
	--set apps.host-mods.enabled=false
