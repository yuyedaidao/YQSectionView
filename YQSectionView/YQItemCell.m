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
@property (nonatomic, assign,getter=isOnly) BOOL only;
@property (nonatomic, assign) BOOL fromNib;
@property (nonatomic, strong) UIColor *originalColor;
@end

@implementation YQItemCell

- (instancetype)init {
    return [self initWithIndex:0 type:YQItemCellTypeFirst separatorInset:UIEdgeInsetsZero];
}
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
        _lineColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1];
        _highlightColor = _lineColor;
        [self addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        [self commonInit];
    }
    return self;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    self.fromNib = YES;
    self.lineWidth = SINGLE_LINE_WIDTH;
    [self commonInit];
}
- (void)commonInit{
    self.userInteractionEnabled = YES;
    //暂无处理
}
- (void)tapAction:(id)sender{
    if(self.clickedBlock){
        self.clickedBlock(self);
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    [_lineColor setStroke];
    if(self.fromNib){
    
        if(self.topLine){
            CGContextMoveToPoint(context, self.topLeftPadding, SINGLE_LINE_ADJUST_OFFSET);
            CGContextAddLineToPoint(context, CGRectGetWidth(rect), SINGLE_LINE_ADJUST_OFFSET);
        }
        if(self.bottomLine){
            CGContextMoveToPoint(context, self.bottomLeftPadding, CGRectGetHeight(rect)-SINGLE_LINE_ADJUST_OFFSET);
            CGContextAddLineToPoint(context, CGRectGetWidth(rect), CGRectGetHeight(rect)-SINGLE_LINE_ADJUST_OFFSET);
        }

    }else{
        
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
        
    }
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextStrokePath(context);
    if(self.accessory){
        CGContextMoveToPoint(context, CGRectGetWidth(rect)-AccessoryTrailing-AccessoryWidth, CGRectGetHeight(rect)/2-AccessoryWidth);
        CGContextAddLineToPoint(context, CGRectGetWidth(rect)-AccessoryTrailing, CGRectGetHeight(rect)/2);
        CGContextAddLineToPoint(context, CGRectGetWidth(rect)-AccessoryTrailing-AccessoryWidth, CGRectGetHeight(rect)/2+AccessoryWidth);
        CGContextSetLineWidth(context, 2);
        CGContextStrokePath(context);
    }
    
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


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    if (_shouldHighlight) {
        self.originalColor = self.backgroundColor;
        self.backgroundColor = self.highlightColor;
    }

}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    if (_shouldHighlight) {
        self.backgroundColor = self.originalColor;
    }
    
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    if (_shouldHighlight) {
        self.backgroundColor = self.originalColor;
    }
}

@end
