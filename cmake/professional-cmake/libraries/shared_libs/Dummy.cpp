#include "Torch.h"
#include <iostream>
#include <string>

using namespace std;
Torch::Torch(const std::string& str1, const string& str2){
    _str = str1+str2;
}
void Torch::foo(){
    cout<<_str<<endl;
};