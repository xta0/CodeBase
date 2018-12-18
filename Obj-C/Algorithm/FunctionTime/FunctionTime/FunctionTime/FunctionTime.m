//
//  FunctionTime.m
//  FunctionTime
//
//  Created by moxin on 12/16/18.
//  Copyright © 2018 Tao Xu. All rights reserved.
//

#import "FunctionTime.h"

@implementation FunctionTime

- (void)printFunctionTime:(NSArray<NSArray* >*) logs{
    NSMutableDictionary* dict =  [NSMutableDictionary new];
    for(NSArray* item in logs){
        NSString* name = item[0];
        NSNumber* timestamp = item[1];
        if(dict[name]){
             NSLog(@"%@: %d", name,[timestamp intValue] - [dict[name] intValue]);
            
        }
        dict[name] = timestamp;
    }
}

@end
