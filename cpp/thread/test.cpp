#include <iostream>
#include <thread>
#include <memory>
using namespace std;

volatile int value = 0;
std::mutex m;

void func(int index){
    
    std::cout << "#thread: " << index << endl;
    std::lock_guard<mutex> guard(m);
    value += 1;
    cout<<"value: "<<value<<endl;
    std::this_thread::sleep_for(std::chrono::seconds(1));
    
}

int main(){

    for(int i=0; i<100;i++){
        std::thread t(func,i);
        t.detach();
    }
    // std::this_thread::sleep_for(std::chrono::seconds(10));
    return 0;
}