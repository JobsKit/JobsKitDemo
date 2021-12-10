//
//  JobsShootingAppDelegate+PopupView.m
//  Shooting
//
//  Created by Jobs on 2020/11/11.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "JobsShootingAppDelegate+PopupView.h"

@implementation JobsShootingAppDelegate (PopupView)

// 见 @implementation UIViewController (TFPopup)
-(void)Popupview{
    [self.popupView tf_showNormal:getMainWindow() animated:YES];
}

@end
