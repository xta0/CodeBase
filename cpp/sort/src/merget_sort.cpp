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
    int i1 = 0; //index into left
    int i2 = 0; //index into right
    for(int i =0; i<v.size(); i++){
        //take from left IF:
        //      1. nothing remaining on the right
        //      2. thing on the left is maller
        if(i2>=right.size() || (i1<left.size() && left[i]<right[i2])){
            v[i] = left[i1];
            i1++;
        }else{
            v[i] = right[i2];
            i2++;
        }
    }
    

}

int main(){
    vector<int> v {5,4,3,2,1};
    // vector<int> v {1,2,3,4,5,6};
    mergeSort(v);
    logv(v);




    return 0;
}