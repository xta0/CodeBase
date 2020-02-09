package error_handling_test

import (
	"errors"
	"fmt"
	"testing"
)

//Go 没有try catch
//errors类实现了error接口
//可以通过errors.New快速创建错误对象

var error1 = errors.New("err msg")
var error2 = errors.New("err msg")

func bar(x int) (int, error) {
	if x < 0 {
		return 200, error1
	}
	if x > 100 {
		return 200, error2
	}
	return 100, nil
}

// TestBar tests bar function
func TestBar(t *testing.T) {
	if v, err := bar(-10); err != nil {
		t.Error(err)
	} else {
		t.Log(v)
	}
}

// panic 用于不可以恢复的错误
// panic 退出前会执行 defer 指定的内容
// os.Exit退出不会调用defer
// os.Exit退出不会输出当前调用栈的信息

//TestPanicVxExit xxx
func TestPanicVxExit(t *testing.T) {
	defer func() {
		if err := recover(); err != nil {
			fmt.Println("recoverf from", err)
		}
	}()
	fmt.Println("start")
	// os.Exit(-1)
	panic(errors.New("panic!"))
}
