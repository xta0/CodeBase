#include <iostream>
#include <vector>
#include <string>
#include <random>
using namespace std;

int main(){
    vector<int> vec(20,0);
    default_random_engine e;
    uniform_int_distribution<unsigned> u(0,100);
    for(int i=0;i<20;i++){
        vec[i] =u(e);
    }
    auto itor = std::max_element(vec.begin(), vec.end());
    cout<<*itor<<endl;

    return 0;
}