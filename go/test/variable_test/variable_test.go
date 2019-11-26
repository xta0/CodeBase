package variable

import (
	"fmt"
	"testing"
)

/*
Go 中的变量赋值方式
var a Int = 32
a:= 32 //类型推断
*/
func TestSwap(t *testing.T) {
	a := 10
	b := 11
	a, b = b, a
	fmt.Print(a, b)
}

func TestFib(t *testing.T) {
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
