#include <iostream>

using namespace std;

void f(int&& x) {
    std::cout<<x<<std::endl;
}

void g(int&& x){
    f(std::move(x));
}

int main(){




    return 0;
}

