#include <iostream>

using namespace std;

void f(int&& x) {
    std::cout<<x<<std::endl;
}

void g(int&& x){
    f(std::move(x));
}

class Dummy {
public:
    int x;
    ~Dummy(){
        std::cout<<"Dummy dealloc"<<std::endl;
    }
};

void foo(Dummy&& dm){
    dm.x = 100;
}

int main(){
    Dummy dm;
    dm.x = 10;
    foo(std::move(dm));
    std::cout<<dm.x<<std::endl;



    return 0;
}

