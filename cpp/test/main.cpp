
#include "./foo.h"
#include <string>
#include <memory>
#include <assert.h>
// #include "./bar.h"
using std::string;
struct Obj {
    int x;
    string y;
};

using namespace std;
int main(){
    // int x = 3;
    // int y = 4;
    // assert(x==1 || y==2);
    // // func1<int>(10);
    // // func2();
    // // func3();
    // std::shared_ptr<Obj> ptr = nullptr;
    // if(!ptr){
    //     std::cout<<"ptr is nullptr"<<std::endl;
    // }
    // std::string s = ptr->y;
    FOO f;
    return 0;
}
