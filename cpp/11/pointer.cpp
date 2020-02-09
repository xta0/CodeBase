#include <iostream>
#include <vector>
#include <string>
#include <map>
#include <set>
#include <unordered_map>
#include <memory>
using namespace std;

typedef struct {
    int x;
    string name;
    void* data;
} Tensor;

int main(){
    std::shared_ptr<int> pt;
    if(!pt){
        cout<<"ptr is nil"<<endl;
    }
    int* buffer = (int* )malloc(4*sizeof(int));
    cout<<"ori: "<<buffer<<endl;
    Tensor tensor = {
        .x = 11,
        .name = "tensor",
        .data = buffer
    };
    shared_ptr<Tensor> pt1 = make_shared<Tensor>(tensor);
    cout<<"pt1: "<<pt1->data<<endl;
    cout<<"count: "<<pt1.use_count()<<endl;

    // auto pt2 = pt1;
    // cout<<"pt1: "<<pt2->data<<endl;
    // cout<<"pt1 count: "<<pt1.use_count()<<endl;
    // cout<<"pt2 count: "<<pt2.use_count()<<endl;

    auto pt2(std::move(pt1));
    cout<<"pt1: "<<pt2->data<<endl;
    cout<<"pt1 count: "<<pt1.use_count()<<endl;
    cout<<"pt2 count: "<<pt2.use_count()<<endl;


    return 0;
}