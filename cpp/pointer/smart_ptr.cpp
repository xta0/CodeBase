#include <iostream>
#include <vector>
#include <string>
#include <map>
#include <set>
#include <unordered_map>
using namespace std;

template<typename T>
class smart_ptr {
public:
    explicit smart_ptr(T* ptr = nullptr):ptr_(ptr){}
    ~smart_ptr() { delete _ptr; }
    T* get() const { return _ptr; };
    T& operator*() const { return *_ptr; }
    T* operator->() const { return _ptr; }
    operator bool() const { return _ptr; }
private:
    T* _ptr;
};

int main(){




    return 0;
}