#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PhotoStore : NSObject

- (NSString* )load:(nonnull NSString* )photoId;
- (void)save:(NSString* )photoId path:(NSString* )path;
- (void)dump;

@end

NS_ASSUME_NONNULL_END