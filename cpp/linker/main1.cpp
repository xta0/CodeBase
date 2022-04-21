#include <iostream>

extern void set_value(int x);
extern int get_value();
int main(void) {
    set_value(100);
    int val = get_value();
    std::cout<<val<<std::endl;
    return 0;
}
