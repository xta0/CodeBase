#include <iostream>
#include <vector>
#include <string>
using namespace std;

class HasPtr
{
private:
    string *ptr = nullptr;
    int i = 0;

public:
    HasPtr(string str) : ptr(new string(str)), i(0)
    {
        cout << "Constructor Called!" << endl;
    }

    HasPtr(const HasPtr &other) : ptr(new string(*other.ptr)), i(other.i)
    {
        cout << "Copy Constructor Called!" << endl;
    }
    HasPtr(HasPtr &&other) noexcept : ptr(other.ptr), i(other.i)
    {
        cout << "move constructor called!" << endl;
        other.ptr = nullptr;
    }
    HasPtr &operator=(const HasPtr &other)
    {
        cout << "normal operator called!" << endl;
        auto new_ptr = new string(*other.ptr);
        delete ptr;
        ptr = new_ptr;
        i = other.i;
        return *this;
    }
    HasPtr &operator=(HasPtr &&other) noexcept
    {
        cout << "move operator called!" << endl;
        if (!other.ptr)
        {
            cout << "input is null" << endl;
            return *this;
        }
        if (this != &other)
        {
            delete ptr;
            ptr = other.ptr;
            i = other.i;
            other.ptr = nullptr;
        }
        return *this;
    }
    string getString() const
    {
        return *ptr;
    }
    ~HasPtr()
    {
        if (ptr)
        {
            delete ptr;
            ptr = nullptr;
        }
    }
};

HasPtr get()
{
    cout << __func__ << endl;
    return HasPtr("func"); //call default constructor twice, one for construct HasPtr, one for return the object
}

class MV {
private:
    std::vector<int> _buffer;
public:
     MV(const std::vector<int>& src): _buffer(src){}
     MV(MV &&other) = default;
     void print() {
         for(auto& x : _buffer){
             std::cout<<x<<std::endl;
         }
     }
};

class MV2 {
private:
    std::shared_ptr<std::string> _ptr;
public:
     MV2(const std::string& src): _ptr(make_shared<std::string>(src)){}
     MV2(MV2 &&other) = default;
     void print() {
        std::cout<<*_ptr<<std::endl;
     }
};

class MV3 {
private:
    std::shared_ptr<MV> _ptr;
public:
     MV3(const std::vector<int>& src): _ptr(make_shared<MV>(src)){}
     MV3(MV3 &&other) = default;
     void print() {
         _ptr->print();
     }

};


int main()
{
    MV mv1({1,2,3,4});
    MV mv2(std::move(mv1));
    mv2.print();

    MV2 mv3("MV2");
    MV2 mv4(std::move(mv3));
    mv4.print();

    MV3 mv5({6,7,8,9});
    MV3 mv6(std::move(mv5));
    mv6.print();

    // HasPtr p(get()); //move constructor
    // HasPtr p1("p1"); //default constructor
    // HasPtr p2(std::move(p1)); //move constructor
    // HasPtr p3("p3"); //normal constructor
    // p3 = get(); //move operator

}
