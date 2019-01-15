#include <iostream>
#include <vector>
#include <string>
#include <map>
#include <set>
#include <unordered_set>
#include <unordered_map>
using namespace std;

int partition(vector<int>& arr, int lo, int hi){
    //a[lo,...,i-1],a[i],a[i+1,...,hi]
    int p = arr[lo];
    int i = lo;
    int j = hi+1;
    while(true){
        //skip掉左边界小于pivot的值
        do { i++; } while( i<=hi && arr[i] < p );
        do { j--; } while( arr[j] > p);
        if( i>=j ){
            break;
        }
        swap(arr[i],arr[j]);
    }
    //swap pivot
    swap(arr[lo],arr[j]);
    return j;
}
int quickSelect(vector<int>& arr, int lo, int hi, int k){
    if(lo >= hi){
        return arr[lo];
    }
    int p = partition(arr, lo, hi);
    int index = (int)arr.size() - p;
    if( k==index ){
        return arr[p];
    }else if( k < index){
        return quickSelect(arr, p+1, hi, k);
    }else{
        return quickSelect(arr,lo,p-1,k);
    }
}
int main(){
    vector<int> arr = {3,2,1,5,6,4};
    cout<<quickSelect(arr,0,(int)arr.size()-1, 2);
    
    
    return 0;
}
