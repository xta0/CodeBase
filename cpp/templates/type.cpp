#include <iostream>
#include <vector>
#include <string>
#include <map>
#include <memory>
#include <set>
#include <unordered_map>
using namespace std;

template<typename T>
struct Obj {
    using type = T;
    static T var;
};
template <typename T>
void f() {
    // typename Obj<T>::type var = Obj<T>::var;
};

// template<typename T>
// struct Obj2 {
//     template <typename U>
//     void m(U x) {
//         cout<<x<<endl;
//     };
// };
// template <typename T>
// void f3(T x) {
//     Obj2<T> v;
//     v.mfunc<T>();
// }

int main(){
    // Obj2<int> obj;
    // obj.m<int>(10);
    // return 0;
    // f<int>();
    int a = 10;
    int&& b = static_cast<int&&>(a);
    return 0;
}