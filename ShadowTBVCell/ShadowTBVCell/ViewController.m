//
//  ViewController.m
//  ShadowTBVCell
//
//  Created by Jobs on 2020/7/20.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "ViewController.h"
#import "PushToVCViewController.h"
#import "MyFansTBVCell.h"

#import "PushAnimation.h"
//参考源码： https://github.com/AmoAmoAmo/PushTransformAnimation
@interface ViewController ()
<
UITableViewDelegate
,UITableViewDataSource
,UINavigationControllerDelegate
>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kWhiteColor;
    self.gk_navTitle = NSStringFromClass(self.class);
    self.gk_statusBarHidden = NO;
    self.gk_navLineHidden = YES;
    self.tableView.alpha = 1;
    self.navigationController.delegate = self;
}

#pragma mark - UINavigationController - Delegate
// nav 协议方法的实现 告知 Nav 去使用 UIViewControllerAnimatedTransitioning协议中的方法
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0){
    if([toVC isKindOfClass:PushToVCViewController.class]){
        return PushAnimation.new;
    }else{
        return nil;
    }
}

#pragma mark —————————— UITableViewDelegate,UITableViewDataSource ——————————
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [MyFansTBVCell cellHeightWithModel:nil];
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    @jobs_weakify(self)
    PushToVCViewController *vc = [PushToVCViewController ComingFromVC:weak_self
                                                          comingStyle:ComingStyle_PUSH
                                                    presentationStyle:UIModalPresentationAutomatic
                                                        requestParams:[UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpeg",indexPath.row]]
                                                              success:^(id data) {}
                                                             animated:YES];
    vc.indexPath = indexPath;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(void)tableView:(UITableView *)tableView
didHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSLog(@"----- highlight -------");
    // highlight的时候，做一下缩放的动画
    MyFansTBVCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    [UIView animateWithDuration:0.3
                     animations:^{
        cell.transform = CGAffineTransformMakeScale(0.97, 0.97);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3
                         animations:^{
            cell.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
        }];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyFansTBVCell *cell = [MyFansTBVCell cellWithTableView:tableView];
    [cell richElementsInCellWithModel:@(indexPath.row % 4)];
    return cell;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = UITableView.new;
        _tableView.backgroundColor = kWhiteColor;//[UIColor colorWithHexString:@"050013"];
        _tableView.pagingEnabled = YES;//这个属性为YES会使得Tableview一格一格的翻动
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.gk_navigationBar.mas_bottom);
            make.left.right.bottom.equalTo(self.view);
        }];
        [self.view layoutIfNeeded];
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0 ;
        _tableView.mj_header = self.mjRefreshGifHeader;
        _tableView.mj_footer = self.mjRefreshAutoGifFooter;
        _tableView.ly_emptyView = [LYEmptyView emptyViewWithImageStr:@"noData"
                                                    titleStr:@"您还没有粉丝"
                                                   detailStr:@""];
        _tableView.mj_footer.hidden = NO;
    }return _tableView;
}

@end
