#include <stdio.h>

extern void set_mylib_int(unsigned long x);
extern long get_mylib_int();

unsigned long glob = 5555;

int main() {
    set_mylib_int(100);
    printf("value set in mylib is %ld\n", get_mylib_int());
    printf("value set in glob is %ld\n", glob);

}