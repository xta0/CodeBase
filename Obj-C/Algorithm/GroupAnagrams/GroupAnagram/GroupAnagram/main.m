//
//  main.m
//  GroupAnagram
//
//  Created by moxin on 12/16/18.
//  Copyright © 2018 Tao Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Anagram : NSObject

//leetcode - 49:  Group Anagrams
- (NSArray<NSArray<NSString* >*>*) groupAnagram:(NSArray<NSString* >*) strs;
@end

@implementation Anagram

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


@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Anagram* a = [Anagram new];
        NSArray<NSString* >* strs = @[@"eat", @"tea", @"tan", @"ate", @"nat", @"bat"];
        id ret = [a groupAnagram:strs];
        NSLog(@"%@",ret);
        
    }
    return 0;
}
