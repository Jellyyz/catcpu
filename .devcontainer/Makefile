#  Makefile for managing Docker container for CPU project development in Windows

IMAGE_NAME = catcpu
CONTAINER_WORK_DIR = /workspaces/cpu-project

ifeq ($(OS),Windows_NT)
    CURRENT_DIR = $(subst \,/,$(CURDIR)/..)
else
    CURRENT_DIR = $(CURDIR)/..
endif

.DEFAULT_GOAL := all
.PHONY: build run shell clean help all

all: clean build

build:
	docker build -t $(IMAGE_NAME) .

run:
	docker run -it --rm -w $(CONTAINER_WORK_DIR) -v "$(CURRENT_DIR):$(CONTAINER_WORK_DIR)" $(IMAGE_NAME)

shell:
	docker run -it --rm -w $(CONTAINER_WORK_DIR) -v "$(CURRENT_DIR):$(CONTAINER_WORK_DIR)" -e DISPLAY=host.docker.internal:0 $(IMAGE_NAME) /bin/bash

clean:
	-docker rmi -f $(IMAGE_NAME)

# 5. Help menu
help:
	@echo "Usage:"
	@echo "  make build  - Build the Docker image"
	@echo "  make run    - Run 'make' inside the container"
	@echo "  make shell  - Jump into the container terminal"
	@echo "  make clean  - Delete the Docker image"