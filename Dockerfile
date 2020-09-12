FROM golang:1.15.0-buster

ENV PROTOCFILE protoc-3.13.0-linux-x86_64.zip

ENV PROTOC https://github.com/protocolbuffers/protobuf/releases/download/v3.13.0/${PROTOCFILE}

RUN apt-get update

RUN apt-get install -y unzip 

RUN wget ${PROTOC} -O /tmp/${PROTOCFILE}

RUN unzip /tmp/${PROTOCFILE} -d /tmp

RUN cp /tmp/bin/protoc /bin

RUN chmod 0755 /bin/protoc

RUN adduser rprotobuf

RUN go get -d -v google.golang.org/protobuf/cmd/protoc-gen-go

RUN go install -v google.golang.org/protobuf/cmd/protoc-gen-go

WORKDIR /go/src/github.com/ronaldoafonso/rprotobuf

COPY --chown=rprotobuf:rprotobuf *.go .

COPY --chown=rprotobuf:rprotobuf ./taskpb/tasks.proto ./taskpb/

RUN protoc -I=./taskpb --go_out=/go/src ./taskpb/tasks.proto 

RUN go get -d -v ./... && go install -v ./...

USER rprotobuf:rprotobuf

CMD ["rprotobuf"]
