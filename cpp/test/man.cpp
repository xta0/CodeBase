#include <iostream>
#include <chrono>
#include <iostream>
#include <vector>
#include <stdio.h>
using namespace std;

class A {
public:
A(){};
A(const std::vector<int>& v) : _v(v) {}
~A() {std::cout<<"dealloc"<<std::endl;}
A(A&&) = default;
A& operator=(A&&)=default;
std::vector<int>& v() {
  return _v;
}
private:
std::vector<int> _v;
};
void compute(A&& a) {

}
int main(){
    auto x = A({1,2});
    x = {};
    std::cout<<x.v().size()<<std::endl;
    return 0;
}