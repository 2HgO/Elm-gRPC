# Elm-gRPC
In a bid to replace all the direct javascript and html code in [gRPC-streaming](https://github.com/2HgO/grpc-streaming), I'm trying out using elm with gRPC. Implementing Remote Procedure Calls (RPC) in elm seems like an Herculian task at the moment and I am yet to find an implementation (only encoders and decoders of models to and from protobuf messages). With that in mind, I've decided to use gRPC-json with an envoy proxy.

## Overview
This project is just a proof of concept showing how elm can be used with grpc. All it does is make a request to the hello service (implemented in Go) on each key input in the text field and displays the response message from the service.

## Requirements
- Docker
- docker-compose

## Installation
To run this application, just pull the source from this repo and run the following command
```bash
docker-compose up --build
```

The app should be running at [elm-gprc](http://localhost:55099/src/Main.elm). If it displays an error, go [here](http://localhost:55099) and follow the path from there.
