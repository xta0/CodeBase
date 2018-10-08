//
//  main.m
//  ObjCpp
//
//  Created by moxin on 10/7/18.
//  Copyright © 2018 Tao Xu. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <memory>

@interface SomeObject:NSObject
@end
@implementation SomeObject

- (void)dealloc{
    NSLog(@"%s",__func__);
}

@end

class Object{

    
public:
    void hello(){
        NSLog(@"Hello!");
    }
    virtual void aFunc(){ NSLog(@"Base Called!"); }
    ~Object(){
        NSLog(@"%s",__func__);
    }
};
class Child:public Object{
private:
    SomeObject* objcPtr;
public:
    Child():objcPtr([SomeObject new]){}
    void aFunc() override{
        NSLog(@"Child Called!");
    }
};

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        std::unique_ptr<Child> pChild(new Child());
//        Child* pChild = new Child();
        pChild->aFunc();
//        delete pChild;
        
    }
    return 0;
}
