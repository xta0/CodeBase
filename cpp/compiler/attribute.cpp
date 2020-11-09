#include <iostream>
#include <vector>
#include <string>
#include <map>
#include <set>
#include <unordered_map>
using namespace std;

[[noreturn]] // attribute
int func(bool flag) // 函数绝不会返回任何值
{ 
    [[gnu::unused]] //非标准的扩展attribute
    int x = 5;
    cout<< "flag: "<< flag <<endl;
}

int main(){
    func(true);
    return 0;
}