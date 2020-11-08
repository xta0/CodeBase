#include "./t1.h"

extern template int func(int, int);

int func2(int x, int y){
    return func<int>(x,y);
}