
#include "Person.h"
#include "Bar.h"
#include <iostream>

void Person::bar(){
    Bar::bar();
}

namespace Foo {
    void foo(){
        std::cout<<"Person:foo"<<std::endl;
    }
}