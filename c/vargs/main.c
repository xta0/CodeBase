#include <stdio.h>
//http://www.cplusplus.com/reference/cstdarg/va_start/
void func(const char* fmt, ...){
    va_list argp;
    va_start(argp,fmt);
}