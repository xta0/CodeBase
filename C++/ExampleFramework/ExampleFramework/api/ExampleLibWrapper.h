

#import <Foundation/Foundation.h>

@interface ExampleLibWrapper : NSObject

- (void) append:(NSString* )element;
- (NSUInteger)count;
- (NSString* )objectAtIndex:(NSUInteger)index;

@end

