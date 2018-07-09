#include <iostream>
#include <vector>
#include <string>
using namespace std;

template
class
private
MinHeap
:
<class
{
T>
// 最小堆ADT定义 堆的类定义
T* heapArray; // 存放堆数据的数组
int CurrentSize; // 当前堆中元素数目
int MaxSize; // 堆所能容纳的最大元素数目
void BuildHeap(); // 建堆
public:
MinHeap(const int n)； // 构造函数,n为最大元素数目
virtual ~MinHeap(){delete []heapArray;}; // 析构函数
bool isLeaf(int pos) const; // 如果是叶结点，返回TRUE
int leftchild(int pos) const; // 返回左孩子位置
int rightchild(int pos) const; // 返回右孩子位置
int parent(int pos) const; // 返回父结点位置
bool Remove(int pos, T& node); // 删除给定下标的元素
bool Insert(const T& newNode)； // 向堆中插入新元素newNode
T& RemoveMin()； // 从堆顶删除最小值
void SiftUp(int position); // 从position向上开始调整，使序列成为堆
void SiftDown(int left)； // 筛选法函数，参数left表示开始处理的数组下标
｝

class MaxHeap{
private:
    vector<int> heapArray;
    int CurrentSize; // 当前堆中元素数目
    int MaxSize; // 堆所能容纳的最大元素数目
    void BuildHeap() // 建堆
public:
    MaxHeap(const int n){
        
    }
    

};

int main(){




    return 0;
}