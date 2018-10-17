#include <iostream>
#include <vector>
#include <string>
#include <initializer_list>

using namespace std;



struct Point{
    int x;
    int y;
};

//C++ 98
struct Rect{
    Point pt;
    int w;
    int h;
};

ostream& operator<<(ostream& cout, const Point& pt){
    cout<<"{"<<pt.x<<","<<pt.y<<"}"<<endl;
    return cout;
}
ostream& operator<<(ostream& cout, const Rect& rt){
    cout<<"{"<<rt.pt.x<<","<<rt.pt.y<<","<<rt.w<<","<<rt.h<<"}"<<endl;
    return cout;
}

class Test{
public:
    Test(initializer_list<string> texts){
        for(auto v : texts){
            cout<<v<<endl;
        }
    }
    void print(initializer_list<string> list){
        for(auto v : list){
            cout<<v<<endl;
        }
    }

};


int main(){
    //C++ 98
    Point pt98 = {10,10};
    Rect rt98 = {pt98,100,100};
    cout<<pt98<<endl;
    cout<<rt98<<endl;

    //C++ 11
    Point pt11{10,10};
    Rect rt11{pt11,100,100};
    cout<<pt11<<endl;
    cout<<rt11<<endl;

    int value{5};
    string text{"hello"};
    int numbers[]{1,2,3};
    int *pInts = new int[3]{1,2,3};
    cout<<pInts[1]<<endl;
    delete [] pInts;

    int value1{}; //0
    int *pSomething{nullptr};

    vector<string> strings{"one","two","three"};

    //initializer_list
    Test test{"apple","orange","banna"};
    test.print({"one","two"});

    return 0;
}