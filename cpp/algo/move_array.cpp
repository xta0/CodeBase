#include <iostream>
using namespace std;

int main(){
    int a[10] = {0,1,2,3,4,5,6,7,8,9};
    int k = 3;
    for(int i=0;i<k;i++){
        int tmp = a[9];
        for(int j=0;j<9;j++){
            a[j+1] = a[j];
        }
        a[0]=tmp;
    }
    for(int i=0;i<10;i++){
        cout<<a[i]<<" ";
    }
    cout<<endl;


    return 0;
}