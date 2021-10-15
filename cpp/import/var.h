#include <iostream>

struct __attribute__((__visibility__("default"))) Var {
public:
    Var() {}
    void close() {
        std::cout<<"close"<<std::endl;
    }
    static void open() {
        std::cout<<"open"<<std::endl;
    }
};