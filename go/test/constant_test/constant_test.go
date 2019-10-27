package constant_test

import "testing"

const (
	Monday = iota + 1
	Tuesday
	Wednesday
)

const (
	Readable   = 1 << iota //0001
	Writable               //0010
	Executable             //0100
)

func TestConstantTry(t *testing.T) {
	t.Log(Monday, Tuesday)
}

func TestContantTryBitOperation(t *testing.T) {
	a := 7 //0111
	t.Log(a&Readable == Readable)
	t.Log(a&Writable == Writable)
	t.Log(a&Executable == Executable)
}
