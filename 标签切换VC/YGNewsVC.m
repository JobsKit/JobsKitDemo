//
//  YGNewsVC.m
//  YG_electronicSports
//
//  Created by hello on 2019/6/28.
//  Copyright © 2019 YG_Corp. All rights reserved.
//

#import "YGNewsVC.h"
#import "YGAmusementVC.h"
#import "YGTeamNewsVC.h"
#import "YGCompetitionNewsVC.h"

#import "YGNewsTBVCell.h"

@interface YGNewsVC ()

@property(nonatomic,strong)UIView *viewer;
@property(nonatomic,strong)UIView *btnViewer;
@property(nonatomic,strong)NSMutableArray *dataMutArr;
@property(nonatomic,strong)NSMutableArray *btnMutArr;

@property(nonatomic,strong)YGAmusementVC *amusementVC;
@property(nonatomic,strong)YGTeamNewsVC *teamNewsVC;
@property(nonatomic,strong)YGCompetitionNewsVC *competitionNewsVC;

@end

@implementation YGNewsVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.viewer.alpha = 1;
    
    self.btnViewer.alpha = 1;
    
    self.amusementVC.view.alpha = 1;
    
    self.teamNewsVC.view.alpha = 1;
    
    self.competitionNewsVC.view.alpha = 1;
    
    [self.view bringSubviewToFront:self.amusementVC.view];
}

-(UIView *)viewer{
    
    if (!_viewer) {
        
        _viewer = UIView.new;
        
        _viewer.backgroundColor = kRedColor;
        
        [self.view addSubview:self.viewer];
        
        [self.viewer mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.left.right.equalTo(self.view);
            
            make.height.mas_equalTo(SCALING_RATIO(100));
        }];
    }
    
    return _viewer;
}

-(UIView *)btnViewer{
    
    if (!_btnViewer) {
        
        _btnViewer = UIView.new;
        
        _btnViewer.backgroundColor = kBlackColor;
        
        [self.view addSubview:_btnViewer];
        
        [_btnViewer mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.equalTo(self.view);
            
            make.top.equalTo(self.viewer.mas_bottom);
            
            make.height.mas_equalTo(SCALING_RATIO(50));
        }];
        
        [self.view layoutIfNeeded];
        
        __block CGFloat a = MAINSCREEN_WIDTH / 4;
        
        __block CGFloat b = (MAINSCREEN_WIDTH - 3 * a ) / 2;
        
        for (int r = 0; r < self.dataMutArr.count; r++) {
            
            UIButton *btn = UIButton.new;
            
            btn.tag = r;
            
            if (r == 0) {
                
                btn.backgroundColor = kWhiteColor;
                
                btn.selected = YES;
                
                [btn setTitleColor:kBlueColor
                          forState:UIControlStateSelected];
                
            }else{
                
                btn.backgroundColor = kBlackColor;
                
                [btn setTitleColor:kWhiteColor
                          forState:UIControlStateNormal];
            }
            
            [btn addTarget:self
                    action:@selector(btnClickEvent:)
          forControlEvents:UIControlEventTouchUpInside];
            
            [btn setTitle:self.dataMutArr[r] forState:UIControlStateNormal];
            
            [self.btnMutArr addObject:btn];
            
            [_btnViewer addSubview:btn];
            
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.bottom.equalTo(self->_btnViewer);
                
                make.left.equalTo(self.view).offset(b + a * r);
                
                make.width.mas_equalTo(a);
            }];
            
            [self.view layoutIfNeeded];
            
            [UIView appointCornerCutToCircleWithTargetView:btn
                                      TargetCorner_TopLeft:UIRectCornerTopLeft TargetCorner_TopRight:UIRectCornerTopRight
                                   TargetCorner_BottomLeft:NULL
                                  TargetCorner_BottomRight:NULL];
        }
    }
    
    return _btnViewer;
}

-(void)btnClickEvent:(UIButton *)sender{
    
    for (UIButton *btn in self.btnMutArr) {
        
        btn.selected = NO;
    }
    
    sender.selected = YES;
    
    for (UIButton *btn in self.btnMutArr) {
        
        if (btn.selected) {
            
            btn.backgroundColor = kWhiteColor;
            
            [btn setTitleColor:kBlueColor
                      forState:UIControlStateSelected];
        }else{
            
            btn.backgroundColor = kBlackColor;
            
            [btn setTitleColor:kWhiteColor
                      forState:UIControlStateNormal];
        }
    }
   
    switch (sender.tag) {
        case 0:{

            [self.view bringSubviewToFront:self.amusementVC.view];
        }
            break;

        case 1:{

            [self.view bringSubviewToFront:self.teamNewsVC.view];
        }
            break;

        case 2:{

            [self.view bringSubviewToFront:self.competitionNewsVC.view];
        }
            break;

        default:
            break;
    }
}

-(NSMutableArray *)dataMutArr{
    
    if (!_dataMutArr) {
        
        _dataMutArr = NSMutableArray.array;
        
        [_dataMutArr addObject:@"赛事相关"];
        
        [_dataMutArr addObject:@"战队动态"];
        
        [_dataMutArr addObject:@"娱乐周围"];
    }
    
    return _dataMutArr;
}

-(NSMutableArray *)btnMutArr{
    
    if (!_btnMutArr) {
        
        _btnMutArr = NSMutableArray.array;
    }
    
    return _btnMutArr;
}

-(YGAmusementVC *)amusementVC{
    
    if (!_amusementVC) {
        
        _amusementVC = YGAmusementVC.new;
        
        [self addChildViewController:_amusementVC];
        
        [self.view addSubview:_amusementVC.view];
        
        [_amusementVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.bottom.equalTo(self.view);
            
            make.top.equalTo(self.btnViewer.mas_bottom);
        }];
    }
    
    return _amusementVC;
}

-(YGTeamNewsVC *)teamNewsVC{
    
    if (!_teamNewsVC) {
        
        _teamNewsVC = YGTeamNewsVC.new;
        
        [self addChildViewController:_teamNewsVC];
        
        [self.view addSubview:_teamNewsVC.view];
        
        [_teamNewsVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.bottom.equalTo(self.view);
            
            make.top.equalTo(self.btnViewer.mas_bottom);
        }];
    }
    
    return _teamNewsVC;
}

-(YGCompetitionNewsVC *)competitionNewsVC{
    
    if (!_competitionNewsVC) {
        
        _competitionNewsVC = YGCompetitionNewsVC.new;
        
        [self addChildViewController:_competitionNewsVC];
        
        [self.view addSubview:_competitionNewsVC.view];
        
        [_competitionNewsVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.bottom.equalTo(self.view);
            
            make.top.equalTo(self.btnViewer.mas_bottom);
        }];
    }
    
    return _competitionNewsVC;
}



@end
