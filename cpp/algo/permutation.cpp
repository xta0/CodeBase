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

//全排列-深搜
void dfs( vector<int>& nums, vector<int>& chosen, vector<vector<int>>& results){
    if(nums.size() == 0){
        results.push_back(chosen);
    }
    for(int i = 0; i<nums.size(); ++i){
        int n = nums[i];
        //set state
        chosen.push_back(n);
        nums.erase(nums.begin()+i);
        //dfs
        dfs(nums,chosen,results);
        //backtracking, unset_state
        chosen.pop_back();
        nums.insert(nums.begin()+i,n);
    }
}

vector<vector<int>> permutation(vector<int>& nums) {
    vector<vector<int>> ret;
    vector<int> vec;
    dfs(nums,vec,ret);
    return ret;
};
vector<int> kthPermutation(vector<int>& nums){

}
vector<int> nextPermutation(vector<int>& nums){
    
}


int main(){




    return 0;
}