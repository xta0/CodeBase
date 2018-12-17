//
//  main.m
//  MoveZeros
//
//  Created by moxin on 12/16/18.
//  Copyright © 2018 Tao Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoveZeros : NSObject
- (NSArray<NSNumber* >* )moveZeros:(NSArray<NSNumber* >* )arr;
@end

@implementation MoveZeros

/*
 1. 读写指针
 2. 读指针遇到0前进，写指针需要0停止
 3. 当读指针和写指针值不同时，更新写指针的值为读指针
 */
- (NSArray<NSNumber* >* )moveZeros:(NSArray<NSNumber* >* )arr{
    
    NSMutableArray* nums = [arr mutableCopy];
    int write = 0;
    int read = 0;
    while(read < nums.count){
        if([nums[read] intValue] == 0){
            read ++;
            continue;
        }
        if( nums[write] != nums[read]){
            nums[write] = nums[read];
        }
        write++;
        read++;
    }
    while(write < nums.count){
        nums[write] = @(0);
        write++;
    }
    return [nums copy];
}

@end


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        MoveZeros* mv = [MoveZeros new];
        NSArray* arr = @[ @(3), @(0), @(2), @(0), @(0), @(4), @(1), @(0) ];
        NSLog(@"%@",[mv moveZeros:arr]);
        
    }
    return 0;
}
