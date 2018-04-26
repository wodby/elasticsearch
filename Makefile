-include env_make

ES_VER ?= 6.2.4

# Remove minor version from tag
TAG ?= $(shell echo "${ES_VER}" | grep -oE '^[0-9]+\.[0-9]+?')

ifneq ($(STABILITY_TAG),)
    ifneq ($(TAG),latest)
        override TAG := $(TAG)-$(STABILITY_TAG)
    endif
endif

REPO = wodby/elasticsearch
NAME = elasticsearch-$(ES_VER)

.PHONY: build test push shell run start stop logs clean release

default: build

build:
	docker build -t $(REPO):$(TAG) --build-arg ES_VER=$(ES_VER) ./

test:
	IMAGE=$(REPO):$(TAG) NAME=$(NAME) ./test.sh

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
