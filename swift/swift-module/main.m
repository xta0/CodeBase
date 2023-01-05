#import <Foundation/Foundation.h>
#import "headers/Logger-Swift.h"
#import "PhotoStore.h"

int main (int argc, const char * argv[])
{
  @autoreleasepool {
    Logger* logger = [[Logger alloc]initWithPrefix: @"main.m"];
    [logger logStringWithObject: @"main called!"];
    PhotoStore* store = [PhotoStore sharedInstance];
    [store save:@"1" path:@"/tmp/"];
  }
  return 0;
}
