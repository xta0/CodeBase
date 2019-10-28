package func_test

import (
	"fmt"
	"math/rand"
	"testing"
	"time"
)

//1, 函数可有多个返回值
//2. 所有参数都是值传递，slice,map,channel是指针传递
//3. 函数是First-Class

func returnMultiValues() (int, int) {
	return rand.Intn(10), rand.Intn(20)
}

func benchmark(inner func(op int) int) func(op int) int {
	return func(n int) int {
		start := time.Now()
		ret := inner(n)
		fmt.Println("time spent: ", time.Since(start).Seconds())
		return ret
	}
}

func slowFunc(op int) int {
	time.Sleep(time.Second * 1)
	return op
}

func TestFunc(t *testing.T) {
	a, b := returnMultiValues()
	fmt.Println(a, b)
}

func TestSlowFunc(t *testing.T) {
	time := benchmark(slowFunc)(10)
	fmt.Println(time)
}

//可变参数
//可变参数ops是数组类型
func sum(ops ...int) int {
	s := 0
	for _, op := range ops {
		s += op
	}
	return s
}
