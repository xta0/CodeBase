#include <iostream>
#include <vector>
#include <unordered_set>
#include <functional>
using namespace std;

struct Sale{
    string data;
    int num;
    Sale(string _data, int _num):data(_data),num(_num){}
    bool operator==(const Sale& s) const {
        return num == s.num && s.data == data;
    }
};
namespace std{
    template<>
    struct hash<Sale>{
        size_t operator()(const Sale& s) const{
            return hash<string>()(s.data);
        }
    };
}
size_t hasher(const Sale& s){
    return hash<string>()(s.data);
}

int main(){
    unordered_set<Sale> s = {{"Jason",33},{"Jacob",32} };
    unordered_set<int> x = {1,2,3};
    return 0;
}