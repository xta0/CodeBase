#include "cpp.h"
#include <iostream>
#include <vector>
using namespace std;

void bucketSort(vector<int>& v){
    vector<int> bucket(v.size(),0);
    for(auto x:v){
        bucket[x] ++;        
    }
    int index = 0;
    for(int i=0;i<bucket.size();i++){
        for(int j=0; j<bucket[i];j++){
            v[index++] = i; 
        }
    }
}
int main(int argc, char **argv)
{
    vector<int> v {3,5,4,4,3,2,2,1,0};
    bucketSort(v);
    logv(v);
    return 0;
}