FROM golang:latest

WORKDIR /go

COPY * /go/src/

RUN go get minibank

CMD ["./bin/minibank"]
