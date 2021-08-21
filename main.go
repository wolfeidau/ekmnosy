package main

import (
	"fmt"
	"os"
	"os/user"

	"github.com/wolfeidau/ekmnosy/internal/repl"
)

var (
	version string
)

func main() {
	user, err := user.Current()
	if err != nil {
		panic(err)
	}
	fmt.Printf("Hello %s! This is the Monkey programming language version: %s!\n",
		user.Username, version)
	fmt.Printf("Feel free to type in commands\n")
	repl.Start(os.Stdin, os.Stdout)
}
