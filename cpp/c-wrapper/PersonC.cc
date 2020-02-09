#include "Person.h"
#include "PersonC.h"
#include <string>
#include <iostream>

extern "C" {
    Person* newPerson(const char* name) {
        return new Person(std::string(name));
    }
    void setPersonName(Person* v, const char* name) {
        v->setName(std::string(name));
    }
    const char* getPersonName(Person* v){
        const char* name =  v->getName().c_str();
        // std::cout<<name<<std::endl;
        return name;
    }
    void deletePerson(Person* v){
        if(v) {
            delete(v);
        }
    }
}