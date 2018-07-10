#include <iostream>
#include <thread>
using namespace std;

void func1()
{
    cout << "hello func1";
}
struct Functor
{
    void operator()(string name)
    {
        cout << name << endl;
    }
};
void runCode()
{
    cout << "lanched thread is running" << endl;
    std::string p = "lambda";
    std::thread td([p] { 
        std::this_thread::sleep_for(std::chrono::milliseconds(5000));
        cout << p << " thread is running" << endl; 
    });
    td.join();
    cout << "lanched thread is ending" << endl;
}
int main()
{
    runCode();
    return 0;
}