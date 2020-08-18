-include env_make

ELASTICSEARCH_VER ?= 7.9.0
ELASTICSEARCH_MINOR_VER=$(shell echo "${ELASTICSEARCH_VER}" | grep -oE '^[0-9]+\.[0-9]+')

# Remove minor version from tag
TAG ?= $(ELASTICSEARCH_MINOR_VER)

ifneq ($(STABILITY_TAG),)
    ifneq ($(TAG),latest)
        override TAG := $(TAG)-$(STABILITY_TAG)
    endif
endif

REPO = wodby/elasticsearch
NAME = elasticsearch-$(ELASTICSEARCH_MINOR_VER)

.PHONY: build test push shell run start stop logs clean release

default: build

build:
	docker build -t $(REPO):$(TAG) --build-arg ELASTICSEARCH_VER=$(ELASTICSEARCH_VER) ./

test:
	cd ./tests && IMAGE=$(REPO):$(TAG) NAME=$(NAME) ./run.sh

push:
	docker push $(REPO):$(TAG)

shell:
	docker run --rm --name $(NAME) --cap-add SYS_RESOURCE -i -t $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(TAG) /bin/bash

run:
	docker run --rm --name $(NAME) --cap-add SYS_RESOURCE $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(TAG) $(CMD)

start:
	docker run -d --name $(NAME) --cap-add SYS_RESOURCE $(PORTS) $(VOLUMES) $(ENV) $(REPO):$(TAG)

stop:
	docker stop $(NAME)

logs:
	docker logs $(NAME)

clean:
	-docker rm -f $(NAME)

release: build push
