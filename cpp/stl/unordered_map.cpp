#include <iostream>
#include <vector>
#include <unordered_map>
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

int main(){
    unordered_map<char, vector<char>> c{
        {'2', {'a', 'b', 'c'}},
        {'3', {'d', 'e', 'f'}},
        {'4', {'g', 'h', 'i'}},
        {'5', {'j', 'k', 'l'}},
        {'6', {'m', 'n', 'o'}},
        {'7', {'p', 'q', 'r', 's'}},
        {'8', {'t', 'u', 'v'}},
        {'9', {'w', 'x', 'y', 'z'}}};

    cout<<"bucket_count: "<<c.bucket_count()<<endl;
    cout<<"max_bucket_count: "<<c.max_bucket_count()<<endl;
    cout<<"bucked_size: "<<c.bucket_size(1)<<endl;
    cout<<"bucked: "<<c.bucket('5')<<endl;
    cout<<"bucked: "<<c.bucket('4')<<endl;
    cout<<"bucked: "<<c.bucket('3')<<endl;
    cout<<"load factor: "<<c.load_factor()<<endl;
    cout<<"max load factor: "<<c.max_load_factor()<<endl;

    
    // pair<Sale,int> p = make_pair();
    unordered_map<Sale,int> b = {
        {{"Jason",22},100},
        {{"Jasos",23},100}
    };
    

      
    

    return 0;
}