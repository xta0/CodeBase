//
//  main.m
//  SortedArrayIterator
//
//  Created by moxin on 12/17/18.
//  Copyright © 2018 Tao Xu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MinHeap.h"


/*
 [
 [-3, 2, 4, 5, 10, 18],
   |
 [0, 1, 1, 2],
  |  |  |
 [-10, -5, 3, 4, 9, 20, 34],
   |    |
 [6, 8, 9]
 
 ]
 
 -10,-5,-3, 0, 1, 1,
 
 N*log(K)
 
 
 */
@interface SortedArrayIterator:NSObject

- (id)initWithArray:(NSArray<NSArray* >* )arr;
- (NSArray* )all;
- (NSInteger)next;

@end

@implementation SortedArrayIterator{
    NSArray<NSArray* >* _lists;
    NSMutableArray* _mergedArr;
    MinHeap* _minHeap;
    //track index
    NSMutableDictionary* _dict;
}

- (id)initWithArray:(NSArray<NSArray* >* )arr{
    self = [super init];
    if(self){
        _lists = [arr copy];
        _minHeap = [[MinHeap alloc]initWithCapacity:arr.count];
        _dict = [NSMutableDictionary new];
        
        //initialize minheap
        for(int i=0;i<arr.count;i++){
            int n = [arr[i][0] intValue];
            _dict[@(n)] = @(0);
            [_minHeap push:@(n)];
        }
    }
    return self;
}
- (NSArray* )all{
    return nil;
}
- (NSInteger)next{
    NSInteger res = [[_minHeap top] intValue];
    NSLog(@"%ld",res);
    [_minHeap pop];
    
    
    int arrIndex = [_dict[@(res)] intValue];
    [_dict removeObjectForKey:@(res)];
    NSArray* arr = _lists[arrIndex];
    int eleIndex = (int)[arr indexOfObject:@(res)];
    if(eleIndex+1 < arr.count){
        id nextN = arr[eleIndex+1];
        [_minHeap push:nextN];
        _dict[nextN] = @(arrIndex);
    }
        
    
    return res;
}

@end

int main(int argc, const char * argv[]) {
    
    NSArray<NSArray* >* matrix = @[
//                                   @[@(-3), @(2), @(4), @(5), @(10), @(18)],
                                   @[@(0), @(1), @(1), @(2)],
//                                   @[@(-10), @(-5), @(3), @(4), @(9), @(20), @(34)],
                                   @[@(6), @(8), @(9)]
                                   ];
    SortedArrayIterator* itor = [[SortedArrayIterator alloc]initWithArray:matrix];
    while([itor next] != -1){
        [itor next];
    }
    
    return 0;
}
