#include "cpp.h"
using namespace std;

void selectionSort(vector<int>& vec){
    for(int i=0;i<vec.size();++i){
        int minIndex = i;
        for(int j=i+1; j<vec.size(); ++j){
            if(vec[j] < vec[minIndex]){
                minIndex = j;
            }
        }
        swap(vec[i],vec[minIndex]);
        logv(vec);
    }
}

int main(){

    vector<int> v {46,74,16,53,14,26,40,38,86,65,27,34};
    selectionSort(v);
    logv(v);
    return 0;


    return 0;
}