//
//  ViewController.m
//  Runtime
//
//  Created by moxin on 10/3/18.
//  Copyright © 2018 Tao Xu. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#include <vector>

@interface Object : NSObject
@end
@implementation Object
- (void)dealloc{
    NSLog(@"Object has been dealloced!");
}
@end

class CPPObject{
public:
    ~CPPObject(){
        NSLog(@"CPP Object has been deallocd!");
    }
    
};


@interface ViewController ()
{
    std::vector<Object* > _vec1;
    std::vector<CPPObject> _vec2;
}
@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Object* obj = [Object new];
    _vec1 = {};
    _vec1.push_back(obj);
    
    
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    _vec1.clear();
}


@end
