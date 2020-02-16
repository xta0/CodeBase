#include <iostream>
#include <vector>
#include <string>
#include <map>
#include <set>
#include <unordered_map>
using namespace std;

//before C++11, the rvalue can be bound to const lvalue
void func(const string& msg){
    cout<<"const lvalue"<<endl;
}
// void func(string msg){
//     cout<<"copy"<<endl;
// }
// void func(string& msg){
//     cout<<"reference"<<endl;
// }
// void func(string&& msg){
//     cout<<"rvalue"<<endl;
// }

//dummy class
class shape {

};

void foo(const shape&){
  puts("foo(const shape&)");
}

void foo(shape&&){
  puts("foo(shape&&)");
}

void bar(const shape& s){
  puts("bar(const shape&)");
  foo(s);
}

void bar(shape&& s){
  puts("bar(shape&&)");
  foo(s);
}

int main(){
  bar(shape()); 
  return 0;
}
