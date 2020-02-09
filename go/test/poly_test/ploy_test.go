package poly_test

import (
	"fmt"
	"testing"
)

type Code struct {
	code string
}

type Programmer interface {
	WriteHelloWorld() Code
}

type GoProgrammer struct {
}

func (this *GoProgrammer) WriteHelloWorld() Code {
	return Code{"fmt.Println(\"Hello World from Go\")"}
}

type LuaProgrammer struct {
}

func (this *LuaProgrammer) WriteHelloWorld() Code {
	return Code{"fmt.Println(\"Hello World from Lua\")"}
}

func TestPolymorphism(t *testing.T) {
	test_func := func(p Programmer) {
		fmt.Printf("%s from %T\n", p.WriteHelloWorld().code, p)
	}
	test_func(new(GoProgrammer))
	test_func(new(LuaProgrammer))
}
