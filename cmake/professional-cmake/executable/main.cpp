#include <iostream>
#include <string>
#include "src/person.h"
using namespace std;

int main(){
    Person p("kate");
    std::cout<<p.get_name()<<std::endl;
    return 0;
}