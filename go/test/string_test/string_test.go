package string_test

import (
	"fmt"
	"strconv"
	"strings"
	"testing"
)

//string in Go is also immutable
//string is a immutable slice
func TestStringEncoding(t *testing.T) {
	var s string
	s = "hello"
	fmt.Println(len(s))

	//汉字 ”鱼“
	s = "\xE2\xBB\xA5"
	fmt.Println(s)
	fmt.Println(len(s)) //3, 上述字符串有3个byte，因此长度是3
	//因此，len的结果是byte数，而非字符数

	//Unicode是一种字符集
	//UTF8是unicode的存储实现
	s = "中"
	fmt.Println(len(s))                  //3
	c := []rune(s)                       //rune类型表示unicode. 因此c是一个存放unicode的数组
	fmt.Println(len(c))                  //1，c中只有一个rune对象
	fmt.Printf("中 - unicode %x\n", c[0]) //中的unicode值为0x4e2d
	fmt.Printf("中 - UTF8 %x\n", s)       //中对应的UTF8的存储格式为0xe4b8ad

}

func TestStringFn(t *testing.T) {
	s := "A,B,C"
	arr := strings.Split(s, ",")
	fmt.Println(arr) //[A,B,C]
	str := strings.Join(arr, "-")
	fmt.Println(str) //[A,B,C]
}

func TestStringConv(t *testing.T) {
	//int to string
	s := strconv.Itoa(10)
	fmt.Println(s)

	//string to Int
	x, err := strconv.Atoi("10")
	if err == nil {
		fmt.Println(x)
	}

}
