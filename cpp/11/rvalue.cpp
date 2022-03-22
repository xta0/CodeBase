#include <iostream>
#include <vector>
#include <string>
using namespace std;

class Dummy{
public: 
    string x = "Dummy";
    Dummy(string i):x(i){
        cout<<"Constructor"<<endl;
    }
    Dummy(const Dummy& d):x(d.x){
        cout<<"Copy Contructor"<<endl;
    }
    Dummy(Dummy&& d) noexcept :x(std::move(d.x)) {
        cout<<"Move Contructor"<<endl;
    }
    Dummy& operator=(const Dummy& d) &{
        cout<<"Assign Operator"<<endl;
        x = d.x;
        return *this;
    }
    Dummy& operator=(const Dummy&& d) noexcept {
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
        return Dummy("1");
    }
    static Dummy& retRef(){
        static Dummy d("1");
        return d;
    }
    static Dummy retVal(){
        return Dummy("1");
    }
};

Dummy&& getDummy(){
    return std::move(Dummy("99"));
    // return Dummy("99");
}
Dummy&& getDummy (Dummy&& dm){
    return std::move(dm);
}

Dummy dummy() {
    std::cout<<__func__<<std::endl;
    Dummy x("12");
    return x;
}

void foo(Dummy&& dm){
    Dummy&& d = std::move(dm);
    d.x = "100";
    // std::cout<<d.x<<std::endl;
    // Dummy d2 = getDummy();
    // std::cout<<d2.x<<std::endl;
}

int main(){
    std::cout<<"main start"<<std::endl;
    // Dummy dm = dummy();
    auto dm = Dummy("123");
    auto dm2 = Dummy(dm);
    auto dm3 = Dummy(std::move(dm));
    // foo(std::move(dm));
    // std::cout<<dm.x<<std::endl;
    std::cout<<"main end"<<std::endl;

    return 0;
}