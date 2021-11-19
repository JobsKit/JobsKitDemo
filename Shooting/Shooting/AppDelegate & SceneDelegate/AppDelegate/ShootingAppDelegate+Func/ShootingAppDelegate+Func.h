//
//  ShootingAppDelegate+Func.h
//  Shooting
//
//  Created by Jobs on 2020/11/11.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "ShootingAppDelegate.h"

#if __has_include(<Reachability/Reachability.h>)
#import <Reachability/Reachability.h>
#else
#import "Reachability.h"//检查联网情况
#endif

#if __has_include(<GKNavigationBar/GKNavigationBar.h>)
#import <GKNavigationBar/GKNavigationBar.h>
#else
#import "GKNavigationBar.h"
#endif

#if __has_include(<TABAnimated/TABAnimated.h>)
#import <TABAnimated/TABAnimated.h>
#else
#import "TABAnimated.h"
#endif

#if __has_include(<IQKeyboardManager/IQKeyboardManager.h>)
#import <IQKeyboardManager/IQKeyboardManager.h>
#else
#import "IQKeyboardManager.h"
#endif

#if DEBUG

#if __has_include(<DoraemonManager/DoraemonManager.h>)
#import <DoraemonKit/DoraemonManager.h>
#else
#import "DoraemonManager.h"
#endif

#import "JobsBitsMonitor.h"

#endif

NS_ASSUME_NONNULL_BEGIN

@interface ShootingAppDelegate (Func)

@property(nonatomic,strong)JobsBitsMonitorSuspendLab *bitsMonitorSuspendLab;

#pragma mark —— 全局配置 TABAnimated
-(void)makeTABAnimatedConfigure;
#pragma mark —— 全局配置键盘
-(void)makeIQKeyboardManagerConfigure;
#pragma mark —— 全局配置GKNavigationBar
-(void)makeGKNavigationBarConfigure;
#pragma mark —— 网络环境监测
-(void)makeReachabilityConfigure;
#pragma mark —— 网络流量实时监控
-(void)makeNetworkingBitsMonitor;
#pragma mark —— 开屏广告
-(void)makeXHLaunchAdConfigure;
#pragma mark —— 滴滴打车团队出的一款小工具
-(void)makeDoraemonManagerConfigure;

@end

NS_ASSUME_NONNULL_END
