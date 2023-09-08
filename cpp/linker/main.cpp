#include <iostream>

extern void set_value(int x);
extern int get_value();
extern int demo();
int main(void) {
    set_value(100);
    int val = get_value();
    std::cout<<val<<std::endl;
    int d = demo();
    std::cout<<d<<std::endl;
    return 0;
}
