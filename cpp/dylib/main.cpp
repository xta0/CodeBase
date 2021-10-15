#include <iostream>
#include <string>
#include "lib_a.h"
#include "lib_b.h"
#include <dlfcn.h>

typedef void(*LFUNC)();
typedef int(*FFUNC)();
int main(){
    void* p1 = nullptr;
    p1 = dlopen("lib_a.dylib", RTLD_LAZY);
    if(!p1){
        std::cout<<"error loading lib_a"<<std::endl;
    }
    void* p2 = nullptr;
    p2 = dlopen("lib_b.dylib", RTLD_LAZY);
    if(!p2){
        std::cout<<"error loading lib_b"<<std::endl;
    }
    LFUNC l1 = (LFUNC)dlsym(p1, "_ZN2L12l1Ev");
    printf("l1: %p\n", l1);
    LFUNC l2 = (LFUNC)dlsym(p2, "_ZN2L22l2Ev");
    printf("l2: %p\n", l2);
    FFUNC f1 = (FFUNC)(dlsym(p2, "_ZN1F5func1Ev"));
    printf("f1: %p\n", f1);
    FFUNC f2 = (FFUNC)(dlsym(p1, "_ZN1F5func1Ev"));
    printf("f2: %p\n", f2);
    
    l1();
    l2();
    f1();
    f2();
    // L1::l1();
    // L2::l2();
    return 0;
}
