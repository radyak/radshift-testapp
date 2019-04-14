#!make


IMAGE=radshift-testapp
REPO=radyak

BASE_IMAGE_ARM32=arm32v7/node
BASE_IMAGE_X86=node:8

TAG=latest
TAG_X86=x86-latest


default:
	echo "No default goal defined"


## arm32

build.arm32:
	docker run --rm --privileged multiarch/qemu-user-static:register --reset
	docker build -t $(REPO)/$(IMAGE):$(TAG) --build-arg BASE_IMAGE=$(BASE_IMAGE_ARM32) .

deploy.arm32: build.arm32
	docker tag  $(REPO)/$(IMAGE):$(TAG) $(REPO)/$(IMAGE):$(TAG)
	docker push $(REPO)/$(IMAGE):$(TAG)


## x86

build.x86:
	docker build -t $(REPO)/$(IMAGE):$(TAG_X86) --build-arg BASE_IMAGE=$(BASE_IMAGE_X86) .

deploy.x86: build.x86
	docker tag  $(REPO)/$(IMAGE):$(TAG_X86) $(REPO)/$(IMAGE):$(TAG_X86)
	docker push $(REPO)/$(IMAGE):$(TAG_X86)

run.x86: build.x86
	docker run -p 3000:3000 -e PORT=3000 $(REPO)/$(IMAGE):$(TAG_X86)


## dev

run.dev:
	npm run watch

deploy.all: deploy.arm32 deploy.x86