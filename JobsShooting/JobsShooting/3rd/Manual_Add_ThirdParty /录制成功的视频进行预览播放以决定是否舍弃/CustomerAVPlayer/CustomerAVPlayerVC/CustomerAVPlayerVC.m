//
//  CustomerAVPlayerVC.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/8/18.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "CustomerAVPlayerView.h"
#import "CustomerAVPlayerVC.h"

@interface CustomerAVPlayerVC ()

@property(nonatomic,strong)CustomerAVPlayerView *AVPlayerView;
@property(nonatomic,strong)NSURL *AVPlayerURL;

@property(nonatomic,strong)id requestParams;
@property(nonatomic,copy)MKDataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;

@end

@implementation CustomerAVPlayerVC

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated{
    CustomerAVPlayerVC *vc = CustomerAVPlayerVC.new;
    vc.successBlock = block;
    vc.requestParams = requestParams;
    
    vc.AVPlayerURL = requestParams[@"AVPlayerURL"];
    
    switch (comingStyle) {
        case ComingStyle_PUSH:{
            if (rootVC.navigationController) {
                vc.isPush = YES;
                vc.isPresent = NO;
                [rootVC.navigationController pushViewController:vc
                                                       animated:animated];
            }else{
                vc.isPush = NO;
                vc.isPresent = YES;
                [rootVC presentViewController:vc
                                     animated:animated
                                   completion:^{}];
            }
        }break;
        case ComingStyle_PRESENT:{
            vc.isPush = NO;
            vc.isPresent = YES;
            //iOS_13中modalPresentationStyle的默认改为UIModalPresentationAutomatic,而在之前默认是UIModalPresentationFullScreen
            vc.modalPresentationStyle = presentationStyle;
            [rootVC presentViewController:vc
                                 animated:animated
                               completion:^{}];
        }break;
        default:
            NSLog(@"错误的推进方式");
            break;
    }return vc;
}

-(instancetype)init{
    if (self = [super init]) {

    }return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.AVPlayerView.alpha = 1;
    
    self.gk_navigationBar.hidden = NO;
    if (self.gk_navigationBar.hidden) {
        [self.view bringSubviewToFront:self.gk_navigationBar];
    }
    self.gk_interactivePopDisabled = NO;
    self.gk_fullScreenPopDisabled = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    JobsShootingAppDelegate.sharedInstance.tabBarVC.tabBar.hidden = YES;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    JobsShootingAppDelegate.sharedInstance.tabBarVC.tabBar.hidden = NO;
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}
#pragma mark —— lazyLoad
-(CustomerAVPlayerView *)AVPlayerView{
    if (!_AVPlayerView) {
        @jobs_weakify(self)
        _AVPlayerView = [[CustomerAVPlayerView alloc] initWithURL:self.AVPlayerURL
                                                        suspendVC:weak_self];
//        _AVPlayerView.isSuspend = YES;//开启悬浮窗效果
        [_AVPlayerView errorCustomerAVPlayerBlock:^{
            @jobs_strongify(self)
            [WHToast toastErrMsg:@"软件内部错误 : 因为某种未知的原因，找不到播放的资源文件"];
        }];
        ///点击事件回调 参数1：self CustomerAVPlayerView，参数2：手势 UITapGestureRecognizer & UISwipeGestureRecognizer
        [_AVPlayerView actionCustomerAVPlayerBlock:^(id data,
                                                     id data2) {
            @strongify(self)
            if ([data2 isKindOfClass:UITapGestureRecognizer.class]) {
                NSLog(@"你点击了我");
            }else if ([data2 isKindOfClass:UISwipeGestureRecognizer.class]){
                if ([data isKindOfClass:CustomerAVPlayerView.class]) {
                    CustomerAVPlayerView *view = (CustomerAVPlayerView *)data;
                    if ([view.vc isEqual:self]) {
                        if (self.navigationController) {
                            [self.navigationController popViewControllerAnimated:YES];
                        }else{
                            [self dismissViewControllerAnimated:YES
                                                     completion:^{
                                
                            }];
                        }
                    }
                }
            }else{}
        }];
        [self.view addSubview:_AVPlayerView];
        [self.view.layer addSublayer:_AVPlayerView.playerLayer];
        [_AVPlayerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            if (self.gk_navBarAlpha && !self.gk_navigationBar.hidden) {//显示
                make.top.equalTo(self.gk_navigationBar.mas_bottom);
            }else{
                make.top.equalTo(self.view.mas_top);
            }
        }];
    }return _AVPlayerView;
}

@end
