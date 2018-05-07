#include <iostream>
#include <string>

using namespace std;

int KMPStrMatching(string T, string P, int *N, int start){
    int tLen = T.length();
    int pLen = P.length();
    if(tLen - start < pLen){
        return -1;
    }
    int i=start;
    int j=0;
    while(i<tLen && j<pLen){
        if(T[i] == P[j] || N[j] == -1){
            i++, j++;
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
int f(char s[])
{
    int i = 0, j = 0;
    while(s[j]){
         j++;
    }
    for (j--; i < j && s[i] == s[j]; i++, j--){};
    return i>=j;
}
int check(const char s[],int len){
    char tmp[len];
    for(int i=0;i<len;++i){
        if(s[i] == 'G' || s[i] == 'C'){
            tmp[i]=s[i] == 'G' ? 'C':'G';
        }else {
            tmp[i]=s[i]=='A'?'T':'A';
        }
    }
    char* x = strcat(tmp,s);
    return f(x);
}
int main(){
    const char *ss = "GTACGTAC";
    cout<<check(ss,8)<<endl;



    return 0;
}