#include <iostream>

class Base {
public:
    Base() {
        std::cout<<"Base Ctor"<<std::endl;
    }
    virtual ~Base() {
        std::cout<<"Base Dtor"<<std::endl;
    }
    virtual void print(){
        std::cout<<"Base Print"<<std::endl;
    }
};

class Derived: public Base {
public:
    Derived() {
        std::cout<<"Derived Ctor"<<std::endl;
    }
    virtual ~Derived() {
        std::cout<<"Derived Dtor"<<std::endl;
    }
    virtual void print() override{
        std::cout<<"Derived Print"<<std::endl;
    }
};

void print(Base* p){
    p->print();
}

int main(){
    Base* d = new Derived();
    print(d);
    delete d;

    return 0;
}