#include <string>
// #include "test2.h"

void func2(std::string x);
void func1(std::string x){
    func2(x);
}
int main() {
    func1("func1");
    return 0;
}