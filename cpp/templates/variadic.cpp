#include <iostream>
#include <vector>
#include <string>
#include <sstream>
using namespace std;

template<typename T>
std::string stringify_impl(const T& t){
    std::stringstream ss;
    ss << t;
    return ss.str();
}

// std::vector<std::string> stringify(){
//     return {};
// }

// template<typename T, typename ... Param>
// std::vector<std::string> stringify(const T& p1, const Param& ... param){
//     vector<std::string> ret;
//     std::string s = stringify_impl(p1);
//     ret.push_back(s);
//     const auto remainders = stringify(param...);
//     ret.insert(ret.end(), remainders.begin(), remainders.end());
//     return ret;
// }

template<typename ... Param>
std::vector<std::string> stringify(const Param& ... param){
    std::cout<<sizeof...(Param)<<std::endl;
    std::cout<<sizeof...(param)<<std::endl;
    return { stringify_impl(param)... };
}

int main(){
    const auto vec = stringify("hello",1,4.5);
    for (const auto& s : vec){
        cout<<s<<endl;
    }
    return 0;
}

