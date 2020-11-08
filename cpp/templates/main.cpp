#include <iostream>
#include <vector>
#include <string>
#include <map>
#include <set>
#include <unordered_map>
using namespace std;

extern int func1(int x, int y);
extern int func2(int x, int y); 
int main(){
    cout<<func1(1,1)<<endl;
    cout<<func2(2,2)<<endl;
    return 0;
}