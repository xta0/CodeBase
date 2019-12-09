#pragma once 
#include <iostream>
using namespace std;
template<typename T>
void func1(T x) {
    cout<<x<<endl;
}
void func2();
inline void func3() {
    cout<<"func3"<<endl;
}
//this will cause duplicated symbols
void func4(){
    cout<<"func4"<<endl;
}