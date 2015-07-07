//
//  YQItemCell.m
//  YQSectionViewDemo
//
//  Created by Wang on 15/7/7.
//  Copyright (c) 2015年 Wang. All rights reserved.
//

#import "YQItemCell.h"
#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)
#define SINGLE_LINE_ADJUST_OFFSET   ((1 / [UIScreen mainScreen].scale) / 2)



@interface YQItemCell ()
@property (nonatomic, assign) CGFloat lineWidth;

@property (nonatomic, assign) YQItemCellType type;
 
@end

@implementation YQItemCell
- (instancetype)initWithIndex:(NSInteger)index type:(YQItemCellType)type{
    if(self = [super init]){
        _index = index;
        _type = type;
        _lineWidth = SINGLE_LINE_WIDTH;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGFloat originYOffset = 0;
    CGFloat originX = 0;
    CGFloat originXOffset = 0;
    if(self.type == YQItemCellTypeMiddle){
        originX = self.separatorInset.left;
        originXOffset = self.separatorInset.right;
    }else if(self.type == YQItemCellTypeFirst){
        originYOffset = self.separatorInset.top;
    }else{
        originYOffset = self.separatorInset.bottom;
    }
    CGContextMoveToPoint(context, originX, SINGLE_LINE_ADJUST_OFFSET+originYOffset);
    CGContextAddLineToPoint(context, CGRectGetWidth(rect)-originXOffset, SINGLE_LINE_ADJUST_OFFSET+originYOffset);
    if(self.type == YQItemCellTypeLast){
        CGContextMoveToPoint(context, originX, CGRectGetHeight(rect)-SINGLE_LINE_ADJUST_OFFSET-originYOffset);
        CGContextAddLineToPoint(context, CGRectGetWidth(rect), CGRectGetHeight(rect)-SINGLE_LINE_ADJUST_OFFSET-originYOffset);
    }
    CGContextSetLineWidth(context, self.lineWidth);
    [[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1] setStroke];
    CGContextStrokePath(context);
}

- (void)setSeparatorInset:(UIEdgeInsets)separatorInset{
    _separatorInset = separatorInset;
    [self layoutIfNeeded];
}

@end
