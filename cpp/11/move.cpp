#include <iostream>
#include <vector>
#include <string>
using namespace std;

class HasPtr{
private:
    string* ptr = nullptr;
    int i =0;
public:
    HasPtr(string str):ptr(new string(str)),i(0){
        cout<<"Constructor Called!"<<endl;
    }
    ~HasPtr (){
        if(ptr){
            delete ptr;
            ptr = nullptr;
        }
    }
    HasPtr(const HasPtr& other): ptr(new string(*other.ptr)),i(other.i){
        cout<<"Copy Constructor Called!"<<endl;
    }
    HasPtr& operator=(const HasPtr& other){
        cout<<"normal operator called!"<<endl;
        auto new_ptr = new string(*other.ptr);
        delete ptr;
        ptr = new_ptr;
        i = other.i;
        return *this;
    }
    HasPtr(HasPtr&& other) noexcept:ptr(other.ptr),i(other.i){
        cout<<"move constructor called!"<<endl;
        other.ptr = nullptr;
    }
    HasPtr& operator=(HasPtr&& other) noexcept{
        cout<<"move operator called!"<<endl;
        if(!other.ptr){
            cout<<"input is null"<<endl;
            return *this;
        }
        if(this != &other){
            delete ptr;
            ptr = other.ptr;
            i = other.i;
            other.ptr = nullptr;
        }
        return *this;
    }
    string getString() const {
        return *ptr;
    }
};

HasPtr get(){
    return HasPtr("func");
}

int main(){

    HasPtr p(get()); //move constructor
    HasPtr p1("p1");
    HasPtr p2(std::move(p1)); //move constructor
    HasPtr p3("p3"); //normal constructor
    p3 = get(); //move operator

    string s1 = "a";
    string s2 = "b";
    
    
    
    
    return 0;
}
