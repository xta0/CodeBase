#include <iostream>
#include <string>
using namespace std;

bool check(string s1, string s2){
    

    return false;
}
int main(){
    string s1 = "AGCTAGCT";
    string s2 = "";
    for(auto c : s1){
        if(c == 'A'){
            s2 += 'T';
        }else if( c== 'T'){
            s2 += 'A';
        }else if( c== 'G'){
            s2 += 'C';
        }else{
            s2 += 'G';
        }
    }
    cout<<s1<<endl;
    std::reverse(s2.begin(), s2.end());
    cout<<s2<<endl;
    if(s1 == s2 ){
        cout<<"yes"<<endl;
    }else{
        cout<<"no"<<endl;
    }


    return 0;
}