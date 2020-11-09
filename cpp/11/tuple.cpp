#include <iostream>
#include <vector>
#include <string>
#include <map>
#include <set>
#include <unordered_map>
#include <tuple>
#include <list>
using namespace std;

int main(){
    tuple<string, vector<double>, int, list<int>> items = {
        "constants",
        {3.14, 2.718},
        42,
        {0, 1, 2, 3, 4, 5}
    };

    return 0;
}