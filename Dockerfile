FROM golang:1.16-alpine AS builder
WORKDIR /app
COPY go.mod ./
COPY go.sum ./

RUN go mod download

COPY *.go ./


RUN go build -o server

FROM txn2/n2pdf
WORKDIR /
COPY --from=builder /app/server /server
ENTRYPOINT ["/server"]
