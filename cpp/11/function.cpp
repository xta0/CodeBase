#include <iostream>
#include <vector>
#include <string>
#include <functional>
#include <algorithm>

using namespace std;

//使用函数类型

bool check(const string& s){
    return s.size() == 3;
}
struct Check{
public:
    bool operator()(const string& s){
        return s.size()==3;
    }
};

// static std::function<void(void)> _loaderFunc = nullptr;
typedef void(*FUNC)(void);
struct Foo {
public:
    static FUNC _loaderFunc;
    static void registerFunc(std::function<void(void)> func){
        _loaderFunc = func;
    }
    static void open() {
        _loaderFunc();
    }  
};

void somefunc(){
    std::cout<<"func is called!"<<std::endl;
}

int main(){
    // vector<string> vec = {"one","two","three"};

    // int count = 0;
    // //pass function
    // count = count_if(vec.begin(),vec.end(), check);
    // //pass lambda expression
    // count = count_if(vec.begin(),vec.end(),[](string s){
    //     return s.size()==3;
    // });
    // //pass functor
    // count = count_if(vec.begin(),vec.end(),Check());

    // cout<<count<<endl;
    Foo::registerFunc(somefunc);
    Foo::open();


    return 0;
}