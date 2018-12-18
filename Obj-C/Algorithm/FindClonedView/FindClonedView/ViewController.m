//
//  ViewController.m
//  FindClonedView
//
//  Created by moxin on 12/17/18.
//  Copyright © 2018 Tao Xu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

/*
          *
        /   \
       *     *
     /   \    \
    *     *    *
   /  \   /
  *    * start
          \
 
        root
       /   \
      *     *
    /   \    \
   *     *    *
  /  \   /
 *    *  ?
          \

*/
- (UIView* )findClonedNode:(UIView* )start fromRoot:(UIView* )root{
    if(!start || !root){
        return nil;
    }
    
    NSMutableArray<NSNumber* >* path = [NSMutableArray<NSNumber* > new];
    //1st : path = [1]
    //2nd : path = [2]
    //3rd: path = [1]
    while(start){
        int index = (int)[start.superview.subviews indexOfObject:start];
        [path addObject:@(index)];
        start = start.superview;
    }
 
    UIView* res = root;
    //path : [1,2,1]
    // 1st : index = path[2] = 1  res = v1
    // 2nd : index = path[1] = 2  res = v2
    // 3rd : index = path[0] = 1  res = v3
    int count = (int)path.count; //3
    while( count > 0){
        int index = (int)path[count-1];
        res = res.subviews[index];
        count --;
    }
    
    return res;
}


@end
