/*
Application Entry Point:
1. The package name must be "main"
2. The function name must be "main"
3. The file name doesn't have to be "main"
4. No return value for main function
	- use os.Exit(0) //0 = success 
5. can't pass parameters to main function
	- use os.Args // 返回一个数组


To Run the code:
	> go run main.go
To Compile the code:
	> go build main.go
*/

package main 

import "fmt"
import "os"


func main() {
	fmt.Println(os.Args)
	if len(os.Args) > 1 {
		fmt.Println("more than one arguments")
	}
	fmt.Println("Hello World")
	os.Exit(0) //return the exit status
}
