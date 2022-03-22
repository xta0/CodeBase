#include <iostream>
#include <vector>
#include <string>
#include <map>
#include <set>
#include <unordered_map>
using namespace std;

struct SomeObj{};
void func(std::string) {
    
}

int main(){
    int x[] = {1,2,3};
    std::cout<<typeid(SomeObj).name()<<std::endl;
    std::cout<<typeid(func).name()<<std::endl;
    std::cout<<typeid(x).name()<<std::endl;


    return 0;
}