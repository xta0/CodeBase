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

typedef unordered_map<pair<int, char>, vector<int>, hashpair> STATE;

bool nfa(string input, int current, STATE& edges, unordered_set<int> acceptingState){
    if(input.empty()){
        return acceptingState.count(current);
    }
    char& c = input.front();
    pair<int, char> key = {current,c};
    if(edges.count(key)){
        auto next_states = edges[key];
        for(auto state : next_states){
            string remain = input.substr(1);
            if(nfa(remain, state, edges, acceptingState)){
                return true;
            }
        }
        
    }
    return false;
}
int main(){

    
    STATE edges = {
        { {1,'a'},{2,3}},
        { {2,'a'},{2}},
        { {3,'b'},{4,3}},
        { {4,'c'},{5}},
    };
    unordered_set<int> accept = {2,5};
    
    cout<<nfa("abc", 1, edges, accept)<<endl;
    cout<<nfa("aaa", 1, edges, accept)<<endl;
    cout<<nfa("abbbc", 1, edges, accept)<<endl;
    cout<<nfa("aabc", 1, edges, accept)<<endl;
    cout<<nfa("", 1, edges, accept)<<endl;
    
    return 0;
}
