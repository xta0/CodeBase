#import <Foundation/Foundation.h>

@interface MyLoggerInternal: NSObject

- (instancetype)init NS_DESIGNATED_INITIALIZER;
- (void)log:(NSString* )message;

@end;