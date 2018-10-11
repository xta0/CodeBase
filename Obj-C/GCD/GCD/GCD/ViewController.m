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
    
    [self test_barrier];

}

- (void)test_barrier{
    dispatch_queue_t queue =
    dispatch_queue_create(NULL, DISPATCH_QUEUE_CONCURRENT);

    dispatch_async(queue,^{
        NSLog(@"thread 1 begin sleep");
        sleep(3);
        NSLog(@"thread 1 after sleep");
    });
    
    dispatch_async(queue,^{
        NSLog(@"thread 2 begin sleep");
//        sleep(3);
        NSLog(@"thread 2 after sleep");
    });
    
    //barrier提供了一个线程屏障
    //在barrier之前的任务必须执行完后才能执行barrier的任务
    //在barrier之后的任务必须等待barrier执行完成后才能继续执行
    dispatch_barrier_async(queue,^{
        NSLog(@"before barrier thread");
        sleep(5);
        NSLog(@"end barrier thread");
    
    
    });
    
    dispatch_async(queue,^{
        NSLog(@"thread 3 begin sleep");
        sleep(1);
        NSLog(@"thread 3 after sleep");
    });
    dispatch_async(queue,^{
        NSLog(@"thread 4 begin sleep");
        NSLog(@"thread 4 after sleep");
    });
}
- (void)test_event{
    // Do any additional setup after loading the view, typically from a nib.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"From background Thread"); //this will also be enqueued in main runloop
                });
            });
        });
        sleep(10);
    });
}

- (IBAction)onBtnClicked:(id)sender {
    
    //this will enqueue the in main runloop
    NSLog(@"Clicked!");
}

@end
