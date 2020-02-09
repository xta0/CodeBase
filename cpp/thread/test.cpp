#include <iostream>
#include <thread>
#include <memory>
using namespace std;

volatile int value = 0;
std::mutex m;

void func2() {
    std::unique_lock<mutex> guard(m, std::defer_lock);
    value += 1;
    cout<<"func2 value: "<<value<<endl;
}
void func1(int index){
    
    // std::cout << "#thread: " << index << endl;
    std::lock_guard<mutex> guard(m);
    cout<<"func1 value: "<<value<<endl;
    value += 1;
    //dead lock
    func2();
    // std::this_thread::sleep_for(std::chrono::seconds(1));
    
}

int main(){

    for(int i=0; i<100;i++){
        std::thread t1(func1,i);
        t1.join();
    }
    // std::this_thread::sleep_for(std::chrono::seconds(10));
    return 0;
}