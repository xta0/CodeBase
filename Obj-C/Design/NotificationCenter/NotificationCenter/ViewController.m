//
//  ViewController.m
//  NotificationCenter
//
//  Created by moxin on 12/12/18.
//  Copyright © 2018 Tao Xu. All rights reserved.
//

#import "ViewController.h"
#import "NotificationCenter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[NotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:@"1"];
    [[NotificationCenter defaultCenter] addObserver:self ForName:@"2" usingBlock:^(Notification * nf) {
       
        NSLog(@"Receive #2 with: %@",nf.userInfo);
        [[NotificationCenter defaultCenter] removeObserver:self name:@"2" object:nil];
        [[NotificationCenter defaultCenter] postNotificationName:@"1" object:nil userInfo:@{@"msg":@"#1 is still here"}];
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[NotificationCenter defaultCenter] postNotificationName:@"1" object:nil userInfo:@{@"msg":@"hello from #1"}];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[NotificationCenter defaultCenter] postNotificationName:@"2" object:nil userInfo:@{@"msg":@"hello from #2"}];
        });

    });
}

- (void)receiveNotification:(Notification* )nf{
    NSLog(@"Receive #1 with: %@",nf.userInfo);
}

@end
