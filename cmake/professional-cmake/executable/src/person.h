#include <string>

class Person {
public:
    explicit Person(const std::string& name):_name(name){}
    std::string get_name() const {
        return _name;
    }
private:
    std::string _name;
};