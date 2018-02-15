#include <vector>
#include <iostream>
using namespace std;

int main(){
    vector<double> numbers(0);
    cout<<"size: "<<numbers.size()<<endl; //20
    decltype(numbers.size()) cp = numbers.capacity();
    cout<<"capacity: "<<cp<<endl;//20

    for(int i=0;i<1000;++i){
        if(cp != numbers.capacity()){
            cout<<"index: "<<i<<endl;
            cp = numbers.capacity();
            cout<<"capacity: "<<cp<<endl;
        }
        numbers.push_back(i);
    }

    return 0;
}