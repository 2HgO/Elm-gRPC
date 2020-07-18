.PHONY: envoy-pb
envoy-pb:
	PATH=${PATH}:${HOME}/go/src/googleapis protoc -I=${HOME}/go/src/googleapis -I=proto --include_imports --descriptor_set_out=./proxy/hello.pb proto/hello.proto

.PHONY: go-pb
go-pb:
	PATH=${PATH}:${HOME}/go/bin protoc -I=${HOME}/go/src/googleapis -I=./proto --go_out=plugins=grpc:./service/hello ./proto/hello.proto