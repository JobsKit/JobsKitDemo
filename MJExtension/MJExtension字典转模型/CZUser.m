//
//  CZUser.m
//  MJExtension字典转模型
//
//  Created by wanglei on 16/12/29.
//  Copyright © 2016年 wanglei. All rights reserved.
//

#import "CZUser.h"

@implementation CZUser

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    
    return @{@"idStr":@"id",@"descriptionStr":@"description"};
}

- (id)copyWithZone:(NSZone *)zone;{
    
    return self;
}
@end
