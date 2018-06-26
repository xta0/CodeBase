#include <iostream>
#include <vector>
#include "cpp.h"

using namespace std;

/*
 一共n个数，n-1次循环，时间复杂度n的平方
 思路：
 （1）一次归位一个数，这个数是当前轮次的最大数或者最小数
 （2）内外层循环从0开始，将最大值或最小值冒泡到队尾
 */
void bubbleSort(vector<int>& v){
    int n = v.size();
    //每次归位1个数，最后一个数不用归位，因此次数为n-1
    for(int i=0; i<n-1; ++i){
        //外层循环i表示已经归位了i个数，内层循环只需要再比较(n-i)次
        //当然从渐进的角度讲都是O(n^2)，因此外层循环到n也可以
        for(int j=0; j<n-i-1; j++){
            if(v[j] > v[j+1]){
                swap(v[j],v[j+1]);
            }
        }
    }
}

int main(){
    vector<int> v {3,5,4,4,3,2,2,1,0};
    bubbleSort(v);
    logv(v);
    return 0;
}