#include <iostream>
#include <memory>

using namespace std;

template <typename T>
class ring{
  public:
    // declare a sub type
    class iterator;
    iterator begin(){
      return iterator(0, *this);
    }
    iterator end(){
      return iterator(sz, *this);
    }
  
  public:
    ring(int sz) : sz(sz), data(new T[sz]){}
    ~ring(){}
    int size() const{
      return sz;
    }
    void add(T value){
      data[pos++] = value;
      if(pos == sz){
        pos = 0;
      }
    }
    T& get(int i){
      return data[i];
    }

  private:
    int sz = 0;
    int pos = 0;
    unique_ptr<T[]> data;
};

template<typename T>
class ring<T>::iterator{
  private:
    int pos;
    ring& buffer;
  public:
    iterator(int pos, ring& buffer):pos(pos), buffer(buffer){}
    //itor++
    iterator& operator++(int){
      pos++;
      return *this;
    }
    //++itor
    iterator& operator++(){
      pos++;
      return *this;
    }
    //*itor
    T& operator*(){
      return buffer.get(pos);
    }
    //itor1 != itor2
    bool operator != (const iterator& other) const{
      return pos != other.pos;

    }
};