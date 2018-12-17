//
//  main.m
//  Algorithm
//
//  Created by moxin on 12/16/18.
//  Copyright © 2018 Tao Xu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <string>

@interface Algorithms : NSObject

//leetcode - 49: Group Anagrams
- (NSArray<NSArray<NSString* >*>*) groupAnagram:(NSArray<NSString* >*) strs;
//leetcode - 26: Remove Duplicates
- (NSArray<NSNumber* >*)removeDuplicates:(NSArray<NSNumber* >* )arr;
//move zeors
- (NSArray<NSNumber* >* )moveZeros:(NSArray<NSNumber* >* )arr;
@end

@implementation Algorithms

//[str] -> [ [eat,ate,tea],[app, pap],[xz, zx] ]
- (NSArray<NSArray<NSString* >*>*) groupAnagram:(NSArray<NSString* >*) strs{
    //result
    NSMutableDictionary<NSString*, NSMutableArray<NSString* >*>* res = [NSMutableDictionary<NSString*, NSMutableArray<NSString* >*> new];

    //sort lamda
    NSString* (^sortCharacters)(NSString*) = ^(NSString* str){
        NSMutableArray* list = [NSMutableArray arrayWithCapacity:str.length];
        for(int i=0;i<str.length;i++){
            [list addObject:[str substringWithRange:NSMakeRange(i, 1)]];
        }
        [list sortUsingComparator:^NSComparisonResult(NSString*  _Nonnull obj1, NSString*  _Nonnull obj2) {
            if ([obj1 characterAtIndex:0] < [obj2 characterAtIndex:0]){
                return NSOrderedAscending;
            }else{
                return NSOrderedDescending;
            }
        }];
        return [list componentsJoinedByString:@""];
        
    };
    
    
    for(NSString* str in strs){
        //sort characters in string, using Objective-C++
//        std::string cstr = [str UTF8String];
//        std::sort(cstr.begin(), cstr.end());
//        NSString* sortedString = [[NSString alloc]initWithUTF8String:cstr.c_str()];
        NSString* sortedString = sortCharacters(str);
        NSMutableArray<NSString* >* list = res[sortedString];
        if(!list){
            list = [ NSMutableArray<NSString* > new];
        }
        [list addObject:str];
        res[sortedString] = list;
    }
    
    return [ [res allValues] copy];
}

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

@interface TestCases : NSObject
@property(nonatomic,strong) Algorithms* algo;
- (void)testGourpAnagrams;
@end

@implementation TestCases
- (id)init{
    self = [super init];
    if(self){
        _algo = [Algorithms new];
    }
    return self;
}
- (void)testGourpAnagrams{
    NSArray<NSString* >* strs = @[@"eat", @"tea", @"tan", @"ate", @"nat", @"bat"];
    id ret = [self.algo groupAnagram:strs];
    NSLog(@"%@",ret);
}
- (void)testRemoveDuplicated{
    NSArray<NSNumber* >* arr = @[@(2), @(1),@(1), @(3), @(1), @(3),@(2)];
    NSLog(@"%@", [self.algo removeDuplicates:arr]);
}
- (void)testRemoveZeros{
    NSArray* arr = @[ @(3), @(0), @(2), @(0), @(0), @(4), @(1), @(0) ];
    NSLog(@"%@",[self.algo moveZeros:arr]);
}
@end



int main(int argc, const char * argv[]) {
    @autoreleasepool {
        TestCases* tcs = [TestCases new];
//        [tcs testGourpAnagrams];
//        [tcs testRemoveDuplicated];
        [tcs testRemoveZeros];
        
    }
    return 0;
}
