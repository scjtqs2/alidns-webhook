IMAGE_NAME := scjtqs/alidns-webhook
IMAGE_TAG := $(shell cat VERSION)

test:
	go test -v .

docker:
	docker buildx create --use --name myalidns
	docker buildx build --no-cache --tag $(IMAGE_NAME):$(IMAGE_TAG)  --platform linux/amd64,linux/arm64 .
	docker buildx rm myalidns

release:
	docker buildx build --no-cache --tag $(IMAGE_NAME):$(IMAGE_TAG)   --platform linux/amd64,linux/arm64 --push .
