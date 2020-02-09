package type_test

import (
	"fmt"
	"testing"
)

/*
- bool
- string
- int int8 int16 int32 int64
- uint uint8 uint16 uint32 uint64 uintptr
- byte //alias for uint8
- rune // alias for int32, represents a unicode code point
- float32 float64
- complex64 complex128
*/
type MyInt int64

func TestImplicit(t *testing.T) {
	var a int32 = 1
	var b int64
	b = int64(a)
	var c MyInt
	c = MyInt(b)
	fmt.Print(a, b, c)
}

func TestPointer(t *testing.T) {
	a := 1
	aPtr := &a
	fmt.Printf("a's pointer: %p\n", aPtr)
	fmt.Printf("a's type: %T, a's pointer type: %T\n", a, aPtr)
}

func TestString(t *testing.T) {
	var s string
	fmt.Printf("*%s*", s)
	fmt.Print(len(s))
}

/*
自定义类型
*/
//typedef
type DISCOUNT_FUNC func(price float32) float32
type Book struct {
	name     string
	price    float32
	discount DISCOUNT_FUNC
}

func TestCustomType(t *testing.T) {
	book := new(Book)
	book.name = "Go Programming"
	book.price = 29.3
	book.discount = func(price float32) float32 {
		return price * 0.8
	}
	fmt.Printf("price: %f", book.discount(book.price))
}
