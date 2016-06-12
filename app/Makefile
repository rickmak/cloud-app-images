IMAGE_REGISTRY ?= quay.io/
PROJECT_NAME ?= skygeario
SHORT_NAME ?= cloud-app
IMAGE_TAG ?= git-$(shell git rev-parse --short HEAD)$(shell git diff -s --exit-code || echo "-dirty")
DOCKER_BUILD_OPTS ?=

LOCAL_IMAGE_NAME = ${SHORT_NAME}:canary
REGISTRY_IMAGE_NAME = ${IMAGE_REGISTRY}${PROJECT_NAME}/${SHORT_NAME}:${IMAGE_TAG}

docker-build:
	docker build ${DOCKER_BUILD_OPTS} -t ${LOCAL_IMAGE_NAME} .

docker-push:
	docker tag ${LOCAL_IMAGE_NAME} ${REGISTRY_IMAGE_NAME}
	docker push ${REGISTRY_IMAGE_NAME}

docker-test:
	docker-compose up -d --force-recreate db redis
	sleep 10;
	docker-compose up -d --force-recreate server
	sleep 5; curl http://localhost:3000

docker-test-clean:
	docker-compose down

.PHONY: docker-build docker-push
