//
//  YQSectionView.m
//  YQItemCellDemo
//
//  Created by Wang on 15/7/6.
//  Copyright (c) 2015年 Wang. All rights reserved.
//

#import "YQSectionView.h"


@interface YQSectionView ()

//@property (nonatomic, strong) NSMutableArray *originYArray;


@property (nonatomic, strong) NSMutableArray *itemArray;

@end



@implementation YQSectionView

- (instancetype)initWithItemCount:(NSInteger)count{
    self = [super init];
    if(self){
        self.equalWidth = YES;
        self.separatorInset = UIEdgeInsetsZero;
        self.itemCount = count;
        [self manualConfigureItems];
    }
    return self;
}
- (instancetype)initWithItemCount:(NSInteger)count equalWidth:(BOOL)equalWidth{
    self = [super init];
    if(self){
        self.equalWidth = equalWidth;
        self.itemCount = count;
        if(!equalWidth){
            NSLog(@"没有设置等宽，请务必调用- (void)manualConfigureItems 完成item的绘制");
        }
        self.separatorInset = UIEdgeInsetsZero;
        
    }
    return self;
}
- (void)awakeFromNib{
    [self manualConfigureItems];
}
- (void)manualConfigureItems{
    self.itemArray = [NSMutableArray arrayWithCapacity:self.itemCount];
    YQItemCell *cell = nil;
    if(self.itemCount == 1){
        cell = [[YQItemCell alloc] initWithIndex:0 type:YQItemCellTypeFirst separatorInset:self.separatorInset isOnly:YES];
        
        [self addSubview:cell];
        [self.itemArray addObject:cell];
        //加点击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchAction:)];
        [cell addGestureRecognizer:tap];
    }else{
        for (int i = 0; i < self.itemCount; i++) {
            if(i == 0){
                cell = [[YQItemCell alloc] initWithIndex:i type:YQItemCellTypeFirst separatorInset:self.separatorInset];
            }else if(i == self.itemCount-1){
                cell = [[YQItemCell alloc] initWithIndex:i type:YQItemCellTypeLast separatorInset:self.separatorInset];
            }else{
                cell = [[YQItemCell alloc] initWithIndex:i type:YQItemCellTypeMiddle separatorInset:self.separatorInset];
            }
            
            [self.itemArray addObject:cell];
            [self addSubview:cell];
            
            //加点击手势
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchAction:)];
            [cell addGestureRecognizer:tap];
        }
    }
    [self.itemArray enumerateObjectsUsingBlock:^(YQItemCell *obj, NSUInteger idx, BOOL *stop) {
        
        [obj setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:obj attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:0]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:obj attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1 constant:0]];
        if(idx == 0){
            [self addConstraint:[NSLayoutConstraint constraintWithItem:obj attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
            
            if(self.itemArray.count == 1){
                [self addConstraint:[NSLayoutConstraint constraintWithItem:obj attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
            }
        }else {
            YQItemCell *oldObj = self.itemArray[idx-1];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:obj attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:oldObj attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
            if(self.equalWidth){
                [self addConstraint:[NSLayoutConstraint constraintWithItem:obj attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:oldObj attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
            }
            if(idx == self.itemArray.count-1){
                [self addConstraint:[NSLayoutConstraint constraintWithItem:obj attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
            }
        }
        
    }];

}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.itemArray enumerateObjectsUsingBlock:^(YQItemCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setNeedsDisplay];
    }];
}
- (void)touchAction:(UITapGestureRecognizer *)gesture{
    if([gesture.view isKindOfClass:[YQItemCell class]]){
        if(self.didClickBlock){
            self.didClickBlock([(YQItemCell *)gesture.view index]);
        }
    }
}

- (YQItemCell *)cellAtIndex:(NSInteger)index{
    NSAssert(index < self.itemArray.count, @"取YQItemCell越界了吧");
    return self.itemArray[index];
}
- (void)setSeparatorInset:(UIEdgeInsets)separatorInset{
    if(UIEdgeInsetsEqualToEdgeInsets(separatorInset,_separatorInset)){
        return;
    }
    _separatorInset = separatorInset;
    [self.itemArray enumerateObjectsUsingBlock:^(YQItemCell *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.separatorInset = separatorInset;
        [obj setNeedsDisplay];
    }];
    
}
/*
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    NSLog(@"%@:%@",NSStringFromClass([self class]),NSStringFromSelector(_cmd));
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
*/


@end
