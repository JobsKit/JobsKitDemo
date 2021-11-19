//
//  MKCommentModel.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/23.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MKCommentModel.h"

@implementation MKChildCommentModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    /* 返回的字典，key为模型属性名，value为转化的字典的多级key */
    return @{
        @"ID" : @"id"
    };
}

@end

@implementation MKFirstCommentModel

-(instancetype)init{
    if (self = [super init]) {
        [MKFirstCommentModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                @"MKChildCommentModel":@"childMutArr"
            };
        }];
    }return self;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    /* 返回的字典，key为模型属性名，value为转化的字典的多级key */
    return @{
        @"ID" : @"id"
    };
}

@end

@implementation MKCommentModel

-(instancetype)init{
    if (self = [super init]) {
        [MKCommentModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{
                @"listMytArr":@"MKFirstCommentModel"
            };
        }];
    }return self;
}

@end
