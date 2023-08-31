
#include "foo.h"

void func2() {
    cout<<"func2"<<endl;
    func1<int>(100);
}

FOO::~FOO(){
    std::cout<<"dealloc"<<std::endl;
}
