#include "Person.h"
namespace at {
    void Person::setName(string str) {
        _name = str;
    }
    string Person::getName() const {
        return _name;
    }
}