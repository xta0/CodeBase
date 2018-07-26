
#import "ExampleLibWrapper.h"
#include "ExampleLib.h"


@interface ExampleLibWrapper(){
    std::unique_ptr<example::data_source> _dataSource;
}
@end


@implementation ExampleLibWrapper

- (instancetype)init{
    self = [super init];
    if(self){
        _dataSource = std::unique_ptr<example::data_source>(new example::data_source());
    }
    return self;
}
- (void)dealloc{
    _dataSource.reset();
}
- (void)append:(NSString *)element{
    _dataSource->add(element.UTF8String);
}
- (NSUInteger)count{
    return _dataSource->size();
}
- (NSString* )objectAtIndex:(NSUInteger)index{
    return [[NSString alloc]initWithUTF8String:_dataSource->get(index).c_str()];
}

@end
