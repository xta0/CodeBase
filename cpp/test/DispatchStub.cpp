#include <iostream>
#include <vector>
#include <string>
#include <map>
#include <set>
#include <atomic>
#include <unordered_map>
using namespace std;

int func(int x, int y){
    return x+y;
}
using FnPtr = int(*)(int,int);
std::atomic<FnPtr> cpu_dispatch_ptr{nullptr};

int main()
{
    // if(!cpu_dispatch_ptr.load(std::memory_order_relaxed)){


    // }
    int y = (*cpu_dispatch_ptr)(100,100);
    std::cout<<"y="<<y<<std::endl;
    

    return 0;
}