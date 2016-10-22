# Mage Makefile for building and pushing a containerized application to Amazon ECR
# By Anderson Brandao (andersonbn.itpro@gmail.com)

REGISTRY = 452158872079.dkr.ecr.us-east-1.amazonaws.com
IMAGE =  mage
BUILD_NUMBER?=0.1.82
MVN_VERSION = 3.3.3-jdk-8

.PHONY: all build release

all: build build_docker

build:	
	docker pull maven:$(MVN_VERSION)
	docker run -i  -v "$(shell pwd):/usr/src/mymaven" -w /usr/src/mymaven maven:$(MVN_VERSION)  mvn clean package -DskipTests=true

build_docker:
	docker build -t $(REGISTRY)/$(IMAGE):$(BUILD_NUMBER) .

release: 
	@if ! docker images $(REGISTRY)/$(IMAGE) | awk '{ print $$2 }' | grep -q -F $(BUILD_NUMBER); then echo "$(REGISTRY)/$(IMAGE) version $(BUILD_NUMBER) is not yet built. Please run 'make build'"; false; fi
	docker push $(REGISTRY)/$(IMAGE):$(BUILD_NUMBER)
clean:
	docker rmi $(REGISTRY)/$(IMAGE):$(VERSION)

