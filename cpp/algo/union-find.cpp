#include <iostream>
#include <vector>
using namespace std;

//树结点定义
template<class T>
class ParTreeNode {
public:
    T value; //结点的值
    ParTreeNode<T>* parent; //父结点指针
    int nCount; //集合中总结点个数
    ParTreeNode(T _value){
        value = _value;
        parent = nullptr;
        nCount = 1;
    }
    ~ParTreeNode(){
        cout<<endl<<"free node: "<<value;
    }
};

// 树定义
template<class T>
class ParTree {
public:
    vector<ParTreeNode<T>* > array;
    int Size; // 数组大小
    ParTree(const int size); // 构造函数
    virtual ~ParTree(); // 析构函数
    ParTreeNode<T>* Find(ParTreeNode<T>* node) const; // 查找node结点的根结点
    void Union(int i,int j); // 把下标为i，j的结点合并成一棵子树
    bool Different(int i,int j); // 判定下标为i，j的结点是否在一棵树中
};
template<class T>
ParTree<T>::ParTree(const int size){
    Size = size;
    for(int i=0;i<size;++i){
        ParTreeNode<T>* node = new ParTreeNode<int>(i);
        array.push_back(node);
    }
}
template<class T>
ParTree<T>::~ParTree<T>(){
    for(auto x : array){
        delete x;
        x = nullptr;
    }
    array.clear();
}
template <class T>
ParTreeNode<T>* ParTree<T>::Find(ParTreeNode<T>* node) const{
    ParTreeNode<T>* pointer=node;
    while ( pointer->parent != NULL )
        pointer = pointer->parent;
    return pointer;
}

template<class T>
void ParTree<T>::Union(int i, int j){
    ParTreeNode<T>* pointeri = Find(array[i]); //找到结点i的根
    ParTreeNode<T>* pointerj = Find(array[j]); //找到结点j的根
    if (pointeri != pointerj) {
        //检查个数
        if(pointeri -> nCount >= pointerj->nCount){
            pointerj->parent = pointeri;
            pointeri->nCount += pointerj->nCount;
            cout<<"node: "<<pointerj->value<<",parent: "<<pointeri->value<<endl;
        }else{
            pointeri->parent = pointerj;
            pointerj->nCount += pointeri->nCount;
            cout<<"node: "<<pointeri->value<<",parent: "<<pointerj->value<<endl;
        }
        
    }
}
template<class T>
bool ParTree<T>::Different(int i, int j){
    ParTreeNode<T>* pointeri = Find(array[i]); //找到结点i的根
    ParTreeNode<T>* pointerj = Find(array[j]); //找到结点j的根
    return pointeri == pointerj;
}


int main(){
    
    ParTree<int> tree(10);
    tree.Union(0, 9);
    tree.Union(4, 7);
    tree.Union(0, 4);
    tree.Union(6, 2);
    tree.Union(8, 3);
    tree.Union(5, 2);
    tree.Union(1, 3);
    tree.Union(6, 1);
    tree.Union(9, 5);
//----------------------------------
    
//     tree.Union(6, 8);
//     tree.Union(7, 6);
//     tree.Union(7, 4);
//     tree.Union(9, 0);
//     tree.Union(5, 8);
//     tree.Union(1, 6);
//     tree.Union(3, 9);
//     tree.Union(0, 2);
//     tree.Union(2, 7);
//   9 6 9 9 6 6 6 6 6 6
//----------------------------------
//     tree.Union(4, 0);
//     tree.Union(6, 2);
//     tree.Union(8, 4);
//     tree.Union(9, 4);
//     tree.Union(3, 5);
//     tree.Union(9, 5);
//     tree.Union(5, 2);
//     tree.Union(1, 2);
//     tree.Union(7, 1);
//     4 4 6 4 4 3 4 4 4 4
    
    cout<<"---"<<endl;
    for(int i =0; i<tree.array.size(); ++i){
        ParTreeNode<int>* node = tree.array[i];
        ParTreeNode<int>* parent = node->parent;
        int pvalue = node->value;
        if(parent){
            pvalue = parent->value;
        }
        cout<<pvalue<<" ";
//        cout<<"node: "<<node->value<<", parent: "<<pvalue<<endl;
    }


    
    
  
    
    
    return 0;
}
