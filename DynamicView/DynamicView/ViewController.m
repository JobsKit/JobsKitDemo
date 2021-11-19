//
//  ViewController.m
//  DynamicView
//
//  Created by Jobs on 2020/7/19.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

//https://www.jianshu.com/p/5cf0d241ae12

@interface ViewController ()

@property(nonatomic,strong)UIImageView *gifImageView;
@property(nonatomic,strong)NSString *path;
@property(nonatomic,strong)UIImage *image;
@property(nonatomic,strong)NSData *data;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gifImageView.alpha = 1;
}

#pragma mark —— lazyLoad
-(UIImageView *)gifImageView{
    if (!_gifImageView) {
        _gifImageView = UIImageView.new;
        _gifImageView.image = self.image;
        [self.view addSubview:_gifImageView];
        [_gifImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }return _gifImageView;
}

-(NSString *)path{
    if (!_path) {
        _path = [[NSBundle mainBundle] pathForResource:@"GIF大图"
                                                ofType:@"gif"];
    }return _path;
}

-(NSData *)data{
    if (!_data) {
        _data = [NSData dataWithContentsOfFile:self.path];
    }return _data;
}

-(UIImage *)image{
    if (!_image) {
        _image = [UIImage sd_animatedGIFWithData:self.data];
    }return _image;
}


@end
