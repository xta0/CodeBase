#include <iostream>

// clang++ -S -O0 -emit-llvm ./main.cpp 
int main(){
    uint32_t n = 3;
    uint32_t x = n + 8;
    uint32_t y = n * 15;
    uint32_t z = n / 71;
    // std::cout<<x<<y<<z<<std::endl;
    return 0;
}