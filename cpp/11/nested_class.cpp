#include <iostream>
#include <vector>
#include <string>
using namespace std;

template<typename T>
class Ring{
  public:
    class iterator;
};
  
template<typename T>
class Ring<T>::iterator{
    public:
    void print(){
        cout<<"This is from iterator"<<endl;
    }
};

int main(){
    Ring<string> ring;
    Ring<string>::iterator itor;
    itor.print();

    return 0;
}
