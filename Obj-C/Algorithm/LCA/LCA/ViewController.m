//
//  ViewController.m
//  LCA
//
//  Created by moxin on 12/14/18.
//  Copyright © 2018 Tao Xu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    int w = CGRectGetWidth(self.view.bounds);
    int h = CGRectGetHeight(self.view.bounds)/2;

    // Do any additional setup after loading the view, typically from a nib.
    UIView* v1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, w, h)];
    v1.tag = 1;
    v1.backgroundColor = [UIColor redColor];
    [self.view addSubview:v1];
    
    UIView* v2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, w/2, h)];
    v2.tag = 2;
    v2.backgroundColor = [UIColor greenColor];
    [v1 addSubview:v2];
    
    UIView* v3 = [[UIView alloc]initWithFrame:CGRectMake(w/2, 0, w/2, h)];
    v3.tag = 3;
    v3.backgroundColor = [UIColor yellowColor];
    [v1 addSubview:v3];
    
    UIView* v4 = [[UIView alloc]initWithFrame:CGRectMake(0, h/2, w/4, h/2)];
    v4.tag = 4;
    v4.backgroundColor = [UIColor orangeColor];
    [v2 addSubview:v4];
    
    UIView* v5 = [[UIView alloc]initWithFrame:CGRectMake(w/4, h/2, w/4, h/2)];
    v5.tag = 5;
    v5.backgroundColor = [UIColor cyanColor];
    [v2 addSubview:v5];
    
    UIView* v7 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, w/8, h/4)];
    v7.tag = 7;
    v7.backgroundColor = [UIColor brownColor];
    [v5 addSubview:v7];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self findLCA:v3 and:v4];
    });
    
    
    
}
- (UIView* )findLCA:(UIView*) v1 and: (UIView*)v2{
    NSMutableSet<UIView* >* sets = [NSMutableSet<UIView* > new];
    while(v1){
        [sets addObject:v1];
        v1 = v1.superview;
    }
    //
    for(UIView* v in sets){
        NSLog(@"%@", [v class]);
    }
    while(v2){
        if([sets containsObject:v2]){
            NSLog(@"found LCA: <%@,%ld>",[v2 class], v2.tag);
            return v2;
        }
        v2 = v2.superview;
    }
    return nil;
}


@end
