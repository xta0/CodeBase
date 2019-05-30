#include <iostream>
#include <vector>
#include <string>
#include <map>
#include <set>
#include <unordered_map>
using namespace std;

template <typename T>
int comp(const T& v1, const T& v2) {
    if (v1<v2){
        return -1;
    } 
    if (v1>v2){
        return 1;
    }
    return 0;
}

int main(){
    int ret = comp<int>(10,10);   
    return 0;
}