SHELL := bash

VERSION := 0.0.1

DOCKER_BASE_IMAGE_FQIN := docker.io/library/perl:5.38

# DOCKER_REG_DOMAIN := ghcr.io
DOCKER_REG_DOMAIN := docker.io

# DOCKER_REG_USER := lingy-lang
DOCKER_REG_USER := ingy

DOCKER_IMAGE_NAME := gha-perl-test-runner

# DOCKER_IMAGE_VERSION := $(VERSION)
DOCKER_IMAGE_VERSION := latest

DOCKER_IMAGE_FQIN := \
   $(DOCKER_REG_DOMAIN)/$(DOCKER_REG_USER)/$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_VERSION)

DOCKER_BASH_HISTORY := /tmp/lingy-gha-perl-test-runner-bash-history


#------------------------------------------------------------------------------
build:
	docker build \
	    --tag $(DOCKER_IMAGE_FQIN) \
	    --build-arg DOCKER_BASE_IMAGE_FQIN=$(DOCKER_BASE_IMAGE_FQIN) \
	    .

shell: build
	touch $(DOCKER_BASH_HISTORY)
	docker run --rm -it \
	    -v $(DOCKER_BASH_HISTORY):/root/.bash_history \
	    $(DOCKER_IMAGE_FQIN) \
	    bash

push: build
	docker push $(DOCKER_IMAGE_FQIN)
