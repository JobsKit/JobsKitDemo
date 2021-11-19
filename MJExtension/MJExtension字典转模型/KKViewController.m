//
//  ViewController.m
//  MJExtension字典转模型
//
//  Created by Jobs on 2020/7/24.
//  Copyright © 2020 wanglei. All rights reserved.
//

#import "KKViewController.h"

@interface KKViewController ()

@end

@implementation KKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self changeTheArrayToDoubleModel];
    [self changeTheDictToModel];
}

// 将数组转换为模型(模型中有嵌套数组和字典)
- (void)changeTheArrayToDoubleModel{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"weibo1" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSArray <CZWeibo *>*Array = [CZWeibo mj_objectArrayWithKeyValuesArray:array];
    CZWeibo *weibo = Array[0];
    CZStatus *wlid = weibo.statuses[0];
    CZUser *user = wlid.user;
    
    NSLog(@"%@",user.descriptionStr);
   
}
// 将数组转换为模型
- (void)changeTheArrayToModel{
    NSArray *dictArray = @[
                           @{
                               @"name" : @"Jack",
                               @"icon" : @"lufy.png",
                               },
                           @{
                               @"name" : @"Rose",
                               @"icon" : @"nami.png",
                               }
                           ];
    
    // 将字典数组转为User模型数组
    NSArray *userArray = [User mj_objectArrayWithKeyValuesArray:dictArray];
    // 打印userArray数组中的User模型属性
    for (User *user in userArray) {
        NSLog(@"name=%@, icon=%@", user.name, user.icon);}
    // name=Jack, icon=lufy.png
  
}
// 将字典转换为模型
- (void)changeTheDictToModel{
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"weibo" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    CZWeibo *weibo = [CZWeibo mj_objectWithKeyValues:dict];
    CZStatus *wlid = weibo.statuses[0];
    CZUser *user = wlid.user;
    
    NSLog(@"%@",user.descriptionStr);
   
}


@end
