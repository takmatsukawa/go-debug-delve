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
RUN go build -o my-go-app

# コンテナ実行時に実行されるコマンドを指定
CMD ["./my-go-app"]
