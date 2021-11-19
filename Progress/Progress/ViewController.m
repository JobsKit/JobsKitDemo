//
//  ViewController.m
//  Progress
//
//  Created by 1 on 2020/11/18.
//  Copyright © 2020 1. All rights reserved.
//

#import "ViewController.h"
#import "PHCycleView.h"

@interface ViewController ()

@property (nonatomic,strong) PHCycleView *progressView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.progressView.alpha = 1;
}

#pragma mark —— lazyLoad
-(PHCycleView *)progressView{
    if (!_progressView) {
        _progressView = [[PHCycleView alloc]initWithFrame:CGRectMake(0, 0, 130, 130)];
        _progressView.center = self.view.center;
        _progressView.backgroundColor = [UIColor clearColor];
        [_progressView setProgressColor:[UIColor blueColor]];
        _progressView.progressFont = [UIFont systemFontOfSize:30];
        [self.view addSubview:_progressView];
        [_progressView updateProgress:50];
        [_progressView setLinePreAngle:15 lineSize:CGSizeMake(3, 10) color:[UIColor redColor]];
        _progressView.describeFont = [UIFont systemFontOfSize:12];
        _progressView.describeStr = @"历史最高分";
        _progressView.progressTextColor = [UIColor blackColor];
        _progressView.describeTextColor = [UIColor blackColor];
        _progressView.outLayerColor = [UIColor colorWithRed:0 green:0 blue:255 alpha:0.3];
    }return _progressView;
}


@end
