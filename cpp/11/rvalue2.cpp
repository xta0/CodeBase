#include <iostream>
#include <vector>
#include <string>
#include <map>
#include <set>
#include <unordered_map>
using namespace std;

struct S1 {
    std::vector<float> _data;
    S1 (const std::vector<float>& data):_data(data){}
    S1( S1&& other) noexcept 
        : _data(std::move(other._data)){
        other._data = {};
    }
    void print() {
      for(auto& i : _data){
        std::cout<<i<<std::endl;
      }
      std::cout<<"--------"<<std::endl;
    }
};

struct S2 {
    std::vector<float> _data;
    S2 (const std::vector<float>& data):_data(data){}
    //a more elegant way is using std::exchange
    S2(S2&& other) noexcept
        : _data(std::exchange(other._data, {}))
    {}
    void print() {
      for(auto& i : _data){
        std::cout<<i<<std::endl;
      }
      std::cout<<"--------"<<std::endl;
    }
};

struct S3 {
    std::vector<float> _data;
    S3 (const std::vector<float>& data):_data(data){}
    //a more elegant way is using std::exchange
    S3(S3&& other)  {
      new (&_data) std::vector<float>(std::move(other._data));
    }
    void print() {
      for(auto& i : _data){
        std::cout<<i<<std::endl;
      }
      std::cout<<"--------"<<std::endl;
    }
};


struct S4 {
    std::vector<float> _data;
    int _index{-1};
    S4 (const std::vector<float>& data):_data(data){}
    void set_index(int index) {
      _index = index;
    }
    float select_item() const {
      return _data[_index];
    }
};


int main(){
  std::vector<float> data{1.0, 2.0, 3.0};
  // S1 s1(data);
  // s1.print();
  // S1 s11(std::move(s1));
  // s11.print();
  // s1.print();

  // S2 s2(data);
  // s2.print();
  // S2 s22(std::move(s2));
  // s22.print();
  // s2.print();

//  S3 s3(data);
//   s3.print();
//   S3 s33(std::move(s3));
//   s33.print();
//   s3.print();  
  S4 s4(data);
  s4.set_index(2);
  S4 s44(std::move(s4));
  auto selected = s4.select_item();
  std::cout<<selected<<std::endl;
  return 0;
}
