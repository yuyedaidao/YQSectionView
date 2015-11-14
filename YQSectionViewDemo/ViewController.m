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
    YQSectionView *section = [[YQSectionView alloc] initWithItemCount:2 equalWidth:NO];
    [self.view addSubview:section];
    section.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    section.frame = CGRectMake(0, 10, 200, 500);
    [section manualConfigureItems];
    {
        YQItemCell *cell = [section cellAtIndex:0];
        UIView *redView = [[UIView alloc] init];
        redView.backgroundColor = [UIColor redColor];
        [cell addSubview:redView];
        
        redView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [cell addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[redView]-0-|" options:0 metrics:nil views:@{@"redView":redView}]];
        [cell addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[redView(44)]-0-|" options:0 metrics:nil views:@{@"redView":redView}]];
    }
    {
        YQItemCell *cell = [section cellAtIndex:1];
        UIView *redView = [[UIView alloc] init];
        redView.backgroundColor = [UIColor blueColor];
        [cell addSubview:redView];
        
        redView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [cell addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[redView]-0-|" options:0 metrics:nil views:@{@"redView":redView}]];
        [cell addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[redView]-0-|" options:0 metrics:nil views:@{@"redView":redView}]];
    }
    
    
}
- (IBAction)clickAction:(YQItemCell *)sender {
    NSLog(@"点我做甚");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
