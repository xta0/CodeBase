#include <iostream>
#include <vector>
#include <string>
#include <map>
using namespace std;

class KeyObject{
private:
    string name="";
    int age = 0;
public:
    KeyObject(const string& name, int age):name(name),age(age){}
    string get_name() const {
        return name;
    }
    int get_age() const{
        return age;
    }
    //重载<
    bool operator<( const KeyObject& rhs) const{
        return age < rhs.age;
    }

};

//全局重载<
// bool operator<(const KeyObject& lhs, const KeyObject& rhs) {
//     return lhs.get_age() < rhs.get_age();
// }

//使用Functor + 模板特例
// namespace std{
//     template<>
//     struct less<KeyObject>{
//         bool operator()(const KeyObject& lhs, const KeyObject& rhs) const{
//             return lhs.get_age() < rhs.get_age();
//         }
//     };
// };

class ValueObject{
private:
    string name;
public:
    ValueObject(const string& name):name(name){}
    ValueObject(const ValueObject& obj){
        name = obj.name;
    }
    string get_name() const {
        return name;
    }
};

int main(){
    
    
    std::map<KeyObject,int> m;
    KeyObject k1 = { "andy",30 };
    KeyObject k2 = { "Katie", 22};
    m[k1] = 10;
    m[k2] = 20;
    for (auto itor=m.begin(); itor!=m.end(); itor++){
        pair<KeyObject,int> p = *itor;
        cout<<"{"<<p.first.get_name()<<","<<p.second<<"}"<<endl;
    }

    std::map<KeyObject, ValueObject> m2;
    ValueObject v2 = {"Katie"};
    cout<<v2.get_name()<<endl;

    //type
    KeyObject k3 = {"Jason",33};
    m[k3] = 100;
    map<KeyObject,int>::mapped_type mt = m[k3];
    // map<KeyObject,int>::value_type vt = m[k3];
    cout<<mt<<endl;
    // cout<<vt<<endl;

    auto itor = m.begin();
    map<KeyObject,int> ::value_type p = *itor;
    cout<<p.first.get_name()<<endl;
    

    
    

    return 0;
}