package loop_test

import (
	"fmt"
	"testing"
)

func TestLoop(t *testing.T) {
	n := 0
	for n < 5 {
		fmt.Println(n)
		n++
	}
}

func TestInfinateLoop(t *testing.T) {
	n := 0
	for {
		if n == 5 {
			break
		}
		n++
	}
	fmt.Println(n)
}
