package test_map

import (
	"fmt"
	"testing"
)

func TestMapInit(t *testing.T) {
	m := map[string]int{"one": 1, "two": 2, "three": 3}
	fmt.Println(m, len(m))
	m1 := map[string]int{}
	m1["one"] = 1
	fmt.Println(m1, len(m1))
	m2 := make(map[string]int, 10 /*Initial Capacity*/)
	fmt.Println(m2, len(m2)) //len = 0
}

// map在访问key不存在时，会返回零，不能通过nil来判断元素是否存在
func TestAccessNotExistingKey(t *testing.T) {
	m1 := map[string]int{}
	fmt.Println(m1["1"]) //0
	m1["1"] = 0
	if value, result := m1["1"]; result { //result表示key是否存在
		fmt.Printf("key:1, value:%d", value)
	} else {
		fmt.Println("key:1 not exists")
	}
}

func TestMapTraversal(t *testing.T) {
	m := map[string]int{"one": 1, "two": 2, "three": 3}
	for k, v := range m {
		fmt.Println(k, v)
	}
}

func TestMapWithFunctionValue(t *testing.T) {
	m := map[string]func(op int) int{}
	m["square"] = func(op int) int { return op * op }
	x := m["square"](10)
	fmt.Println(x)
}

//Go 中没有Set，可以用map[type]bool来模拟
func TestMapForSet(t *testing.T) {
	mySet := map[int]bool{}
	mySet[1] = true
	//check
	if mySet[1] {
		fmt.Println("key exists")
	}
	//delete
	delete(mySet, 1)
	//check
	if mySet[1] {
		fmt.Println("key exists")
	} else {
		fmt.Println("key doesn't exists")
	}
}
