#include <iostream>
#include <vector>
#include <string>
#include <map>
#include <set>
#include <unordered_map>
using namespace std;

class X {
public:
    X(int a):x(a){}
public:
int x = 0;
};
class B : public X {
public:
    B(int b):X(b){}
};

int main(){
    B b(10);
    std::cout<<b.x<<std::endl;



    return 0;
}