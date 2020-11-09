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
    template<typename U>
    friend class smart_ptr;
    explicit smart_ptr(T* ptr = nullptr):ptr_(ptr){}
    //copy constructor
    smart_ptr(smart_ptr& other) {
        ptr_ = other.release();
    }
    //move constructor
    smart_ptr(smart_ptr&& other) {
        ptr_ = other.release();
    }
    ~smart_ptr() {
        cout<<"dealloc"<<endl;
        delete ptr_; 
    }
    T* get() const { return ptr_; };
    T* release() {
        T* ptr = ptr_;
        ptr_ = nullptr;
        return ptr;
    }
    void swap(smart_ptr& rhs){
        std::swap(ptr_, rhs.ptr_);
    }
    T& operator*() const { return *ptr_; }
    T* operator->() const { return ptr_; }
    operator bool() const { return ptr_; }
    smart_ptr& operator=(smart_ptr& other) {
        std::swap(this, other->ptr_);
        return *this;
    }
private:
    T* ptr_;
};

int main(){
    smart_ptr<int> ptr1{new int(111)};
    auto ptr2(ptr1);
    auto ptr1.get();

    
    
    
    return 0;
}
