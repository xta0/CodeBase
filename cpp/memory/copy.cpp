#include <iostream>
#include <vector>
#include <string>
using namespace std;

class StrVec
{
  public:
  // the allocator member is default initialized
    StrVec() : elements(nullptr), first_free(nullptr), cap(nullptr){}
    StrVec(const StrVec &rhs){
        auto newdata = alloc_n_copy(rhs.begin(), rhs.end());
        elements = newdata.first;
        first_free = cap = newdata.second;

    }
    StrVec &operator=(const StrVec rhs&){
        auto newdata = alloc_n_copy(rhs.begin(), rhs.end());
        free();
        elements = newdata.first;
        first_free = cap = newdata.second;
        return *this;
    }
    ~StrVec(){
        free();
    };                           // destructor
    void push_back(const std::string &); // copy the element
    size_t size() const { return first_free - elements; }
    size_t capacity() const { return cap - elements; }
    std::string *begin() const { return elements; }
    std::string *end() const { return first_free; }
    // ...
  private:
    std::allocator<std::string> alloc; // allocates the elements
    // used by the functions that add elements to the StrVec
    void chk_n_alloc(){
        if (size() == capacity())
            reallocate();
    }
    // utilities used by the copy constructor, assignment operator, and destructor
    std::pair<std::string *, std::string *> alloc_n_copy(const std::string *, const std::string *);
    void free();       // destroy the elements and free the space
    void reallocate(); // get more space and copy the existing
    std::string *elements; // pointer to the first element in the array
    std::string *first_free;   // pointer to the first free element in the array
    std::string *cap;          // pointer to one past the end of the array
};
void StrVec::push_back(const string& s){
    chk_n_alloc();
    alloc.construct(first_free++,s);
};

std::pair<std::string *, std::string *> StrVec::alloc_n_copy(const std::string *begin, const std::string *end){;
    auto data = alloc.allocate(end-begin);
    //memcpy
    return {data, uninitialized_copy(begin,end,data)};
}

void StrVec::free(){
    if(elements){
        for(auto p = first_free; p!= elements; ){
            alloc.destroy(--p);
        }
        alloc.deallocate(elements, cap-elements);
    }
}
void StrVec::reallocate(){
    auto newsize = size()? size()*2 : 1;
    //alloc new space
    auto newdata = alloc.allocate(newsize);
    auto begin_new = newdata;
    auto begin_old = elements;
    for(int i=0;i<size();++i){
        alloc.construct(begin_new,std::move(*begin_old));
        begin_new++;
        begin_old++;
    }
    elements = newdata;
    first_free = begin_old;
    cap = elements + newsize;
}


int main()
{


    return 0;
}