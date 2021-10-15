#include <iostream>
#include <vector>
#include <string>
#include <map>
#include <set>
#include <unordered_map>
using namespace std;

int main(){

ushort dim0 = 1;
ushort dim1 = 2;
ushort dim = 5;
// ushort n = 0;
ushort index2 = 12345;
std::cout<<"y's linear index: "<<index2<<std::endl;

std::vector<ushort> inSizeBuffer {1, 2, 58, 28 ,28};
std::vector<ushort> outSizeBuffer {1, 58, 2 ,28, 28};
std::vector<ushort> indexBuffer {1, 1, 1 ,1, 1};

for(int j = dim-1; j>=0; --j){
    ushort d = outSizeBuffer[j];
    indexBuffer[j] = index2 % d;
    index2 /= d;
}

std::cout<<"y's index"<<std::endl;
for(ushort d : indexBuffer){
    std::cout<<d<<",";
}
std::cout<<""<<std::endl;


//3. swap dims
ushort tmp = indexBuffer[dim0];
indexBuffer[dim0] = indexBuffer[dim1];
indexBuffer[dim1] = tmp;

std::cout<<"x's index"<<std::endl;
for(ushort d : indexBuffer){
    std::cout<<d<<",";
}
std::cout<<""<<std::endl;

//4. calculate the linear idx for input
ushort index1 = 0;
ushort m = 1;
for(int k = dim-1; k>=0; --k) {
    ushort d = indexBuffer[k];
    index1 += d * m;
    // std::cout<<"index1: "<<index1<<std::endl;
    m *= inSizeBuffer[k];
    // std::cout<<"m: "<<m<<std::endl;
}

std::cout<<"x's linear index: "<<index1<<std::endl;

return 0;

}