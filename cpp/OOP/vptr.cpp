#include <iostream>
#include <vector>
#include <string>
#include <map>
#include <set>
#include <unordered_map>
using namespace std;

class Base {  
public:
    virtual void vf1() { cout<<"Base::vf1"<<endl; }
    virtual void vf2() { cout<<"Base::vf2"<<endl; }
    void f1() { vf1(); }
    void f2() { cout<<__func__<<endl; } 
private:
    int var1;
    int var2;
};
class Derived: public Base {
public:
    virtual void vf1() { cout<<"Derived::vf1"<<endl; }
    // void f1() { cout<<"Derived::f1"<<endl; }
    void f3() { cout<<"Derived::f3"<<endl; }
private:
    int var3;
};

class CSon{
	public: ~CSon(){
        cout<<__func__<<endl;
    };
};

class CGrandson: CSon{
	public: ~CGrandson(){ cout<<__func__<<endl; };
}; 

// experiment vtable and vptr
int main(){
    Derived d;
    d.f1();


    return 0;
}