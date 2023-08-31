#import "MyLoggerInternal.h"

@implementation MyLoggerInternal

- (instancetype)init {
    self = [super init];
    if (self) {
        // Additional initialization code, if needed
    }
    return self;
}

- (void)log:(NSString* )message {
    NSLog(@"%@", message);
}

@end
