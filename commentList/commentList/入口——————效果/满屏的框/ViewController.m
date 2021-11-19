
//
//  ViewController.m
//  commentList
//
//  Created by Jobs on 2020/7/14.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "ViewController.h"
#import "LoadMoreTBVCell.h"
#import "InfoTBVCell.h"

#import "CommentPopUpViewForTableViewHeader.h"

#import "FirstClassModel.h"
#import "SecondClassModel.h"

@interface ViewController ()
<
UITableViewDelegate
,UITableViewDataSource
>

@property(nonatomic,strong)UITableView *tableView;
///所有数据一次性全部请求完
@property(nonatomic,strong)NSMutableArray <FirstClassModel *>*sources;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    self.tableView.alpha = 1;
    NSLog(@"");
}
#pragma mark —————————— UITableViewDelegate,UITableViewDataSource ——————————
- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [LoadMoreTBVCell cellHeightWithModel:nil];
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LoadMoreTBVCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:LoadMoreTBVCell.class]) {
        FirstClassModel *fcm = self.sources[indexPath.section];
        fcm.randShow += LoadDataNum;//randShow 初始值是 preMax
        if (fcm.rand > fcm.randShow) {//还有数据
            
            self.sources[indexPath.section].PreMax += LoadDataNum;
            
            fcm._hasMore = YES;
        }else{//fcm.rand = preMax + 1 + LoadDataNum 数据没了
            fcm._hasMore = NO;
        }

        if (fcm._hasMore) {
            if ((fcm.isFullShow && indexPath.row < fcm.secClsModelMutArr.count) ||
                indexPath.row < self.sources[indexPath.section].PreMax) {
                #pragma warning 点击单元格要做的事
                NSLog(@"KKK");
            }else{
                fcm.isFullShow = !fcm.isFullShow;
            }
        }else{}
    #warning 使用动画刷屏 在下面几个数据刷新的时候会闪屏
    //        [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]
    //                 withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView reloadData];
    }else{}
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section{
    if (self.sources[section].secClsModelMutArr.count > self.sources[section].PreMax &&
        self.sources[section]._hasMore &&
        !self.sources[section].isFullShow) {
        return self.sources[section].PreMax + 1;
    }else{
        return self.sources[section].secClsModelMutArr.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.sources[indexPath.section].isFullShow) {//是全显示
        InfoTBVCell *cell = [InfoTBVCell cellWithTableView:tableView];
        [cell richElementsInCellWithModel:self.sources[indexPath.section].secClsModelMutArr[indexPath.row].secondClassText];
//        cell.contentView.backgroundColor = RandomColor;
        return cell;
    }else{//不是全显示
        if (indexPath.row == self.sources[indexPath.section].PreMax &&
            self.sources[indexPath.section]._hasMore) {//
            LoadMoreTBVCell *cell = [LoadMoreTBVCell cellWithTableView:tableView];
            [cell richElementsInCellWithModel:nil];
            return cell;
        }else{
            InfoTBVCell *cell = [InfoTBVCell cellWithTableView:tableView];
//            int r = indexPath.row;
//            int d = indexPath.section;
            [cell richElementsInCellWithModel:self.sources[indexPath.section].secClsModelMutArr[indexPath.row].secondClassText];
            cell.contentView.backgroundColor = RandomColor;
            return cell;
        }
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sources.count;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section{
    return [LoadMoreTBVCell cellHeightWithModel:nil];
}

- (UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        CommentPopUpViewForTableViewHeader *header = [[CommentPopUpViewForTableViewHeader alloc] initWithReuseIdentifier:NSStringFromClass(CommentPopUpViewForTableViewHeader.class) withData:nil];
    //    self.scrollViewClass = UITableView.class;//这一属性决定UITableViewHeaderFooterView是否悬停
        
        [header actionBlockCommentPopUpNonHoveringHeaderView:^(id data) {
            
        }];
        header.backgroundColor = kRedColor;
        return header;
    }else{
        return nil;
    }
}
#pragma mark —— lazyLoad
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = UITableView.new;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:CommentPopUpViewForTableViewHeader.class
forHeaderFooterViewReuseIdentifier:NSStringFromClass(CommentPopUpViewForTableViewHeader.class)];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }return _tableView;
}

- (NSMutableArray <FirstClassModel *>*)sources{
    if(!_sources){
        _sources = NSMutableArray.array;
        for(NSInteger idx = 1; idx <= 50; idx ++){
            NSString *str = [NSString stringWithFormat:@"%ld", idx];
            FirstClassModel *hm = [FirstClassModel create:str];
            [_sources addObject:hm];
        }
    }return _sources;
}

@end
