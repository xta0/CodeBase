//
//  Heap.h
//  SortedArrayIterator
//
//  Created by moxin on 12/18/18.
//  Copyright © 2018 Tao Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MinHeap : NSObject

- (id)initWithCapacity:(NSInteger) sz;
- (id)initWithArray:(NSArray* )arr Capacity:(NSInteger)cp;
- (void)push:(NSNumber* )num;
- (void)pop;
- (NSNumber* )top;
- (NSInteger)count;
- (NSInteger)capacity;

@end

NS_ASSUME_NONNULL_END
