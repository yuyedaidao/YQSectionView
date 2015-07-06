//
//  YQSectionView.m
//  YQItemCellDemo
//
//  Created by Wang on 15/7/6.
//  Copyright (c) 2015年 Wang. All rights reserved.
//

#import "YQSectionView.h"
#define SINGLE_LINE_WIDTH           (1 / [UIScreen mainScreen].scale)
#define SINGLE_LINE_ADJUST_OFFSET   ((1 / [UIScreen mainScreen].scale) / 2)

@interface YQSectionView ()

@property (nonatomic, strong) NSMutableArray *originYArray;
@property (nonatomic, assign) CGFloat lineWidth;
@end



@implementation YQSectionView

- (instancetype)initWithFrame:(CGRect)frame itemCount:(NSInteger)count{
    self = [super initWithFrame:frame];
    if(self){
        self.separatorInset = UIEdgeInsetsZero;
        self.itemCount = count;
        [self awakeFromNib];
    }
    return self;
}

- (void)awakeFromNib{

    self.lineWidth = SINGLE_LINE_WIDTH;
    self.originYArray = [NSMutableArray array];
    CGFloat height = self.bounds.size.height/self.itemCount;
    for (int i = 0; i< self.itemCount; i++) {
        [self.originYArray addObject:@(round(height*i))];
    }
}
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, SINGLE_LINE_ADJUST_OFFSET);
    CGContextAddLineToPoint(context, CGRectGetWidth(rect), SINGLE_LINE_ADJUST_OFFSET);
    
    CGContextMoveToPoint(context, 0, CGRectGetHeight(rect)-SINGLE_LINE_ADJUST_OFFSET);
    CGContextAddLineToPoint(context, CGRectGetWidth(rect), CGRectGetHeight(rect)-SINGLE_LINE_ADJUST_OFFSET);
    
    for (int i = 1; i < self.itemCount; i++) {
        CGFloat y = [self.originYArray[i] doubleValue];
        CGContextMoveToPoint(context, self.separatorInset.left, y-SINGLE_LINE_ADJUST_OFFSET);
        CGContextAddLineToPoint(context, CGRectGetWidth(self.bounds)-self.separatorInset.bottom, y-SINGLE_LINE_ADJUST_OFFSET);
    }
    
    CGContextSetLineWidth(context, self.lineWidth);
    
    
    [[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1] setStroke];
    CGContextStrokePath(context);
}
- (CGFloat)originYAtIndex:(NSInteger)index{
    NSAssert(index < self.originYArray.count, @"index超了吧，好好检查一下");
    return [self.originYArray[index] doubleValue];
}

@end
