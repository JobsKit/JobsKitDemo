//
//  BaseVC+AlertController.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/4.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "BaseVC+AlertController.h"
#import <objc/runtime.h>

@implementation BaseVC (AlertController)

//static char *BaseVC_AlertController = "BaseVC_AlertController";

///屏幕正中央 isSeparateStyle如果为YES 那么有实质性进展的键位在右侧，否则在左侧
-(void)alertControllerStyle:(AlertControllerStyle)alertControllerStyle
         showAlertViewTitle:(nullable NSString *)title
                    message:(nullable NSString *)message
            isSeparateStyle:(BOOL)isSeparateStyle
                btnTitleArr:(NSArray <NSString*>*)btnTitleArr
             alertBtnAction:(NSArray <NSString*>*)alertBtnActionArr
               alertVCBlock:(MKDataBlock)alertVCBlock{
    switch (alertControllerStyle) {
        case SYS_AlertController:{
            @weakify(self)
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                                     message:message
                                                                              preferredStyle:UIAlertControllerStyleAlert];
            for (int i = 0; i < alertBtnActionArr.count; i++) {
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:btnTitleArr[i]
                                                                   style:isSeparateStyle ? (i == alertBtnActionArr.count - 1 ? UIAlertActionStyleCancel : UIAlertActionStyleDefault) : UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction * _Nonnull action) {
                                                                     @strongify(self)
                                                                     [self performSelector:NSSelectorFromString((NSString *)alertBtnActionArr[i])
                                                                                withObject:Nil];
                                                                 }];
                [alertController addAction:okAction];
            }
            if (alertVCBlock) {
                alertVCBlock(alertController);
            }
            [self presentViewController:alertController
                               animated:YES
                             completion:nil];
        }break;
        case YX_AlertController:{
            @weakify(self)
            YXAlertController *alertController = [YXAlertController alertControllerWithTitle:title
                                                                                     message:message
                                                                                       style:YXAlertControllerStyleAlert];
            //自定义颜色设置
//            alertController.layout.doneActionTitleColor = [UIColor redColor];
//            alertController.layout.cancelActionBackgroundColor = [UIColor whiteColor];
//            alertController.layout.doneActionBackgroundColor = [UIColor yellowColor];
//            alertController.layout.lineColor = [UIColor redColor];
//            alertController.layout.topViewBackgroundColor = [UIColor orangeColor];
//            alertController.layout.titleColor = [UIColor whiteColor];
//            [alertController layoutSettings];
            for (int i = 0; i < alertBtnActionArr.count; i++) {
                YXAlertAction *okAction = [YXAlertAction actionWithTitle:btnTitleArr[i]
                                                                   style:isSeparateStyle ? (i == alertBtnActionArr.count - 1 ? YXAlertActionStyleCancel : YXAlertActionStyleDefault) : YXAlertActionStyleDefault
                                                                 handler:^(YXAlertAction * _Nonnull action) {
                                                                     @strongify(self)
                                                                     [self performSelector:NSSelectorFromString((NSString *)alertBtnActionArr[i])
                                                                                withObject:Nil];
                                                                 }];
                [alertController addAction:okAction];
            }
            if (alertVCBlock) {
                alertVCBlock(alertController);
            }
            [self presentViewController:alertController
                               animated:YES
                             completion:nil];
        }break;
        default:
            NSAssert(0,@"alertController 创建出现错误");
            break;
    }
}
#warning 重大Bug 此模式下的YX_AlertController 无效 
-(void)alertControllerStyle:(AlertControllerStyle)alertControllerStyle
       showActionSheetTitle:(nullable NSString *)title
                    message:(nullable NSString *)message
            isSeparateStyle:(BOOL)isSeparateStyle
                btnTitleArr:(NSArray <NSString*>*)btnTitleArr
             alertBtnAction:(NSArray <NSString*>*)alertBtnActionArr
                     sender:(nullable UIControl *)sender
               alertVCBlock:(MKDataBlock)alertVCBlock{
    UIViewController *vc = nil;
    switch (alertControllerStyle) {
        case SYS_AlertController:{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                                     message:message
                                                                              preferredStyle:UIAlertControllerStyleActionSheet];
            vc = alertController;
            @weakify(self)
            for (int i = 0; i < alertBtnActionArr.count; i++) {
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:btnTitleArr[i]
                                                                   style:isSeparateStyle ? (i == alertBtnActionArr.count - 1 ? UIAlertActionStyleCancel : UIAlertActionStyleDefault) : UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction * _Nonnull action) {
                                                                     @strongify(self)
                                                                     [self performSelector:NSSelectorFromString((NSString *)alertBtnActionArr[i])
                                                                                withObject:Nil];
                                                                 }];
                [alertController addAction:okAction];
            }
            if (alertVCBlock) {
                alertVCBlock(alertController);
            }
        } break;
        case YX_AlertController:{
            YXAlertController *alertController = [YXAlertController alertControllerWithTitle:title
                                                                                     message:message
                                                                                       style:YXAlertControllerStyleActionSheet];
            vc = alertController;
            //自定义颜色设置
//            alertController.layout.doneActionTitleColor = [UIColor redColor];
//            alertController.layout.cancelActionBackgroundColor = [UIColor whiteColor];
//            alertController.layout.doneActionBackgroundColor = [UIColor yellowColor];
//            alertController.layout.lineColor = [UIColor redColor];
//            alertController.layout.topViewBackgroundColor = [UIColor orangeColor];
//            alertController.layout.titleColor = [UIColor whiteColor];
//            [alertController layoutSettings];
            @weakify(self)
            for (int i = 0; i < alertBtnActionArr.count; i++) {
                YXAlertAction *okAction = [YXAlertAction actionWithTitle:btnTitleArr[i]
                                                                   style:isSeparateStyle ? (i == alertBtnActionArr.count - 1 ? YXAlertActionStyleCancel : YXAlertActionStyleDefault) : YXAlertActionStyleDefault
                                                                 handler:^(YXAlertAction * _Nonnull action) {
                                                                     @strongify(self)
                                                                     [self performSelector:NSSelectorFromString((NSString *)alertBtnActionArr[i])
                                                                                withObject:Nil];
                                                                 }];
                [alertController addAction:okAction];
            }
            if (alertVCBlock) {
                alertVCBlock(alertController);
            }
        } break;
        default:
            NSAssert(0,@"alertController 创建出现错误");
            break;
    }
    UIPopoverPresentationController *popover = vc.popoverPresentationController;
    if (popover){
        popover.sourceView = sender;
        popover.sourceRect = sender.bounds;
        popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
    }
    [self presentViewController:vc
                       animated:YES
                     completion:nil];
}

