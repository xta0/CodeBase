//
//  main.m
//  CloneGraph
//
//  Created by moxin on 1/1/19.
//  Copyright © 2019 Tao Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GraphNode : NSObject<NSCopying>

@property(nonatomic,strong) NSNumber* val;
@property(nonatomic,strong) NSMutableArray<GraphNode* >* children;

+ (GraphNode* )cloneGraph:(GraphNode* )node;

@end


@implementation GraphNode

- (id)init{
    self = [super init];
    if(self){
        _children = [NSMutableArray new];
    }
    return self;
}
- (id)copyWithZone:(NSZone *)zone{
    return self;
}

+ (GraphNode* )clone:(GraphNode* )root withMemo:(NSMutableDictionary* )memo{
    if(!root){
        return nil;
    }
    if(memo[root]){
        return memo[root];
    }
    
    GraphNode* node = [GraphNode new];
    memo[root] = node;
    for(GraphNode* child in node.children){
        [node.children addObject:[self clone:child withMemo:memo]];
    }
    return node;
}

+ (GraphNode* )cloneGraph:(GraphNode* )node{
    NSMutableDictionary* memo = [NSMutableDictionary new];
    return [self clone:node withMemo:memo];
}


@end



int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
