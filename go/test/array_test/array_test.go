package array_test

import (
	"fmt"
	"testing"
)

//静态数组
//var a [3]int
//a[0]=1
//声明+初始化 b := [3]int{1,2,3}
//声明+初始化 b := [...]int{1,2,3,4,5}
//多维数组 c:= [2][2]int{{1,2},{3,4}}
func TestArray(t *testing.T) {
	var arr [3]int
	fmt.Println(arr[1]) //0
	arr1 := [3]int{1, 2, 3}
	fmt.Println(arr1[1])
	arr2 := [...]int{3, 4}
	fmt.Println(arr2[1])
}

//Array Traversal
func TestArrayLoop(t *testing.T) {
	arr3 := [...]int{1, 3, 4, 5}
	//old style
	for i := 0; i < len(arr3); i++ {
		fmt.Println(arr3[i])
	}
	//range
	for idx, ele := range arr3 {
		fmt.Println(idx, ele)
	}
	for _, ele := range arr3 {
		fmt.Println(ele)
	}
}

//Subarray
func TestSubArray(t *testing.T) {
	a := [...]int{1, 2, 3, 4, 5}
	x1 := a[1:2] //[2]
	fmt.Println(x1)
	x2 := a[1:3] //[2,3]
	fmt.Println(x2)
	x3 := a[1:len(a)] //[2,3,4,5]
	fmt.Println(x3)
	x4 := a[1:] //[2,3,4,5]
	fmt.Println(x4)
	x5 := a[:3] //[1,2,3]
	fmt.Println(x5)
}

//动态数组，Slice
func TestSliceInit(t *testing.T) {
	var s0 []int                  //slice 是可变长的数组
	fmt.Println(len(s0), cap(s0)) //length 和 capacity的概念类似于C++的vector
	s0 = append(s0, 1)
	fmt.Println(len(s0), cap(s0))

	s1 := []int{1, 2, 3, 4}
	fmt.Println(len(s1), cap(s1))

	s2 := make([]int, 3, 5)
	fmt.Println(len(s2), cap(s2)) //3,5
	fmt.Println(s2[0], s2[1], s2[2])
	s2 = append(s2, 1)
	fmt.Println(len(s2), cap(s2)) //4,5
}

func TestSliceGrowing(t *testing.T) {
	s := []int{}
	for i := 0; i < 10; i++ {
		s = append(s, i)
		fmt.Println(len(s), cap(s))
	}
	/*
		1 1
		2 2
		3 4
		4 4
		5 8
		6 8
		7 8
		8 8
		9 16
		10 16
	*/
}

func TestSliceShareMemory(t *testing.T) {
	year := []string{
		"Jan",
		"Feb",
		"Mar",
		"Apr",
		"May",
		"Jun",
		"Jul",
		"Aug",
		"Sep",
		"Oct",
		"Nov",
		"Dec",
	}
	Q2 := year[3:6]               //[4,5,6]
	fmt.Println(len(Q2), cap(Q2)) //3,9 = (12-3)
	summer := year[5:8]
	fmt.Println(len(summer), cap(summer)) //3,7
	summer[0] = "unknown"                 //summer and Q2 share the same memory
	fmt.Println(Q2)                       //[Apr May unknown]
}

//Array vs Slice
//1. Array is static, size can't grow. Slice is dynamic, more like vector in C++
//2. Array can compare, Slice can't
