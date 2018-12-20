//
//  main.m
//  MergeSort
//
//  Created by moxin on 12/19/18.
//  Copyright © 2018 Tao Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MergeSort:NSObject
- (NSArray* )mergeTwoSortedArray:(NSArray* )arr1 and:(NSArray* )arr2;
- (NSArray* )mergeKSortedArray:(NSArray<NSArray* >*)arr;

@end

@implementation MergeSort


- (NSArray* )mergeTwoSortedArray:(NSArray* )arr1 and:(NSArray* )arr2{
    NSMutableArray* result = [NSMutableArray new];
    [self mergeTwoArrayRecursively:result Index1:0 Index2:0 Array1:arr1 Array2:arr2];
    return [result copy];
}

- (NSArray* )mergeKSortedArray:(NSArray<NSArray* >*)arr{
    NSMutableArray* result = [NSMutableArray new];
    [self mergetKArrayRecursively:result Array:@[] Inputs:arr Index:0];
    return result;
}


- (void)mergeTwoArrayRecursively:(NSMutableArray* )result Index1:(NSInteger)i Index2:(NSInteger)j Array1:(NSArray* )arr1 Array2:(NSArray* )arr2{
    if( i==arr1.count && j<arr2.count){
        NSInteger l2 = arr2.count - j ;
        [result addObjectsFromArray:[arr2 subarrayWithRange:NSMakeRange(j, l2)]];
    }else if( j==arr2.count && i<arr1.count){
        NSInteger l1 = arr1.count - i ;
        [result addObjectsFromArray:[arr1 subarrayWithRange:NSMakeRange(i, l1)]];
    }else{
        if([arr1[i] intValue] < [arr2[j] intValue]){
            [result addObject:arr1[i]];
            [self mergeTwoArrayRecursively:result Index1:i+1 Index2:j Array1:arr1 Array2:arr2];
        }else{
            [result addObject:arr2[j]];
            [self mergeTwoArrayRecursively:result Index1:i Index2:j+1 Array1:arr1 Array2:arr2];
        }
    }
}

- (void)mergetKArrayRecursively:(NSMutableArray* )result  Array:(NSArray* )arr Inputs:(NSArray<NSArray* >* )list Index:(NSInteger)index{
    if(index == list.count){
        [result addObjectsFromArray:arr];
        return;
    }
    NSArray* mergedArray = [self mergeTwoSortedArray:arr and:list[index]];
    [self mergetKArrayRecursively:result Array:mergedArray Inputs:list Index:index+1];
}

@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        MergeSort* ms = [MergeSort new];
        NSArray<NSArray* >* arrs = @[
                                       @[@(-3), @(2), @(4), @(5), @(10), @(18)],
                                       @[@(0), @(1), @(1), @(2)],
                                       @[@(-10), @(-5), @(3), @(4), @(9), @(20), @(34)],
                                       @[@(6), @(8), @(9)]
                                       ];
        NSArray* arr = [ms mergeKSortedArray:arrs];
        NSLog(@"%@",arr);
        
    }
    return 0;
}
