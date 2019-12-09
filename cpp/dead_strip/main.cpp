#include <iostream>
#include <string>
#include "./CC.h"
using namespace std;

class AA {
public:
AA(){
    //this happends before main starts
    cout<<"AA is constructed"<<endl;
}
void bark() {
    cout<<"AA.bark()"<<endl;
}
private:
string str_;
};
class BB {
public:
    void foo(){
        cout<<"BB.foo"<<endl;
    }
    void bar(){
        cout<<"BB.bar"<<endl;
    }
};
void func1(){
    cout<<"func1"<<endl;
}

//because of this, A won't get stripped
AA REG_A = AA();
CC REG_C = CC();

typedef void(*fp)(int,int)

int main(){
    cout<<"main starts"<<endl;
    BB b = BB();
    b.bar();
    DD d;
    d.dd();
    return 0;
}