//
//  YQItemCell.m
//  YQSectionViewDemo
//
//  Created by Wang on 15/7/7.
//  Copyright (c) 2015年 Wang. All rights reserved.
//

#import "YQItemCell.h"
#import <UIKit/UIKit.h>
#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)
#define SINGLE_LINE_ADJUST_OFFSET   ((1 / [UIScreen mainScreen].scale) / 2)



static CGFloat AccessoryTrailing = 15;
static CGFloat AccessoryWidth = 6;
@interface YQItemCell ()
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) YQItemCellType type;
@property (nonatomic, assign,getter=isOnly) IBInspectable BOOL only;
@end

@implementation YQItemCell
- (instancetype)initWithIndex:(NSInteger)index type:(YQItemCellType)type separatorInset:(UIEdgeInsets)separatorInset{
    return [self initWithIndex:index type:type separatorInset:separatorInset isOnly:NO];
}
- (instancetype)initWithIndex:(NSInteger)index type:(YQItemCellType)type separatorInset:(UIEdgeInsets)separatorInset isOnly:(BOOL)only{
    if(self = [super init]){
        _index = index;
        _type = type;
        _lineWidth = SINGLE_LINE_WIDTH;
        _only = only;
        _separatorInset = separatorInset;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)awakeFromNib{
    self.type = YQItemCellTypeLast;
    self.index = 0;
    self.lineWidth = SINGLE_LINE_WIDTH;
    _separatorInset = UIEdgeInsetsZero;
    self.backgroundColor = [UIColor whiteColor];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    NSLog(@"draw %ld rect %@",self.index,NSStringFromCGRect(rect));
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    [[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1] setStroke];
    CGFloat left = 0;
    CGFloat right = 0;
    CGFloat top = 0;
    CGFloat bottom = 0;
    
    if(self.type == YQItemCellTypeMiddle){
        left = self.separatorInset.left;
        right = self.separatorInset.right;
    }else if(self.type == YQItemCellTypeFirst){
        top = self.separatorInset.top;
        bottom = self.separatorInset.bottom;//只有在第一个是最后一个的时候用到
    }else{
        left = self.separatorInset.left;
        bottom = self.separatorInset.bottom;
    }
    CGContextMoveToPoint(context, left, SINGLE_LINE_ADJUST_OFFSET+top);
    CGContextAddLineToPoint(context, CGRectGetWidth(rect)-right, SINGLE_LINE_ADJUST_OFFSET+top);
    if(self.type == YQItemCellTypeLast || self.isOnly){
        CGContextMoveToPoint(context, 0, CGRectGetHeight(rect)-SINGLE_LINE_ADJUST_OFFSET-bottom);
        CGContextAddLineToPoint(context, CGRectGetWidth(rect), CGRectGetHeight(rect)-SINGLE_LINE_ADJUST_OFFSET-bottom);
    }
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextStrokePath(context);
    
    if(self.accessory){
        CGContextMoveToPoint(context, CGRectGetWidth(rect)-AccessoryTrailing-AccessoryWidth, CGRectGetHeight(rect)/2-AccessoryWidth);
        CGContextAddLineToPoint(context, CGRectGetWidth(rect)-AccessoryTrailing, CGRectGetHeight(rect)/2);
        CGContextAddLineToPoint(context, CGRectGetWidth(rect)-AccessoryTrailing-AccessoryWidth, CGRectGetHeight(rect)/2+AccessoryWidth);
        CGContextSetLineWidth(context, 2);
    }
    CGContextStrokePath(context);
    
    
}
-(void)setAccessory:(BOOL)accessory{
    
    _accessory = accessory;
    if(accessory){
        self.layoutMargins = UIEdgeInsetsMake(0, 0, 0, AccessoryTrailing-5);
    }else{
        self.layoutMargins = UIEdgeInsetsZero;
    }
    [self setNeedsDisplay];
}

@end
