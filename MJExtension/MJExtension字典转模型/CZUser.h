//
//  CZUser.h
//  MJExtension字典转模型
//
//  Created by wanglei on 16/12/29.
//  Copyright © 2016年 wanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CZUser : NSObject<NSCopying>
/*
"id": 1404376560,
"location": "北京 朝阳区",
"description": "人生五十年，乃如梦如幻；有生斯有死，壮士复何憾。"
 */
@property(nonatomic,strong)NSNumber *idStr;
@property(nonatomic,copy)NSString *location;
@property(nonatomic,copy)NSString *descriptionStr;


@end
