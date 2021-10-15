#include "./func.h"
#include "./var.h"

int foo() {
    Var::open();
    Var x;
    x.close();
    return func();
}