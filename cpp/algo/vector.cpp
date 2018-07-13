#include <iostream>
#include <thread>
#include <memory>
#include <algorithm>
using namespace std;

class DynamicArray{
private:
    mutex m;
    unique_ptr<int[]> array = nullptr;
    size_t length = 0;
    size_t capacity=0;
    void reallocation(){
        int *p = new int[capacity*2]();
        //copy
        copy(array.get(), array.get()+capacity, p);
        array.release();
        array.reset(p);
        capacity*=2;
        
    }
public:
    DynamicArray(int _size):length(_size),capacity(_size*2){
        array = unique_ptr<int[]>(new int[capacity]());
    }
    DynamicArray(std::initializer_list<int> list){
        length = list.size();
        capacity = length*2;
        array = unique_ptr<int[]>(new int[capacity]());
        copy(list.begin(), list.end(), array.get());
        
    }
    DynamicArray(const DynamicArray&) = delete;
    DynamicArray& operator=(DynamicArray& ) = delete;
    DynamicArray()= delete;
    ~DynamicArray(){
        array.release();
    }
    size_t size() const{
        return length;
    }
    size_t max_length() const{
        return capacity;
    }
    void push_back(int value){
        if(length == capacity){
            reallocation();
        }
        array[length] = value;
        length ++;
    }
    int pop_back(){
        int v = array[length-1];
        length--;
        return v;
    }
    bool search(int value){
        int *p = array.get();
        int *result = find(p,p+length,value);
        if(result == p+length){
            return false;
        }else{
            return true;
        }
    }
    bool insert(int index, int value){
        if(index<0 || index>=length){
            return false;
        }
        if(index == length-1){
            push_back(value);
        }else{
            if(capacity == length){
                reallocation();
            }
            int i = length-1;
            while(i >= index){
                array[i+1] = array[i];
                i--;
            }
            array[index] = value;
            length++;
        }
        return true;
        
    }
    bool remove(int index){
        if(index<0 || index>=length){
            return false;
        }
        if(index == length-1){
            pop_back();
        }else{
            for(int i=index;i<length-index;i++){
                array[i] = array[i+1];
            }
            length--;
        }
        return true;
    }
    void log(){
        cout<<"----------"<<endl;
        cout<<"size: "<<length<<", capacity: "<<capacity<<endl;
        for(int i=0;i<length;i++){
            cout<<array[i]<<" ";
        }
        cout<<endl;
    }
};
int main(){
    DynamicArray array{1};
    array.push_back(0);
    array.push_back(5);
    array.push_back(6);
    array.push_back(7);
    array.push_back(8);
    array.push_back(9);
    array.log();
    cout<<array.pop_back()<<endl;
    cout<<array.pop_back()<<endl;
    array.log();
    array.push_back(88);
    array.push_back(99);
    array.log();
    cout<<array.search(-1)<<endl;
    cout<<array.search(7)<<endl;
    array.insert(0, 44);
    array.log();
    array.remove(3);
    array.log();
    
    return 0;
}
