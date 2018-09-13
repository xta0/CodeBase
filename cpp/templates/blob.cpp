#include <iostream>
#include <vector>
#include <string>
using namespace std;

template <typename T>
class Blob{
    typedef typename std::vector<T>::size_type size_type;
private:
    std::shared_ptr<vector<T>> data;
public:
    Blob():data(std::make_shared<vector<T>>()){}
    Blob(std::initializer_list<T> il):data(std::make_shared<vector<T>>(il)){}
    size_type size() const { return data->size(); }
    bool empty() const { return data->empty(); }
    void push_back(const T& ele){ data->push_back(ele);}
    void push_back(T&& ele){ data->push_back(ele);}
    void pop_back();
    T& back();
    T& operator[](size_type i);
    Blob getBlob(){
        return Blob();
    }
};
template<typename T>
T& Blob<T>::back(){
    return data->back();
}
template<typename T>
T& Blob<T>::operator[](size_type i){
    return (*data)[i];
}
template<typename T>
void Blob<T>::pop_back(){ data->pop_back(); }



int main(){

    Blob<string> articles = {"a","an","the"};



    return 0;
}