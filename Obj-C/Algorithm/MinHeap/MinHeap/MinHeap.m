//
//  Heap.m
//  SortedArrayIterator
//
//  Created by moxin on 12/18/18.
//  Copyright © 2018 Tao Xu. All rights reserved.
//

#import "MinHeap.h"

@implementation MinHeap{
    NSMutableArray* _arr;
    NSInteger _sz;
}

- (id)initWithCapacity:(NSInteger) sz{
    self = [super init];
    if(self){
        _arr = [[NSMutableArray alloc]initWithCapacity:sz];
        _sz = sz;
    }
    return self;
}

- (id)initWithArray:(NSArray* )arr Capacity:(NSInteger)cp{
    self = [super init];
    if(self){
        _arr = [[NSMutableArray alloc]initWithArray:arr];
        _sz = cp;
        [self makeHeap];
    }
    return self;
}

- (void)push:(NSNumber* )num{
    if(_arr.count == _sz){
        return;
    }
    [_arr addObject:num];
    [self siftUp:_arr.count-1];
}
- (void)pop{
    if(_arr.count == 0){
        return;
    }
    [self swap:0 and:_arr.count-1];
    [_arr removeLastObject];
    [self siftDown:0];
}
- (NSNumber* )top{
    return [_arr firstObject];
}

- (NSInteger)count{
    return _arr.count;
}

- (NSInteger)capacity{
    return _sz;
}
- (NSString* )description{
    return [NSString stringWithFormat:@"%@",_arr];
}

#pragma mark - private

- (void)makeHeap{
    for(NSInteger i=_arr.count/2+1; i>=0; i--){
        [self siftDown:i];
    }
}

- (void)siftDown:(NSInteger) pos{
    NSInteger l = [self left_child_index:pos];
    NSInteger r = [self right_child_index:pos];
    //leaf child
    if(l == -1){
        return ;
    }
    //has only left child
    if(r == -1){
        if([_arr[pos] intValue] > [_arr[l] intValue] ){
            [self swap:pos and:l];
            [self siftDown:l];
        }
        return;
    }
    //has left & right child
    NSInteger index = [_arr[l] intValue] < [_arr[r] intValue] ? l:r;
    if([_arr[pos] intValue] > [_arr[index] intValue]){
        [self swap:pos and:index];
        [self siftDown:index];
    }
}

- (void)siftUp:(NSInteger)pos{
    if(pos == 0){
        return;
    }
    NSInteger parentIndex = [self parent_index:pos];
    if([_arr[parentIndex] intValue] > [_arr[pos] intValue]){
        [self swap:parentIndex and:pos];
        [self siftUp:parentIndex];
    }
    
    
}

- (NSInteger)left_child_index:(NSInteger)pos{
    NSInteger index = pos*2+1;
    return index >= _arr.count?-1:index;
}

- (NSInteger)right_child_index:(NSInteger)pos{
    NSInteger index  = pos*2+2;
    return index >= _arr.count? -1:index;
}
- (NSInteger)parent_index:(NSInteger)pos{
    return (pos-1)/2;
}
- (void)swap:(NSInteger)i and:(NSInteger)j{
    id tmp = _arr[i];
    _arr[i] = _arr[j];
    _arr[j] = tmp;
}

@end
