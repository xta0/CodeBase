#include <iostream>
#include <vector>
#include <string>
#include <map>
#include <set>
#include <unordered_map>
using namespace std;

template <int n>
struct factorial {
    static const int value = n*factorial<n-1>::value;
};
template <>
struct factorial<0> {
    static const int value = 1;
};

template <bool cond, typename Then, typename Else>
struct If;

template <typename Then, typename Else>
struct If<true, Then, Else> {
    typedef Then type;
};

template <typename Then, typename Else>
struct If<false, Then, Else> {
    typedef Else type;
};

int main(){
    cout << factorial<10>::value<< endl;
    int x = 3;
    // If<factorial<4>, factorial<5>>

    
    return 0;


}