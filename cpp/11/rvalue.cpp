#include <iostream>
#include <vector>
#include <string>
using namespace std;

class Dummy{
public: 
    int x = 100;
    Dummy(int i):x(i){
        cout<<"Constructor"<<endl;
    }
    Dummy(const Dummy& d):x(d.x){
        cout<<"Copy Contructor"<<endl;
    }
    Dummy& operator=(const Dummy& d) &{
        cout<<"Assign Operator"<<endl;
        x = d.x;
        return *this;
    }
    Dummy& operator=(const Dummy&& d){
        cout<<"Assign rvalue Operator"<<endl;
        x = d.x;
        return *this;
    }
    ~Dummy(){
        cout<<__func__<<endl;
    }
    Dummy func() &&{
        return *this;
    }
    Dummy func() const &{
        return Dummy(99);
    }
    static Dummy& retRef(){
        static Dummy d(19);
        return d;
    }
    static Dummy retVal(){
        return Dummy(10);
    }
};

Dummy getDummy (){
    return Dummy(99);
}
int main(){
    Dummy&& x = getDummy();
    std::cout<<"main"<<std::endl;

    return 0;
}