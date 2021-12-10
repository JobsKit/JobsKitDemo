//
//  JobsShootingAppDelegate+PopupView.h
//  Shooting
//
//  Created by Jobs on 2020/11/11.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "JobsShootingAppDelegate.h"

#if __has_include(<TFPopup/TFPopup.h>)
#import <TFPopup/TFPopup.h>
#else
#import "TFPopup.h"
#endif

NS_ASSUME_NONNULL_BEGIN

@interface JobsShootingAppDelegate (PopupView)

-(void)Popupview;

@end

NS_ASSUME_NONNULL_END
