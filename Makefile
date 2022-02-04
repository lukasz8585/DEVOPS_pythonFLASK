include version.sh

SHELL := /bin/bash

.SILENT: build publish
all: build publish

AWS_ECR_REPO = YOUR_REPO_ID.dkr.ecr.YOUR_REPO_REGION.amazonaws.com
CODEARTIFACT_TOKEN = `aws codeartifact get-authorization-token --domain YOUR_DOMAIN_NAME --query authorizationToken --output text --region YOUR_REPO_REGION`
IMAGE_NAME = isa-webserver
IMAGE_TAG = ${VER_MAJOR}.${VER_MINOR}.${VER_PATCH}

build:
	echo Building image...
	docker build \
		--build-arg CODEARTIFACT_TOKEN=${CODEARTIFACT_TOKEN} \
		-t ${IMAGE_NAME}:${IMAGE_TAG} .
	echo Tagging image...
	docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${AWS_ECR_REPO}/${IMAGE_NAME}:${IMAGE_TAG}
	docker tag ${IMAGE_NAME}:${IMAGE_TAG} ${AWS_ECR_REPO}/${IMAGE_NAME}\:latest
	echo Build stage finished!

publish:
	echo Publishing image to the ECR...
	aws ecr get-login-password --region YOUR_REPO_REGION | docker login --username AWS --password-stdin ${AWS_ECR_REPO}
	docker push ${AWS_ECR_REPO}/${IMAGE_NAME}:${IMAGE_TAG}
	docker push ${AWS_ECR_REPO}/${IMAGE_NAME}\:latest
	echo Image published!
