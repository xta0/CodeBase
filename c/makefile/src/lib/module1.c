#include "module1.h"

int  module_1_Func(int a, int b){
    printf("%s called!",__func__);
    return a+b; 
}