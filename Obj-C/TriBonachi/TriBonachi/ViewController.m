//
//  ViewController.m
//  TriBonachi
//
//  Created by moxin on 12/11/18.
//  Copyright © 2018 Tao Xu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView* tableView;
@property(nonatomic,strong) NSMutableArray* numbers;
@end

@implementation ViewController

- (NSMutableArray* )numbers{
    if(!_numbers){
        _numbers = [NSMutableArray new];
    }
    return _numbers;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Tribonachi";
    // Do any additional setup after loading the view, typically from a nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)) style:UITableViewStylePlain
                      ];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:self.tableView];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self loadModel:10];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}

- (void)loadModel:(NSUInteger) n{
    
    [self.numbers addObjectsFromArray:@[@(0),@(1),@(1)]];
    for(int i=3;i<=n;i++){
        NSUInteger x = [self.numbers[i-1] integerValue];
        NSUInteger y = [self.numbers[i-2] integerValue];
        NSUInteger z = [self.numbers[i-3] integerValue];
        [self.numbers addObject:@(x+y+z)];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.numbers.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (UITableViewCell* )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* identifier = @"Tribonachi";
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    cell.textLabel.text = [self.numbers[indexPath.row] stringValue];;
    return cell;
}


@end
