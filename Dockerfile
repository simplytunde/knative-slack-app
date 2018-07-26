FROM golang:1.10.1
WORKDIR /go/src/github.com/kairen/knative-slack-app/
COPY . .
RUN go get -u github.com/golang/dep/cmd/dep && \
 dep ensure && \
 CGO_ENABLED=0 GOOS=linux go build -v -o app && \
 mv app /tmp/app

FROM alpine
COPY --from=0 /tmp/app /bin/app
ENTRYPOINT ["app"]