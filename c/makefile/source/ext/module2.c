#include "module2.h"

int  module_2_Func(int a, int b){
    printf("%s called!",__func__);
    return a-b; 
}