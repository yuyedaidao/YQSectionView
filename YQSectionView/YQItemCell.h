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
- (instancetype)initWithIndex:(NSInteger)index type:(YQItemCellType)type;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) UIEdgeInsets separatorInset;
@end
