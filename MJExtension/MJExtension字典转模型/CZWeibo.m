//
//  CZWeibo.m
//  MJExtension字典转模型
//
//  Created by wanglei on 16/12/29.
//  Copyright © 2016年 wanglei. All rights reserved.
//

#import "CZWeibo.h"

@implementation CZWeibo
/**
 *  数组中需要转换的模型类
 *
 *  @return 字典中的key是数组属性名，value是数组中存放模型的Class（Class类型或者NSString类型）
 */

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"statuses":[CZStatus class],@"ad":[CZAd class]};
}
@end
