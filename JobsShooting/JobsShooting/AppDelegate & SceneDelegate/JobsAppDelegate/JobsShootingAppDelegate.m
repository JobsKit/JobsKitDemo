//
//  JobsShootingAppDelegate.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/6/16.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "JobsShootingAppDelegate.h"
#import "JobsShootingAppDelegate+Func.h"
#import "JobsShootingAppDelegate+PopupView.h"
#import "JobsShootingAppDelegate+XHLaunchAdDelegate.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability-new"

JobsShootingAppDelegate *appDelegate;
@interface JobsShootingAppDelegate ()

@end

@implementation JobsShootingAppDelegate

-(instancetype)init{
    if (self = [super init]) {
        appDelegate = self;
    }return self;
}
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wmethod-signatures"
//- (UIInterfaceOrientationMask)application:(UIApplication *)application
//  supportedInterfaceOrientationsForWindow:(UIWindow *)window {
//    //设置强制旋转屏幕
//    if (self.cyl_isForceLandscape) {
//        //只支持横屏
//        return UIInterfaceOrientationMaskLandscape;
//    } else {
//        //只支持竖屏
//        return UIInterfaceOrientationMaskPortrait;
//    }
//}
//#pragma clang diagnostic pop
- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];//保持屏幕常亮
    /*
     * 禁止App系统文件夹document同步
     * 苹果要求：可重复产生的数据不得进行同步,什么叫做可重复数据？这里最好禁止，否则会影响上架，被拒！
     */
    [FileFolderHandleTool banSysDocSynchronization];
    
#ifdef DEBUG
    [UIFont getAvailableFont];//打印全员字体
#endif
    [self makeTABAnimatedConfigure];
    [self makeIQKeyboardManagerConfigure];//智能键盘
    [self makeGKNavigationBarConfigure];//自定义导航栏
    [self makeDoraemonManagerConfigure];//滴滴打车团队出的一款小工具
    [self makeXHLaunchAdConfigure];//开屏广告
    [self makeReachabilityConfigure];//网络环境监测
    
    if (HDDeviceSystemVersion.floatValue < 13.0) {
        self.window.alpha = 1;
        [self Popupview];// 弹出框
    }return YES;
}
//系统版本低于iOS13.0的设备
-(void)applicationDidEnterBackground:(UIApplication *)application{
    NSLog(@"---applicationDidEnterBackground----");//进入后台
    [[NSNotificationCenter defaultCenter] postNotificationName:UBLEnterBackgroundStopPlayer object:nil];
}

//系统版本低于iOS13.0的设备
-(void)applicationDidBecomeActive:(UIApplication *)application{
    NSLog(@"---applicationDidBecomeActive----");//进入前台
}
#pragma mark - UISceneSession lifecycle
- (UISceneConfiguration *)application:(UIApplication *)application
configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession
                              options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration"
                                          sessionRole:connectingSceneSession.role];
}

- (void)application:(UIApplication *)application
didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}
#pragma mark - Core Data stack
@synthesize persistentContainer = _persistentContainer;
- (NSPersistentCloudKitContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentCloudKitContainer alloc] initWithName:HDAppDisplayName];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }return _persistentContainer;
}
#pragma mark - Core Data Saving support
- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}
#pragma mark —— lazyLoad
//仅仅为了iOS 13 版本向下兼容而存在
-(UIWindow *)window{
    if (!_window) {
        _window = UIWindow.new;
        _window.frame = [UIScreen mainScreen].bounds;
        [_window setRootViewController:self.tabBarVC];
        [_window makeKeyAndVisible];
    }return _window;
}

-(JobsTabbarVC *)tabBarVC{
    if (!_tabBarVC) {
        _tabBarVC = JobsTabbarVC.new;
//        _tabBarVC.isOpenScrollTabbar = NO;
        [_tabBarVC.childMutArr addObject:childViewController_customStyle(ViewController_1.new,
                                                                         @"直播",
                                                                         KBuddleIMG(@"资源文件", @"TabbaritemImage", nil, @"community_selected"),
                                                                         KBuddleIMG(@"资源文件", @"TabbaritemImage", nil, @"community_unselected"),
                                                                         0,
                                                                         @"home_priase_animation",
                                                                         1)];
        
        [_tabBarVC.childMutArr addObject:childViewController_customStyle(ViewController_2.new,
                                                                         @"赛程",
                                                                         KBuddleIMG(@"资源文件", @"TabbaritemImage", nil, @"post_selected"),
                                                                         KBuddleIMG(@"资源文件", @"TabbaritemImage", nil, @"post_unselected"),
                                                                         30,
                                                                         @"green_lottie_tab_home",
                                                                         1)];
        
        [_tabBarVC.childMutArr addObject:childViewController_customStyle(DDPlazaVC.new,
                                                                         @"广场",
                                                                         KBuddleIMG(@"资源文件", @"TabbaritemImage", nil, @"post_selected"),
                                                                         KBuddleIMG(@"资源文件", @"TabbaritemImage", nil, @"post_unselected"),
                                                                         30,
                                                                         @"green_lottie_tab_home",
                                                                         1)];
        
        [_tabBarVC.childMutArr addObject:childViewController_customStyle(ViewController_4.new,
                                                                         @"预测",
                                                                         KBuddleIMG(@"资源文件", @"TabbaritemImage", nil, @"post_selected"),
                                                                         KBuddleIMG(@"资源文件", @"TabbaritemImage", nil, @"post_unselected"),
                                                                         30,
                                                                         @"green_lottie_tab_home",
                                                                         1)];
        
        [_tabBarVC.childMutArr addObject:childViewController_customStyle(ViewController_5.new,
                                                                         @"我的",
                                                                         KBuddleIMG(@"资源文件", @"TabbaritemImage", nil, @"My_selected"),
                                                                         KBuddleIMG(@"资源文件", @"TabbaritemImage", nil, @"My_unselected"),
                                                                         0,
                                                                         @"green_lottie_tab_mine",
                                                                         1)];
    }return _tabBarVC;
}

-(NoticePopupView *)popupView{
    if (!_popupView) {
        _popupView = NoticePopupView.new;
        _popupView.mj_h = 250;
        _popupView.mj_w = SCREEN_WIDTH * 2 / 3;
    }return _popupView;
}

@end

#pragma clang diagnostic pop
