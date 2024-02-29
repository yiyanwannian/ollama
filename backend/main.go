package main

import "github.com/jmorganca/ollama/cmd"

func main() {
	if err := cmd.RunServer(nil, nil); err != nil {
		panic(err)
	}
}
