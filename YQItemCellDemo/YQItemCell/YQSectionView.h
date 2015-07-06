//
//  YQSectionView.h
//  YQItemCellDemo
//
//  Created by Wang on 15/7/6.
//  Copyright (c) 2015年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YQSectionView : UIView
- (instancetype)initWithFrame:(CGRect)frame itemCount:(NSInteger)count;

@property (nonatomic, assign) IBInspectable  NSInteger itemCount;
@property (nonatomic, assign) UIEdgeInsets separatorInset;

- (CGFloat)originYAtIndex:(NSInteger)index;
@end
