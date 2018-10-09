//
//  ViewController.m
//  GCD
//
//  Created by moxin on 10/9/18.
//  Copyright © 2018 Tao Xu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"From background Thread"); //this will also be enqueued in main runloop
                });
            });
        });
        [self sleep];
    });
}
- (void)sleep{
    //10s
    NSLog(@"before sleep");
    sleep(10);
    NSLog(@"After sleep");
}

- (IBAction)onBtnClicked:(id)sender {
    
    //this will enqueue the in main runloop
    NSLog(@"Clicked!");
}

@end
