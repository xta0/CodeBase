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

int main(){
    vector<string> vec = {"one","two","three"};

    int count = 0;
    //pass function
    count = count_if(vec.begin(),vec.end(), check);
    //pass lambda expression
    count = count_if(vec.begin(),vec.end(),[](string s){
        return s.size()==3;
    });
    //pass functor
    count = count_if(vec.begin(),vec.end(),Check());

    cout<<count<<endl;


    return 0;
}