#include <iostream>
#include <chrono>
#include <iostream>
#include <vector>
#include <stdio.h>
#include <unordered_map>
using namespace std;

class A {
public:
A(){};
A(const std::vector<int>& v) : _v(v) {}
~A() {std::cout<<"dealloc"<<std::endl;}
A(A&&) = default;
A& operator=(A&&)=default;
std::vector<int>& v() {
  return _v;
}
private:
std::vector<int> _v;
};
void compute(A&& a) {

}

struct SomeObj {
  private:
  std::string _str{""};
  public:
    SomeObj(){
      _str = "default";
      std::cout<<"default construct"<<std::endl;
    }
    SomeObj(std::string str):_str(str){
      std::cout<<"string construct"<<std::endl;
    };
    SomeObj(const SomeObj& so){
      std::cout<<"copy construct"<<std::endl;
      _str = so._str;
    }
    SomeObj(SomeObj&& so){
      std::cout<<"move construct"<<std::endl;
      _str = so._str;
    }
    auto& operator=(const SomeObj& other){
      std::cout<<"copy assignment"<<std::endl;
      _str = other._str;
      return *this;
    }
     auto& operator=(SomeObj&& other){
      _str = other._str;
      std::cout<<"move assignment"<<std::endl;
      return *this;
    }
    std::string get_str() const{
      return _str;
    }
};

class Screen {
    public:
        typedef std::string::size_type pos;
        Screen(std::string contents): contents(contents){}
        char get_cursor() const { return contents[cursor]; }
        char get() const;
        char get(pos ht, pos wd) const;
      static const std::string Screen::*data() {
        return  &Screen::contents;
    }
  const SomeObj& get_obj() const& {
    return obj;
  }
  SomeObj get_obj() && {
    return std::move(obj);
  }
private:
       SomeObj obj {"From Screen"};
        std::string contents;
        pos cursor;
        pos height, width;
    friend class Screen;
};

int main(){
    // const string Screen ::*pData =  Screen::data();
    // Screen myScreen("pytorch");
    // Screen* pScreen = &myScreen;
    // auto s = myScreen.*pData;
    // std::cout<<s<<std::endl;

    Screen myScreen("pytorch");
    Screen& ms = myScreen;
    const auto& obj = ms.get_obj();
    std::cout<<obj.get_str()<<std::endl;
    

  
    return 0;
}