#include <iostream>
#include <thread>
using namespace std;

//Managing thread
void func1(std::string name){
    cout << name<<endl;
}
struct Functor{
    void operator()(string name){
        cout << name << endl;
    }
};

//test join and detach
void runCode()
{
    cout << "lanched thread is running" << endl;
    std::string p = "lambda";
    std::thread td([p] { 
        std::this_thread::sleep_for(std::chrono::milliseconds(1000));
        cout << p << " thread is running" << endl; 
    });
    //td.detach()
    td.join(); //wait for td finishing
    cout << "lanched thread is ending" << endl;
}
class thread_guard{
	std::thread &t;
public:
	explicit thread_guard(std::thread& t_):t(t_){}
	~thread_guard(){
		if(t.joinable()){
			t.join();
		}
	}
	thread_guard(thread_guard const& ) = delete;
	thread_guard& operator=(thread_guard const& ) = delete;
};
class X{
public:
    void do_some_work(){
        cout<<"do_some_work"<<endl;
    };
};

int main()
{
    runCode();
    //pass parameter to thread
    std::thread t1(func1,"abc");
    thread_guard g(t1);

    X x;
    std::thread t2(&X::do_some_work, &x);
    t2.detach();
    
    return 0;
}