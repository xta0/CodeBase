#include <iostream>
#include <string>
#include <vector>

using namespace std;

vector<int> buildNext(string s){


    return {};
}

int kmp(string T, string P, vector<int> N, int start){
    int tLen = T.length();
    int pLen = P.length();
    if(tLen - start < pLen){
        return -1;
    }
    int i=start;
    int j=0;
    static int x = 0;
    while(i<tLen && j<pLen){
        if(T[i] == P[j] || j == -1){            
            i++; j++;
        }else{
            j = N[j];
        }
    }
    if(j >= pLen){
        return i-pLen;
    }else{
        return -1;
    }
}

int main(){

    string P = "aabcaabbaa";
    string T = "aaabaabcabaabcaabbaab";
    vector<int> N = {-1,0,0,-1,1,0,2,0,0};
    cout<<kmp(T,P,N,0)<<endl;
    return 0;
}