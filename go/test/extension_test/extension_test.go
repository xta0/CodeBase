package extension_test

import (
	"fmt"
	"testing"
)

//Go 的extension很独特
type Pet struct {
	name string
}

func (this *Pet) bark() string {
	return this.name
}

type Dog struct {
	Pet
	name string
}

//Pet会在Dog内展开，类似下面
// type _Dog struct {
// 	Pet.name string
// 	Pet.bark func()string
// 	name string
// }

func TestExtension(t *testing.T) {
	dog := new(Dog)
	dog.name = "dog1"
	dog.Pet.name = "pet-dog1"
	fmt.Println(dog.bark()) //pet-dog1

	dog2 := Dog{Pet{"pet-dog2"}, "dog2"}
	fmt.Println(dog2.bark()) //pet-dog2
}
