#include <string>
#include "Foo.h"

class Person {
public:
    explicit Person(const std::string& name):_name(name){}
    std::string get_name() const {
        return _name;
    }
    void foo() {
        Foo::foo();
    };
    void bar();
private:
    std::string _name;
};

