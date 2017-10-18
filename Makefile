VERSION ?= $(shell git describe --tags --always --dirty --match=v* 2> /dev/null || cat $(CURDIR)/.version 2> /dev/null || echo v0)
BASE = $(CURDIR)

.PHONY: all
all: version cheatd

.PHONY: cheatd
cheatd:| $(BASE)
	@cd $@; \
	go build -v -o $(BASE)/bin/$@

$(BASE):
	@mkdir -p $(dir $@)

.PHONY: test
test:
	@echo "test"

# Docker builds

.PHONY: cheatdd __cheatdd
cheatdd: __cheatdd prune

__cheatdd:
	@cd cheatd; \
	docker build --rm -t registry.gitlab.com/idrilsilverfoot/lisbeth-infra/cheatd .

# Docker run containers

.PHONY: on __on off __off
on: __on prune
off: __off prune

__on:
	@docker-compose up -d --build

__off:
	@docker-compose down

# Misc

.PHONY: prune clean version list
prune:
	@docker system prune -f

clean:
	@rm -rfv bin

version:
	@echo "Version: $(VERSION)"

# From https://stackoverflow.com/questions/4219255/how-do-you-get-the-list-of-targets-in-a-makefile
list:
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$' | xargs
