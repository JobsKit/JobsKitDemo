//
//  ShootingAppDelegate.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/16.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "JobsTabbarVC.h"
#import "NoticePopupView.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability-new"

@interface ShootingAppDelegate : UIResponder<UIApplicationDelegate>

@property(readonly,strong)NSPersistentCloudKitContainer *persistentContainer;
@property(nonatomic,strong)UIWindow *window;//仅仅为了iOS 13 版本向下兼容而存在
@property(nonatomic,strong)JobsTabbarVC *tabBarVC;
@property(nonatomic,strong)NoticePopupView *popupView;

+(instancetype)sharedInstance;
-(void)saveContext;

@end

#pragma clang diagnostic pop
