#include <iostream>
using namespace std;
#include "./func.h"
#include "./foo.h"
#include "./bar.h"
#include "./var.h"

int main(){
    func();
    foo();
    bar();
    Var x;
    x.close();
    return 0;
}