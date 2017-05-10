//
//  UIView+nib.m
//  yinji
//
//  Created by majunliang on 16/8/27.
//  Copyright © 2016年 印记. All rights reserved.
//

#import "UIView+nib.h"

@implementation NSObject (nib)

+ (instancetype)loadFromNib
{
    UINib *nib = [UINib nibWithNibName:NSStringFromClass(self.class) bundle:nil];
    
    return [[nib instantiateWithOwner:nil options:nil] firstObject];
}

@end
