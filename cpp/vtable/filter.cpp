// #include <iostream>
using namespace std;

class BaseFilter {
public:
    virtual void activate() const {
        // cout<<"BaseFilter"<<endl;
    }
    virtual ~BaseFilter() {}
    char val;
};

class FilterBright: public BaseFilter {
public:
     void activate() const override {
        //  *pixel += val;
     }
     ~FilterBright() {}
};

int main() {
    // string s("abc");
    FilterBright fb;
    fb.activate();
    return 0;
}