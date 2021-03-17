
// #include "./foo.h"
#include <string>
#include <memory>
#include <assert.h>
#include <iostream>
#include <vector>
// #include "./var.h"
// #include "./bar.h"
using std::string;
struct Obj {
    int x;
    string y;
};

using namespace std;
int main(){
    std::string file_path = "extra/mobile_info.json";
    auto pos1 = file_path.find("/")+1;
    auto pos2 = file_path.find(".");
    std::cout<<pos2<<std::endl;
    std::cout<<file_path.size()<<std::endl;
    std::cout<<file_path.substr(pos1, pos2-pos1)<<std::endl;
    return 0;
}
