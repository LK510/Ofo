//
//  Model.h
//  Ofo
//
//  Created by 路飞 on 2017/2/28.
//  Copyright © 2017年 路飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

@property (nonatomic,strong) NSString *num;
@property (nonatomic,strong) NSString *pwd;

-(NSMutableDictionary*) getDictionary;

@end
