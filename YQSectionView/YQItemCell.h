//
//  YQItemCell.h
//  YQSectionViewDemo
//
//  Created by Wang on 15/7/7.
//  Copyright (c) 2015年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YQItemCellType) {
    YQItemCellTypeNormal,
    YQItemCellTypeFirst,
    YQItemCellTypeLast,
    YQItemCellTypeMiddle,
};

@interface YQItemCell : UIControl
- (instancetype)initWithIndex:(NSInteger)index type:(YQItemCellType)type separatorInset:(UIEdgeInsets)separatorInset isOnly:(BOOL)only;
- (instancetype)initWithIndex:(NSInteger)index type:(YQItemCellType)type separatorInset:(UIEdgeInsets)separatorInset;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, copy) void (^clickedBlock)(id sender);

@property (nonatomic, assign) UIEdgeInsets separatorInset;
@property (nonatomic, assign) YQItemCellType type;

#pragma mark 用于nib
/**
 *  是否显示箭头
 */
@property (nonatomic, assign) IBInspectable BOOL accessory;
@property (nonatomic, strong) IBInspectable UIColor *lineColor;
@property (nonatomic, assign) IBInspectable BOOL topLine;
@property (nonatomic, assign) IBInspectable BOOL bottomLine;
@property (nonatomic, assign) IBInspectable CGFloat topLeftPadding;
@property (nonatomic, assign) IBInspectable CGFloat bottomLeftPadding;

@end
