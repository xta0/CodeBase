#include <iostream>
#include <vector>
#include <string>
#include <memory>
using namespace std;

class Buffer{
private:
    int* _ptr = nullptr;
    int _SIZE = 100;
    
public:
    Buffer() {
        cout<<__func__<<endl;
        _ptr = new int[_SIZE]{};
    }
    ~Buffer(){
        cout<<__func__<<endl;
        if(_ptr){
            delete [] _ptr;
            _ptr = nullptr;
        }
    }
    Buffer(int i):_SIZE(i){
        cout<<__func__<<endl;
        Buffer();
    }
    Buffer(const Buffer& other){
        cout<<__func__<<endl;
        _ptr = new int[_SIZE]{};
        memcpy(_ptr, other._ptr, _SIZE*sizeof(int));
    }
    Buffer& operator=(const Buffer& other){
        cout<<__func__<<endl;
        _SIZE = other._SIZE;
        int* newPtr = new int[_SIZE]{};
        memcpy(newPtr,other._ptr,_SIZE*sizeof(int));
        delete [] _ptr;
        _ptr = newPtr;
        return *this;
    }
    friend ostream& operator<<(ostream &out, const Buffer& buffer);
};
ostream& operator<<(ostream &out, const Buffer& buffer){
    out<<"Hello from buffer";
    return out;
}


int main(){

    Buffer buffer(10);
    


    return 0;
}