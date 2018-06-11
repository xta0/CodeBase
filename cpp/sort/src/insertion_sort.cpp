#include <iostream>
#include <vector>
#include "cpp.h"

using namespace std;

void insertSort(vector<int>& v){
    for(int i=1;i<v.size();++i){ //无序部分从1开始减少
        int e = v[i]; //无序部分的首元素，待插入数字
        int j = i-1;
        for(;j>=0 ; j--){ //有序部分从0开始增加
            if(e < v[j]){
                //将大于等于e的记录向后移
                v[j+1] = v[j];
            }else{
                //得到插入位置j+1
                break;
            }            
        }
        v[j+1] = e;        
    }
}

//也可以用swap来进行插入排序，这种情况下插入排序变成反向冒泡排序
void insertSort2(vector<int>& v){
    for(int i = 1; i<v.size(); ++i){
        for(int j = i; j>=0; j-- ){
            if(v[j]<v[j-1]){
                swap(v[j],v[j-1]);
            }else{
                break;
            }
        }
    }
}

int main(){
    vector<int> v {3,5,4,4,3,2,2,1,0};
    insertSort(v);
    logv(v);
    return 0;
}