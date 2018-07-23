#include <iostream>
#include <vector>
#include <string>
using namespace std;

class A{
    public:
    int x ;
    vector<string> vec;
};

int main(){
    int x = 0;
    string y= "10000";
    cout<<sizeof(x)<<endl;
    cout<<sizeof(y)<<endl;
    vector<string> tmp;
    tmp.push_back("ab");
    tmp.push_back("cd");
    cout<<sizeof(tmp)<<endl;
    A obj;
    obj.vec.push_back("1");
    cout<<sizeof(obj)<<endl;



    return 0;
}