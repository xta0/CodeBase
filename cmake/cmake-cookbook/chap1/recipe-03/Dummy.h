#include <iostream>
#include <string>

using namespace std;

class Torch {
public:
    Torch(const std::string& str):_str(str){};
    Torch(const std::string& str1, const string& str2);
    void foo();
    void bar() {
        cout<<__func__<<endl;
    }
private:
    string _str;
};