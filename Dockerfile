FROM golang:1.15-alpine AS build-env

ADD . /src
WORKDIR /src

# `skaffold debug` sets SKAFFOLD_GO_GCFLAGS to disable compiler optimizations
RUN go mod download
RUN go build -o /app

FROM alpine:latest

WORKDIR /
COPY --from=build-env /app /

CMD ["/app"]
