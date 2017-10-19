NAME := kineticskunk
VERSION := $(or $(VERSION),$(VERSION), latest)
NAMESPACE := $(or $(NAMESPACE),$(NAMESPACE),$(NAME))
AUTHORS := $(or $(AUTHORS),$(AUTHORS),KineticSkunk)
BUILD_ARGS := $(BUILD_ARGS)
MAJOR := $(word 1,$(subst ., ,$(VERSION)))
MINOR := $(word 2,$(subst ., ,$(VERSION)))
MAJOR_MINOR_PATCH := $(word 1,$(subst -, ,$(VERSION)))

all: base jenkinsci jenkinsci-zato-api-testing

generate_all:	\
	generate_jenkinsci \
	generate_jenkins_slave \
	generate_jenkinsci-zato-api-testing 

build: all

ci: build

base:
	cd ./Base && docker build $(BUILD_ARGS) -t $(NAME)/base:$(VERSION) .

generate_jenkins_slave:
	cd ./JenkinsSlave && ./generate.sh $(VERSION) $(NAMESPACE) $(AUTHORS)

jenkinsci: base generate_jenkins_slave
	cd ./JenkinsSlave && docker build $(BUILD_ARGS) -t $(NAME)/jenkinsci:$(VERSION) .

generate_jenkins_slave_zato_api_testing:
	cd ./JenkinsSlaveZato && pwd && ./generate.sh $(VERSION) $(NAMESPACE) $(AUTHORS)

jenkinsci-zato-api-testing: jenkinsci generate_jenkins_slave_zato_api_testing
	cd ./JenkinsSlaveZato && docker build $(BUILD_ARGS) -t $(NAME)/jenkinsci-zato-api-testing:$(VERSION) .

tag_latest:
	docker tag $(NAME)/base:$(VERSION) $(NAME)/base:latest
	docker tag $(NAME)/jenkinsci:$(VERSION) $(NAME)/jenkinsci:latest
	docker tag $(NAME)/jenkinsci-zato-api-testing:$(VERSION) $(NAME)/jenkinsci-zato-api-testing:latest

release_latest:
	docker push $(NAME)/base:latest
	docker push $(NAME)/jenkinsci:latest
	docker push $(NAME)/jenkinsci-zato-api-testing:latest

tag_major_minor:
	docker tag $(NAME)/base:$(VERSION) $(NAME)/base:$(MAJOR)
	docker tag $(NAME)/jenkinsci:$(VERSION) $(NAME)/jenkinsci:$(MAJOR)
	docker tag $(NAME)/jenkinsci-zato-api-testing:$(VERSION) $(NAME)/jenkinsci-zato-api-testing:$(MAJOR)

release: tag_major_minor
	@if ! docker images $(NAME)/base | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME)/base version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)/jenkinsci | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME)/jenkinsci version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	@if ! docker images $(NAME)/jenkinsci-zato-api-testing | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME)/jenkinsci-zato-api-testing version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	docker push $(NAME)/base:$(VERSION)
	docker push $(NAME)/jenkinsci:$(VERSION)
	docker push $(NAME)/jenkinsci-zato-api-testing:$(VERSION)
	docker push $(NAME)/base:$(MAJOR)
	docker push $(NAME)/jenkinsci:$(MAJOR)
	docker push $(NAME)/jenkinsci-zato-api-testing:$(MAJOR)
	docker push $(NAME)/base:$(MAJOR).$(MINOR)
	docker push $(NAME)/jenkinsci:$(MAJOR).$(MINOR)
	docker push $(NAME)/jenkinsci-zato-api-testing:$(MAJOR).$(MINOR)
	docker push $(NAME)/base:$(MAJOR_MINOR_PATCH)
	docker push $(NAME)/jenkinsci:$(MAJOR_MINOR_PATCH)
	docker push $(NAME)/jenkinsci-zato-api-testing:$(MAJOR_MINOR_PATCH)

.PHONY: \
	all \
	base \
	jenkinsci \
	jenkinsci-zato-api-testing \
	test