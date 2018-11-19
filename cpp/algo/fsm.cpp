#include <iostream>
#include <vector>
#include <string>
#include <stack>
#include <queue>
#include <map>
#include <set>
#include <unordered_set>
#include <unordered_map>
using namespace std;

struct hashpair{
    template<class T1, class T2>
    size_t operator()(const pair<T1,T2>&x)const{
        hash<T1> h1;
        hash<T2> h2;
        return h1(x.first) ^ h2(x.second);
    }
};

typedef unordered_map<pair<int, char>, int, hashpair> STATE;

bool fsmsim(string input, int current, STATE& edges, unordered_set<int> acceptingState){
    if(input.empty()){
        return acceptingState.count(current);
    }
    char c = input.front();
    pair<int, char> key = {current,c};
    if(edges.count(key)){
        int next_state = edges[key];
        string remain = input.substr(1);
        return fsmsim(remain, next_state, edges, acceptingState);
    }else{
        return false;
    }
}
int main(){

    
    STATE edges = {
        { {1,'a'},2},
        { {2,'a'},2},
        { {2,'1'},3},
        { {3,'1'},3},
    };
    unordered_set<int> accept = {3};
    
    cout<<fsmsim("aaa111", 1, edges, accept)<<endl;
    cout<<fsmsim("a1a1a1", 1, edges, accept)<<endl;
    cout<<fsmsim("", 1, edges, accept)<<endl;
    
    return 0;
}
