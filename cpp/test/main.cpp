#include <iostream>
#include <vector>
#include <string>
#include <map>
#include <set>
#include <unordered_map>
using namespace std;



int main(){
    int b[] = {1,2,3};
    vector<int> a(std::begin(b), std::end(b));
    std::cout<<a[2]<<std::endl;



    return 0;
}