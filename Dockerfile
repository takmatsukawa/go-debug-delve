FROM golang:1.21-alpine

WORKDIR /app

COPY go.mod ./
COPY go.sum* ./
RUN go mod download

COPY . ./

RUN go build -gcflags "all=-N -l" -o my-go-app

RUN go install github.com/go-delve/delve/cmd/dlv@latest

EXPOSE 8080 2345

CMD ["dlv", "--continue", "--listen=:2345", "--headless=true", "--api-version=2", "--accept-multiclient", "exec", "./my-go-app"]
