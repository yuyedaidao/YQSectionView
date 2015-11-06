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
- (instancetype)initWithItemCount:(NSInteger)count equalWidth:(BOOL)equalWidth;

@property (nonatomic, assign) IBInspectable NSInteger itemCount;
@property (nonatomic, assign) IBInspectable BOOL equalWidth;
@property (nonatomic, assign) UIEdgeInsets separatorInset;
- (YQItemCell *)cellAtIndex:(NSInteger)index;
@property (nonatomic,copy) void (^didClickBlock)(NSInteger index);
- (void)manualConfigureItems;
@end
