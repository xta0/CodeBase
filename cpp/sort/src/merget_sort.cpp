#include <iostream>
#include <vector>
#include "cpp.h"

using namespace std;

void mergeSort(vector<int>& v){
    if(v.size() <= 1){
        return;
    }
    //recursive case
    //1. split vector half
    vector<int> left = vector<int>(v.begin(), v.begin()+v.size()/2);
    vector<int> right = vector<int>(v.begin()+v.size()/2, v.end());
    //2. sort halves
    mergeSort(left);
    mergeSort(right);
    //3. merge halves
    reverse(right.begin(), right.end());
    int i1=0,i2=right.size()-1,i=0;
    while(i1 <= i2){
        if(left[i1] <= right[i2]){
            v[i] = left[i1];
            i1++;
        }else{
            v[i] = right[i2];
            i2--;
        }
        i++;
    }
/*
    int i1 = 0; //index into left
    int i2 = 0; //index into right
    int i = 0; //index of the merged array
    while(i1<left.size() && i2<right.size()){
        if(left[i1] <= right[i2]){
            v[i] = left[i1];
            i1++;
        }else{
            v[i] = right[i2];
            i2++;
        }
        i++;
    }
    //append left half
    while(i1<left.size()){
        v[i++] = left[i1++];
    }
    //append right half
    while(i2<right.size()){
        v[i++] = right[i2++];
    }
*/
}

int main(){
    vector<int> v {1,2,6,7,8,5,4,4,3,3,2,1};
    mergeSort(v);
    logv(v);
    return 0;
}