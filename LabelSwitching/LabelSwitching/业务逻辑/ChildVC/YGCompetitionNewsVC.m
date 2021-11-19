//
//  YGCompetitionNewsVC.m
//  YG_electronicSports
//
//  Created by hello on 2019/6/29.
//  Copyright © 2019 YG_Corp. All rights reserved.
//

#import "YGCompetitionNewsVC.h"

#import "YGNewsTBVCell.h"

@interface YGCompetitionNewsVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation YGCompetitionNewsVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.tableView.alpha = 1;
    
    self.tableView.backgroundColor = KBrownColor;
}

-(UITableView *)tableView{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero
                                                 style:UITableViewStylePlain];
        
        _tableView.dataSource = self;
        
        _tableView.delegate = self;
        
        _tableView.tableHeaderView = UIView.new;
        
        _tableView.tableFooterView = UIView.new;
        
        [self.view addSubview:_tableView];
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.left.right.bottom.equalTo(self.view);
        }];
    }
    
    return _tableView;
}

#pragma mark -- <UITableViewDelegate,UITableViewDataSource>

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [YGNewsTBVCell cellHeight:NULL];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YGNewsTBVCell *cell = [YGNewsTBVCell cellWith:tableView];
    
    NSDictionary *dd = NSDictionary.dictionary;
    
    [cell richElementsInCellWithModel:dd];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:{
            
            
        }
            break;
        case 1:{
            
            
        }
            break;
        case 2:{
            
            
        }
            break;
            
        default:
            break;
    }
}

@end
