#include "ExampleLib.h"

example::data_source::data_source(){}
example::data_source::~data_source(){}


void example::data_source::add(string str){
    data.push_back(str);
}
size_t example::data_source::size() const{
    return data.size();
}
std::string example::data_source::get(size_t index){
    return data[index];
}
