//
//  main.m
//  FunctionTime
//
//  Created by moxin on 12/16/18.
//  Copyright © 2018 Tao Xu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FunctionTime.h"
#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>
using namespace std;
//cpp solution
void printFunctionTime(vector<pair<string,int>> log){
    unordered_map<string, int> um;
    for(auto &p:log){
        string name = p.first;
        int timestamp = p.second;
        //in cache
        if(um.count(name)){
            cout<<name<<": "<<timestamp-um[name]<<endl;
        }
        //update timestamp
        um[name] = timestamp;
        
    }
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        printFunctionTime({
            {"main",0},
            {"foo",10},
            {"foo",15},
            {"main",25},
        });
        
        FunctionTime* ft = [FunctionTime new];
        [ft printFunctionTime:@[@[@"main",@(0)],@[@"foo",@(10)],@[@"foo",@(15)],@[@"main",@(25)]]];
    }
    return 0;
}
