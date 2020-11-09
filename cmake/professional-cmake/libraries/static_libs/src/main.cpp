#include <iostream>
#include <string>
#include "Person.h"
using namespace std;

int main(){
    Person p("kate");
    std::cout<<p.get_name()<<std::endl;
    p.foo();
    return 0;
}