#include <iostream>
#include <vector>
#include <string>
using namespace std;

//tail trailing
template<class T>
auto test(T value) -> decltype(value){
    return value;
}
int get(){
    return 999;
}
auto test2()->decltype(get()){
    return 100;
}
void loop(vector<string>& names){
    
}

int main(){




    return 0;
}