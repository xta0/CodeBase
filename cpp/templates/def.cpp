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

//class type

int main(){
    int val = 0;
    val = 1.5;
    printf("%d",val);
    int ret = comp<int>(10,10);
    char c = 255;
    if (c>10){
        printf("greater");
    } else{
        printf("c=%i,less",c);
    }
    printf("1/2=%f",(float)(1/2));

    string::size_type x = 10;
    return 0;
}