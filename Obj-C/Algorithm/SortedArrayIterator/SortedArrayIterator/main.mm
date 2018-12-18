//
//  main.m
//  SortedArrayIterator
//
//  Created by moxin on 12/17/18.
//  Copyright © 2018 Tao Xu. All rights reserved.
//

#import <Foundation/Foundation.h>



/*
 
 [-3, 2, 4, 5, 10, 18],
 
 [0, 1, 1, 2],
 
 [-10, -5, 3, 4, 9, 20, 34],
 
 [6, 8, 9]
 
 ]
 
 N*log(K)
 
 
 */
@interface SortedArrayIterator:NSObject

- (id)initWithArray:(NSArray<NSArray* >* )arr;
- (NSArray* )all;
- (NSInteger)next;

@end

@implementation SortedArrayIterator{
    NSArray<NSArray* >* _lists;
}

- (id)initWithArray:(NSArray<NSArray* >* )arr{
    self = [super init];
    if(self){
        _lists = [arr copy];
    }
    return self;
}
- (NSArray* )all{
    return nil;
}
- (NSInteger)next{
    return 0;
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
