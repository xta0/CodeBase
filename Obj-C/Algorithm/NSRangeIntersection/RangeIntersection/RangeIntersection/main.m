//
//  main.m
//  RangeIntersection
//
//  Created by moxin on 12/16/18.
//  Copyright © 2018 Tao Xu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSRangeIntersection : NSObject
- (NSRange) intersectionRangeBetween:(NSRange) range1 and:(NSRange) range2;
- (bool) intersectionBetween:(NSRange) range1 and:(NSRange) range2;
@end

@implementation NSRangeIntersection
- (NSRange) intersectionRangeBetween:(NSRange) range1 and:(NSRange) range2{
    if(NSMaxRange(range1) < range2.location || NSMaxRange(range2)<range1.location){
        return NSMakeRange(0, 0 );
    }
    NSRange range;
    range.location = MAX(range1.location, range2.location);
    range.length = MIN(NSMaxRange(range1),NSMaxRange(range2)) - range.location;
    return range;
}
- (bool) intersectionBetween:(NSRange) range1 and:(NSRange) range2{
    return !(NSMaxRange(range1) < range2.location || NSMaxRange(range2)<range1.location);
}
@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSRangeIntersection* ni = [NSRangeIntersection new];
        NSLog(@"%d", [ni intersectionBetween: NSMakeRange(0, 2) and:NSMakeRange(1,1)]);
        NSLog(@"%d", [ni intersectionBetween: NSMakeRange(0, 2) and:NSMakeRange(2,2)]);
    }
    return 0;
}
