package condition_test

import (
	"fmt"
	"runtime"
	"testing"
)

//Go中的if判断条件支持赋值
func TestIf(t *testing.T) {
	if a := 10; a == 10 {
		fmt.Println("a=10")
	} else {
		fmt.Println("a!=10")
	}
}

// Switch
//1. 条件表达式不限制为常亮或整数
//2. 没有fall through
//3. 单个case有多个选项，用逗号分隔
//4. 可以不设定switch之后的表达式，这时switch和 if...else...的逻辑相同

func TestSwitch(t *testing.T) {
	switch os := runtime.GOOS; os {
	case "darwin":
		fmt.Println("OSX")
	case "linux":
		fmt.Println("Linux")
	default:
		fmt.Printf("%s", os)
	}
}

func TestSwitch2(t *testing.T) {
	Num := 5
	switch {
	case 0 <= Num && Num <= 3:
		fmt.Println("0-3")
	case 4 <= Num && Num <= 6:
		fmt.Println("4-6")
	case 7 <= Num && Num <= 9:
		fmt.Println("7-9")
	default:
		fmt.Println("out or range")
	}
}

func TestSwitch3(t *testing.T) {
	for i := 0; i < 5; i++ {
		switch i {
		case 1, 2:
			fmt.Println("1,2")
		}
	}
}
