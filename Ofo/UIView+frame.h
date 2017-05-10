//
//  UIView+frame.h
//  Sellermajunliang
//
//  Created by zhangyang on 15/8/18.
//  Copyright (c) 2015年 majunliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+Message.h"

@interface UIView (frame)
// Frame
@property (nonatomic) CGPoint viewOrigin;
@property (nonatomic) CGSize viewSize;

// Frame Origin
@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;

// Frame Size
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

// Frame Borders
@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat right;

// Center Point

@property (nonatomic) CGPoint center;
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

// Middle Point
@property (nonatomic, readonly) CGPoint middlePoint;
@property (nonatomic, readonly) CGFloat middleX;
@property (nonatomic, readonly) CGFloat middleY;

//调整view的显示区域,宽度放大size.width*2,高度放大size.height*2,中心位置不变
- (void)adjustSize:(CGSize)size;

/**
 * 计算一个view相对于屏幕的坐标
 */
+ (CGRect)relativeFrameForScreenWithView:(UIView *)v;

- (void)adjustSize;

@end
