#include "./func.h"
#include "./var.h"

class XX{

};

int bar() {
    Var::open();
    Var x;
    x.close();
    return func();
}