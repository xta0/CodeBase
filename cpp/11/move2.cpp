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
    int x = 10;
    ~Dummy(){
        std::cout<<__func__<<std::endl;
    }
    Dummy(Dummy&& dm){
        x = dm.x;
    }
};

void foo(Dummy&& dm){
    dm.x = 100;
}

Dummy bar(){
    return Dummy();
}

Dummy& dummy(Dummy&& dm){
    return dm;
}

int main(){
    Dummy dm = Dummy();
    Dummy&& dm2 = std::move(dm);
    dm2.x = 100;
    std::cout<<dm.x<<std::endl;
    // std::move(bar());
    std::cout<<"main"<<std::endl;
    
    

    return 0;
}

