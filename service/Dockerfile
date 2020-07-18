FROM golang:1.13.0-stretch

RUN mkdir -p /go/src/elm-grpc

WORKDIR /go/src/elm-grpc

COPY go.mod .

COPY go.sum .

RUN go mod download

COPY . .

CMD ["go", "run", "."]