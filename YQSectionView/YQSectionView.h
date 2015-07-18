//
//  YQSectionView.h
//  YQItemCellDemo
//
//  Created by Wang on 15/7/6.
//  Copyright (c) 2015年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQItemCell.h"

@interface YQSectionView : UIView
- (instancetype)initWithItemCount:(NSInteger)count;

@property (nonatomic, assign) UIEdgeInsets separatorInset;
- (YQItemCell *)cellAtIndex:(NSInteger)index;
@property (nonatomic,copy) void (^didClickBlock)(NSInteger index);
@end
