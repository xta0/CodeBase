#include <iostream>
#include <vector>
#include <string>
#include <map>
#include <set>
#include <unordered_map>
#include <memory>

using namespace std;


class Person {
public:
    Person(string name):_name(name){}
    string getName() const {
        return _name;
    }
    void setName(string name) {
        _name = name;
    }
private:
    string _name;
};

void f(const std::shared_ptr<Person>& w){
    std::cout<<"use count: "<<w.use_count()<<std::endl;
}
void g() {
    std::shared_ptr<Person> p = std::make_shared<Person>("peter");
    std::cout<<"use count: "<<p.use_count()<<std::endl;
    // f(std::move(p));
    f(p);
    std::cout<<"use count: "<<p.use_count()<<std::endl;
    std::cout<<"after f: "<<std::endl;

    std::cout<<!p<<std::endl;
}

int main(){
    g();



    return 0;
}