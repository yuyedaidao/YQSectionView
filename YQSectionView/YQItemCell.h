//
//  YQItemCell.h
//  YQSectionViewDemo
//
//  Created by Wang on 15/7/7.
//  Copyright (c) 2015年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YQItemCellType) {
    YQItemCellTypeFirst,
    YQItemCellTypeLast,
    YQItemCellTypeMiddle,
};

@interface YQItemCell : UIView
- (instancetype)initWithIndex:(NSInteger)index type:(YQItemCellType)type separatorInset:(UIEdgeInsets)separatorInset isOnly:(BOOL)only;
- (instancetype)initWithIndex:(NSInteger)index type:(YQItemCellType)type separatorInset:(UIEdgeInsets)separatorInset;
@property (nonatomic, assign) NSInteger index;

/**
 *  是否显示箭头
 */
@property (nonatomic, assign) BOOL accessory;
@end
