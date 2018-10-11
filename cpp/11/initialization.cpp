#include <iostream>
#include <vector>
#include <string>
using namespace std;



struct Point{
    int x;
    int y;
};

//C++ 98
struct {
    Point pt;
    int w;
    int h;
} r1 = { {10,10},20,20}, r2 = {{5,5},30,30};

int main(){
    //C++ 98
    Point pt = {10,10};



    return 0;
}