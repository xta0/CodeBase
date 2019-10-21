package fib

import (
	"fmt"
	"testing"
)

/*
Go 中的变量赋值方式
var a

*/
func TestSwap(t *testing.T) {

}

func TestFibList(t *testing.T) {
	a := 1
	b := 1
	fmt.Print(" ", a)
	fmt.Print(" ", b)
	for i := 0; i < 5; i++ {
		tmp := a + b
		fmt.Print(" ", tmp)
		a = b
		b = tmp
	}
}
