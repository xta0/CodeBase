#include <iostream>
#include <vector>
#include <string>
#include "cpp.h"
using namespace std;

int partition(vector<int>& arr, int lo, int hi){
    int i = lo;
    int j = hi+1;
    int pivot = arr[lo];
    while(true){
        //skip left
        do{ i++; } while( i<=hi && arr[i] < pivot);
        //skip right
        do{ j--; } while( arr[j] > pivot);

        if(i>j){
            break;
        }
        swap(arr[i],arr[j]);
    }
    swap(arr[lo],arr[j]);
    return j;
}

void quick_sort(vector<int>& arr,int lo, int hi){
    if(lo >= hi ){
        return;
    }
    int pivot = partition(arr,lo,hi);
    quick_sort(arr,lo,pivot -1);
    quick_sort(arr,pivot +1,hi);
}

int main(){
    vector<int> v {1,2,6,7,8,5,4,4,3,3,2,1};
    quick_sort(v,0,v.size()-1);
    logv(v);
    return 0;



    return 0;
}