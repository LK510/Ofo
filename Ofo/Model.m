//
//  Model.m
//  Ofo
//
//  Created by 路飞 on 2017/2/28.
//  Copyright © 2017年 路飞. All rights reserved.
//

#import "Model.h"

@implementation Model

-(NSMutableDictionary*) getDictionary{
    
    NSMutableDictionary* fileDic = [[NSMutableDictionary alloc] init];
    [fileDic setObject:_num forKey:@"bikenum"];
    [fileDic setObject:_pwd forKey:@"bikepwd"];
    
    return fileDic;
}

@end
