//
//  main.m
//  STL
//
//  Created by moxin on 16/1/24.
//  Copyright © 2016年 Vizlab. All rights reserved.
//


#include <vector>
#include <string>

using namespace std;

struct TestCase{
 
    TestCase(){}
    TestCase(const string _name):name(_name){}
    string name = "jayson";
};

namespace std
{
    
    template<>
    struct hash<TestCase>{
    
        size_t operator()(const TestCase &attr) const
        {
            return hash<std::string>()(attr.name);
        }
    };
    

}

int main(int argc, const char * argv[]) {
    
    vector<int> v = vector<int>();
    v.push_back(1);
    TestCase a("kate");
    hash<TestCase>h = hash<TestCase>();
    size_t hash = h(a);
    printf("hash:%ld",hash);

    return 0;
}
