//
//  PushToVCViewController.m
//  ShadowTBVCell
//
//  Created by Jobs on 2020/7/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "PushToVCViewController.h"
#import "BackAnimation.h"
#import "ViewController.h"

@interface PushToVCViewController ()
<
UINavigationControllerDelegate
>

@property(nonatomic,strong)id requestParams;
@property(nonatomic,copy)MKDataBlock successBlock;
@property(nonatomic,assign)BOOL isPush;
@property(nonatomic,assign)BOOL isPresent;

@property(nonatomic,strong)UIImage *image;

@end

@implementation PushToVCViewController

- (void)dealloc {
    NSLog(@"Running self.class = %@;NSStringFromSelector(_cmd) = '%@';__FUNCTION__ = %s", self.class, NSStringFromSelector(_cmd),__FUNCTION__);
}

+ (instancetype)ComingFromVC:(UIViewController *)rootVC
                 comingStyle:(ComingStyle)comingStyle
           presentationStyle:(UIModalPresentationStyle)presentationStyle
               requestParams:(nullable id)requestParams
                     success:(MKDataBlock)block
                    animated:(BOOL)animated{
    PushToVCViewController *vc = PushToVCViewController.new;
    vc.successBlock = block;
    vc.requestParams = requestParams;
    if ([vc.requestParams isKindOfClass:UIImage.class]) {
        vc.image = vc.requestParams;
    }
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

#pragma mark - Lifecycle
-(instancetype)init{
    if (self = [super init]) {
        
    }return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    self.view.backgroundColor = HEXCOLOR(0x333333);
    self.gk_navTitle = NSStringFromClass(self.class);
    self.gk_statusBarHidden = NO;
    self.gk_navLineHidden = YES;
    self.gk_backStyle = GKNavigationBarBackStyleBlack;
    self.imageView.alpha = 1;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.delegate = self;
    /** 重新设置返回手势的代理给nav */
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}

#pragma mark - UINavigationControllerDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0){
    if([toVC isKindOfClass:ViewController.class]){
        return BackAnimation.new;
    }else{
        return nil;
    }
}

#pragma mark —— lazyLoad
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = UIImageView.new;
        _imageView.image = self.image;
        [self.view addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.gk_navigationBar.mas_bottom).offset(10);
            make.left.equalTo(self.view).offset(10);
            make.size.mas_equalTo(CGSizeMake(300, 300));
        }];
    }return _imageView;
}

@end
