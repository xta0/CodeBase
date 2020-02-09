#pragma once

#include <iostream>
#include <string>

using namespace std;

namespace at {
    class Person {
    public:
        Person(string name):_name(name){}
        string getName() const;
        void setName(string name);
    private:
        string _name;
    };
}
