#!/bin/sh

protoc -I=./taskpb --go_out=/go/src ./taskpb/tasks.proto 
