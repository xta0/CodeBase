package interface_test

import (
	"fmt"
	"testing"
)

type Code struct {
	code string
}

/*
1. Go中的interface不需要关键字来声明，只要某个struct实现了接口中的method即
可
2. 接口的定义可以和实现接口的对象放在一个package
*/
type Programmer interface {
	WriteHelloWorld() Code
}

type GoProgrammer struct {
}

func (p *GoProgrammer) WriteHelloWorld() Code {
	return Code{"fmt.Println(\"Hello World\")"}
}

func TestInterface(t *testing.T) {
	var p Programmer
	p = new(GoProgrammer)
	code := p.WriteHelloWorld().code
	fmt.Println(code)
}

/*
接口变量
*/
func TestInterfaceVar(t *testing.T) {
	var p Programmer = &GoProgrammer{}
	code := p.WriteHelloWorld().code
	fmt.Println(code)
}

/*
空接口
//interface{} 相当于void*
*/
func DoSomething(p interface{}) {
	//如果传入的p可被转化成int
	if i, ok := p.(int); ok {
		fmt.Println(p, i)

	} else if i, ok := p.(string); ok {
		fmt.Println(p, i)
	} else {
		fmt.Println("unknow type")
	}
}

func DoSomething2(p interface{}) {
	switch v := p.(type) {
	case int:
		fmt.Println("int", v)
	case string:
		fmt.Println("string", v)
	default:
		fmt.Println("unknown type")
	}
}

func TestDoSomething(t *testing.T) {
	DoSomething(19)
	DoSomething("20")
	DoSomething(19.1)

	DoSomething2(19)
	DoSomething2("20")
	DoSomething2(19.1)
}

/*
接口的粒度越小越好
*/
type Reader interface {
	Read(p []byte) (n int, err error)
}
type Writer interface {
	Write(p []byte) (n int, err error)
}
type ReadWriter interface {
	Reader
	Writer
}
