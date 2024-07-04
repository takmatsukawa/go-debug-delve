# ベースイメージとして公式のGoイメージを使用
FROM golang:1.21-alpine

# 作業ディレクトリを設定
WORKDIR /app

# Goモジュールファイルとソースコードをコピー
COPY go.mod ./
COPY go.sum* ./
RUN go mod download

COPY . ./

# ビルドコマンドを実行して実行ファイルを生成
RUN go build -gcflags "all=-N -l" -o my-go-app

RUN go install github.com/go-delve/delve/cmd/dlv@latest

# コンテナ実行時に実行されるコマンドを指定
CMD ["dlv", "--listen=:2345", "--headless=true", "--api-version=2", "--accept-multiclient", "exec", "./my-go-app"]
