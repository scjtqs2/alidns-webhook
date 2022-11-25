FROM golang:1.17-alpine AS build

ADD . /workspace

WORKDIR /workspace
ENV GO111MODULE=on
ENV GOPROXY=http://goproxy.cn

RUN go mod tidy -compat=1.17


RUN CGO_ENABLED=0 go build -o webhook -ldflags '-s -w -extldflags "-static"' .

FROM alpine:3.15

RUN apk add --no-cache ca-certificates

COPY --from=build /workspace/webhook /usr/local/bin/webhook

ENTRYPOINT ["/usr/local/bin/webhook"]