-(void)showLoginAlertView{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Login"
                                                                             message:@"Enter Your Account Info Below"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    @weakify(self)
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        @strongify(self)
        textField.placeholder = @"username";
        [textField addTarget:self
                      action:@selector(alertUserAccountInfoDidChange:)
            forControlEvents:UIControlEventEditingChanged];
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        @strongify(self)
        textField.placeholder = @"password";
        textField.secureTextEntry = YES;
        [textField addTarget:self
                      action:@selector(alertUserAccountInfoDidChange:)
            forControlEvents:UIControlEventEditingChanged];
    }];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             NSLog(@"Cancel Action");
                                                         }];
    UIAlertAction *loginAction = [UIAlertAction actionWithTitle:@"Login"
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * _Nonnull action) {
                                                            UITextField *userName = alertController.textFields.firstObject;
                                                            UITextField *password = alertController.textFields.lastObject;
                                                            // 输出用户名 密码到控制台
                                                            NSLog(@"username is %@, password is %@",userName.text,password.text);
                                                        }];
    loginAction.enabled = NO;   // 禁用Login按钮
    [alertController addAction:cancelAction];
    [alertController addAction:loginAction];
    [self presentViewController:alertController
                       animated:YES
                     completion:nil];
}

- (void)alertUserAccountInfoDidChange:(UITextField *)sender{
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
    if (alertController){
        NSString *userName = alertController.textFields.firstObject.text;
        NSString *password = alertController.textFields.lastObject.text;
        UIAlertAction *loginAction = alertController.actions.lastObject;
        if (userName.length > 3 &&
            password.length > 6)
            // 用户名大于3位，密码大于6位时，启用Login按钮。
            loginAction.enabled = YES;
        else
            // 用户名小于等于3位，密码小于等于6位，禁用Login按钮。
            loginAction.enabled = NO;
    }
}

@end
