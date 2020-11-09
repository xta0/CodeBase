#include <iostream>
#include <vector>
#include <string>
#include <map>
#include <set>
#include <unordered_map>
using namespace std;

template<unsigned N, unsigned M>
int compare(const char(&p1)[N], const char(&p2)[M]){
	return strcmp(p1,p2);
}
template<typename T=int>
T func1(T x1, T x2){
    return x1*x2;
}
// template<>
int func1(int x1, int x2){
    return x1+x2;
}

int main(){
    compare("h1","h11");
    std::cout<<func1(10,10)<<std::endl;
    return 0;
}