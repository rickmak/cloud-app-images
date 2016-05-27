IMAGE_REGISTRY ?= quay.io/
PROJECT_NAME ?= skygeario
IMAGE_TAG ?= git-$(shell git rev-parse --short HEAD)$(shell git diff -s --exit-code || echo "-dirty")

BASE_IMAGE = cloud-app-base
DEFAULT_IMAGE = cloud-app-default

BASE_IMAGE_NAME = ${IMAGE_REGISTRY}${PROJECT_NAME}/${BASE_IMAGE}
DEFAULT_IMAGE_NAME = ${IMAGE_REGISTRY}${PROJECT_NAME}/${DEFAULT_IMAGE}

docker-build:
	docker build -t ${BASE_IMAGE}:canary .
	docker build -t ${DEFAULT_IMAGE}:canary -f Dockerfile-default .

docker-push:
	docker tag ${BASE_IMAGE}:canary ${BASE_IMAGE_NAME}:${IMAGE_TAG}
	docker push ${BASE_IMAGE_NAME}:${IMAGE_TAG}
	docker tag ${DEFAULT_IMAGE}:canary ${DEFAULT_IMAGE_NAME}:${IMAGE_TAG}
	docker push ${DEFAULT_IMAGE_NAME}:${IMAGE_TAG}

.PHONY: docker-build docker-push
