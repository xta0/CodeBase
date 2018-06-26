#include <iostream>
#include <vector>
#include "cpp.h"

using namespace std;

void quickSort(vector<int>& arr, int left, int right){
    if(left >= right){
        return ;
    }
    //选择轴值为最左边数
    int pivot = arr[left];
    int l=left,r=right;
    while(l != r){
        //skip掉右边界大于pivot的值
        while(arr[r] >= pivot && r>l){
            r--;
        }
        //skip掉左边界小于pivot的值
        while(arr[l]<=pivot && r>l){
            l++;
        }
        //如果走到这里，说明有逆序对交换
        if(r > l){
            swap(arr[r],arr[l]);
        }
    }
    //归位轴值
    swap(arr[left],arr[l]);
    //两段分治
    quickSort(arr,left,l-1);
    quickSort(arr,l+1, right);
}

int main()
{
    vector<int> arr = {4,2,7,3,7,2,9,1,0,8};
    quickSort(arr,0,arr.size()-1);
    logv(arr);

    return 0;
}
