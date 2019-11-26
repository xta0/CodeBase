package operator_test

import (
	"fmt"
	"testing"
)

//Go 语言中，长度相同，类型相同的数组可以直接比较内容
func TestCompArray(t *testing.T) {
	a := [...]int{1, 2, 3, 4}
	b := [...]int{1, 3, 4, 5}
	c := [...]int{1, 2, 3, 4}
	fmt.Print(a == b)
	fmt.Print(a == c)
}

//&^按位置零
//如果rhs为1，那么结果为0
//如果rhs为0，那么结果为lhs
/*
1&^0 = 1
1&^1 = 0
0&^1 = 0
0&^0 = 0
*/

const (
	Readable   = 1 << iota //0001
	Writable               //0010
	Executable             //0100
)

func TestContantTryBitOperation(t *testing.T) {
	a := 7             //0111
	r := a &^ Readable //0111 &^ 0001 = 0110, 每一位进行运算 0110
	fmt.Printf("r: %b", r)
	w := a &^ Writable //0101
	fmt.Printf("w: %b", w)
	e := a &^ Executable //011
	fmt.Printf("e: %b", e)
}
