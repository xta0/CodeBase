#include <iostream>
#include <string>
#include "PersonC.h"

using namespace std;

//to link the static library, 
//run g++ main.cpp path_to_lib -o a.out
int main(){
    Person* p = newPerson("Chris");
    std::cout<<getPersonName(p)<<std::endl;
    setPersonName(p, "Tao");
    std::cout<<getPersonName(p)<<std::endl;
    deletePerson(p);
    
    return 0;
}