#include <iostream>
class A{
public:
    void bark(){
        std::cout << "bark" << std::endl;
    }
    void print() {
        std::cout<<"print"<<std::endl;
    }
};

//main.cpp
int main(){
    A b;
    b.print();
    return 0;
}

