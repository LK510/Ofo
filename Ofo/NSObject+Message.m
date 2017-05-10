//
//  NSObject+Message.m
//  biaoqian
//
//  Created by majunliang on 16/9/1.
//  Copyright © 2016年 cyb. All rights reserved.
//

#import "NSObject+Message.h"
#import <UIKit/UIKit.h>
#import "YJHUDMessage.h"
#import "UIView+nib.h"
#import "UIView+frame.h"

static CGFloat contetHeight;
static UIView *_messageView;
@implementation NSObject (Message)

- (void)contetHeight:(CGFloat)height
{
    contetHeight = height;
    
    if (height) {
        _messageView.bottom = contetHeight - 93/2;
    }
}

- (instancetype)showMessage:(NSString *)message
{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    YJHUDMessage *messageView = [YJHUDMessage loadFromNib];
    [window addSubview:messageView];
    messageView.backgroundColor = [UIColor whiteColor];
    messageView.layer.cornerRadius = 32/2.0;
    
    UIFont *font = [UIFont systemFontOfSize:15];
    messageView.message.text = message;
    messageView.message.font = font;
    messageView.backgroundColor = [UIColor colorWithRed:0.302 green:0.322 blue:0.325 alpha:1.000];
    _messageView = messageView;
    
    messageView.width = [self getLabelWidthWithText:message stringFont:font allowHeight:32]+32 ;
    
    messageView.bottom =  - 93/2;
    messageView.centerX = kScreenWidth/2.0;
    
    [UIView animateWithDuration:3 animations:^{
        messageView.alpha = 0;
    } completion:^(BOOL finished) {
        [messageView removeFromSuperview];
    }];
    
    return messageView;
}


- (CGFloat)getLabelWidthWithText:(NSString *)text stringFont:(UIFont *)font allowHeight:(CGFloat)height{
    CGFloat width;
    CGRect rect = [text boundingRectWithSize:CGSizeMake(2000, height) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil];
    width = rect.size.width;
    return width;
}

@end
