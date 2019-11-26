package struct_test

import (
	"fmt"
	"testing"
)

//
type Employee struct {
	Id   string
	Name string
	Age  int
}

//define methods
//e will be copied
func (e Employee) String1() string {
	return fmt.Sprintf("ID:%s-Name:%s-Age:%d", e.Id, e.Name, e.Age)
}

//e is a pointer
func (e *Employee) String2() string {
	return fmt.Sprintf("ID:%s-Name:%s-Age:%d", e.Id, e.Name, e.Age)
}
func TestStructInit(t *testing.T) {
	e := Employee{"1", "Tao", 33} // {1 Tao 33}
	fmt.Println(e)                // { Tao 33}
	e1 := Employee{Name: "Tao", Age: 33}
	fmt.Println(e1)
	e2 := new(Employee) //e2 is a pointer
	e2.Id = "2"
	e2.Name = "Xu"
	e2.Age = 33
	fmt.Println(e2) //&{2 Xu 33}
	e3 := &e        //e3 is also a pointer
	fmt.Println(e3) //&{1 Tao 33}
}

func TestStructMethods(t *testing.T) {
	e := Employee{"1", "Tao", 33} // {1 Tao 33}
	fmt.Println(e.String1())
	fmt.Println(e.String2())
}
