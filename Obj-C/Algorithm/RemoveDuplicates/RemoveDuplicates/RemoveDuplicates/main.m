//
//  main.m
//  RemoveDuplicates
//
//  Created by moxin on 12/16/18.
//  Copyright © 2018 Tao Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RemoveDuplicates:NSObject

- (NSArray<NSNumber* >* )removeDuplicates:(NSArray<NSNumber* >* )arr;

@end

@implementation RemoveDuplicates

/*
 解法一：O(1)空间，输出顺序会改变
 解法二: O(N)空间， 输出顺序不变
 */

- (NSArray<NSNumber* >* )removeDuplicates:(NSArray<NSNumber* >* )arr{
#ifdef RD1
    if(arr.count <= 1){
        return arr;
    }
    NSMutableArray<NSNumber* >*nums = [arr mutableCopy];
    int write = 1;
    int read = 1;
    while(read < nums.count){
        if([nums[read] intValue] != [nums[write] intValue]){
            nums[write++] = nums[read];
        }
        read++;
    }
    
    return [nums subarrayWithRange:NSMakeRange(0, write-1)];
#endif
    NSMutableSet* sets = [NSMutableSet new];
    NSMutableArray* list = [NSMutableArray new];
    for(int i=0;i<arr.count;i++){
        NSNumber* n = arr[i];
        if([sets containsObject:n]){
            continue;
        }
        
        [sets addObject:n];
        [list addObject:n];
    }
    return [list copy];
}



@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        RemoveDuplicates* rd = [RemoveDuplicates new];
        NSArray<NSNumber* >* arr = @[@(2), @(1),@(1), @(3), @(1), @(3),@(2)];
        NSLog(@"%@", [rd removeDuplicates:arr]);
    
    }
    return 0;
}
