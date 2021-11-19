//
//  CZStatus.h
//  MJExtension字典转模型
//
//  Created by wanglei on 16/12/29.
//  Copyright © 2016年 wanglei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
#import "CZUser.h"

@interface CZStatus : NSObject
/*
{
    "created_at": "Tue May 31 17:46:55 +0800 2011",
    "id": 11488058246,
    "annotations": [{"name" : "北京"},{"name" : "广州"}],
    "user": {
        "id": 1404376560,
        "location": "北京 朝阳区",
        "description": "人生五十年，乃如梦如幻；有生斯有死，壮士复何憾。"
    }
},
{
    "created_at": "Tue May 20 17:46:55 +0800 2016",
    "id": 12088058246,
    "annotations": [{"name" : "神武"},{"name" : "武汉"}],
    "user": {
        "id": 1104376560,
        "location": "北京 群众",
        "description": "人生100年"
    }
}
 */

@property(nonatomic,copy)NSString *created_at;
@property(nonatomic,copy)NSNumber *idStr;
@property(nonatomic,copy)NSArray *annotations;
@property(nonatomic,copy)CZUser *user;



@end
