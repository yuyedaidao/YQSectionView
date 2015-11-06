//
//  ViewController.m
//  YQItemCellDemo
//
//  Created by Wang on 15/7/6.
//  Copyright (c) 2015年 Wang. All rights reserved.
//

#import "ViewController.h"
#import "YQSectionView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    YQSectionView *section = [[YQSectionView alloc] initWithItemCount:10];
    [self.view addSubview:section];
    section.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    section.frame = CGRectMake(0, 0, 200, 500);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
