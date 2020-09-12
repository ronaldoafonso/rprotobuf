package main

import (
	"github.com/ronaldoafonso/rprotobuf/taskpb"
	"google.golang.org/protobuf/proto"
	"log"
)

var task = taskpb.Task{
	Id:   1,
	Name: "Study Protocol Buffer",
	Done: false,
	Actions: []string{
		"Read Ronaldo Afonso's blog.",
		"Create some protobuf application.",
	},
}

func showTask(t *taskpb.Task) {
	log.Printf("Id: %v.", t.GetId())
	log.Printf("Name: %v.", t.GetName())
	log.Printf("Done: %v.", t.GetDone())
	log.Printf("Actions: %v.", t.GetActions())
}

func main() {
	showTask(&task)

	btask, errm := proto.Marshal(&task)
	if errm != nil {
		log.Fatalf("Error Marshalling task: %v.", errm)
	}
	log.Printf("Task marshalled: %v.", btask)

	utask := taskpb.Task{}
	erru := proto.Unmarshal(btask, &utask)
	if erru != nil {
		log.Fatalf("Error Unmarshalling task: %v.", erru)
	}
	showTask(&utask)
}
