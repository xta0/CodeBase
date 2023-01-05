#import "PhotoStore.h"

@implementation PhotoStore{
    NSMutableDictionary<NSString*, NSString*>* _store;
}

- (instancetype)init {
    self = [super init];
    if(self){
        _store = [NSMutableDictionary new];
    }
    return self;
}
- (NSString* )load:(NSString* )photoId {
    return _store[photoId];
}
- (void)save:(NSString* )photoId path:(NSString* )path {
    _store[photoId] = path;
}

- (void)dump{
    NSLog(@"[Photos]: %@", _store);
}

@end
