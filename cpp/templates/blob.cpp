#include <iostream>
#include <vector>
#include <string>
#include <memory>

using namespace std;

template <typename T>
class Blob
{
public:
    //类型成员
    typedef typename std::vector<T>::size_type size_type;
public:
    Blob() : data(std::make_shared<vector<T>>()) {}
    Blob(std::initializer_list<T> il) : data(std::make_shared<vector<T>>(il)) {}
    size_type size() const { return data->size(); }
    bool empty() const { return data->empty(); }
    void push_back(const T &ele) { data->push_back(ele); }
    void push_back(T &&ele) { data->push_back(ele); }
    void pop_back();
    T &back();
    T &operator[](size_type i);
    Blob getBlob()
    {
        return Blob();
    }

private:
    std::shared_ptr<vector<T>> data;
    void check(size_type i, const string &msg) const;
};
template <typename T>
T &Blob<T>::back()
{
    return data->back();
}
template <typename T>
T &Blob<T>::operator[](size_type i)
{
    return (*data)[i];
}
template <typename T>
void Blob<T>::pop_back() { data->pop_back(); }

template <typename T>
void Blob<T>::check(size_type i, const string &msg) const
{
    if (i >= data->size())
    {
        return;
    }
}
int main()
{

    Blob<string> articles = {"a", "an", "the"};
    Blob<int> squares = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
    for (size_t i = 0; i != articles.size(); ++i)
    {
        cout << articles[i] << endl; //实例化 Blob<int>::operator[](size_t)
    }
    Blob<int>::size_type size = squares.size();


    return 0;
}