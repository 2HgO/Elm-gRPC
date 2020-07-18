package main

import (
	"context"
	"log"
	"net"

	pb "elm-grpc/hello"

	"google.golang.org/grpc"
)

const port = ":55056"

type server struct{}

func (s *server) SayHello(ctx context.Context, in *pb.HelloRequest) (*pb.HelloReply, error) {
	return &pb.HelloReply{Message: "Hello " + in.Name + "! from golang."}, nil
}

func main() {
	lis, err := net.Listen("tcp", port)
	if err != nil {
		log.Panicf("failed to listen: %v", err)
	}
	s := grpc.NewServer()
	pb.RegisterHelloServer(s, &server{})
	log.Println("Starting up hello service ...")
	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
}
