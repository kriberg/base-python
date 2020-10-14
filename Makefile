BUILD_URL ?= $(shell pwd)
BUILD_DATE ?= $(shell date --rfc-3339=ns)
GIT_URL := $(shell git config --get remote.origin.url)
GIT_COMMIT := $(shell git rev-parse HEAD)
VERSION := $(shell head -n1 Dockerfile|cut -d":" -f2|cut -d"-" -f1)

all: latest


latest:
	@echo "Building $(VERSION)"
	docker build . \
		-t evryfs/base-python:$(VERSION) \
		-t evryfs/base-python:3 \
		-t quay.io/evryfs/base-python:3 \
		-t quay.io/evryfs/base-python:$(VERSION) \
		--build-arg PYTHON_VERSION="$(VERSION)" \
		--build-arg BUILD_DATE="$(BUILD_DATE)" \
		--build-arg BUILD_URL="$(BUILD_URL)" \
		--build-arg GIT_URL="$(GIT_URL)" \
		--build-arg GIT_COMMIT="$(GIT_COMMIT)"

push:
	docker push quay.io/evryfs/base-python:3
	docker push quay.io/evryfs/base-python:$(VERSION)
	docker push quay.io/evryfs/base-python:latest

