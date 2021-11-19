//
//  ViewController.m
//  MJExtension字典转模型
//
//  Created by Jobs on 2020/7/24.
//  Copyright © 2020 wanglei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property(nonatomic,strong)MKCommentModel *commentModel;
@property(nonatomic,strong)NSMutableArray <MKCommentModel *>* commentModelMutArr;
@property(nonatomic,strong)NSMutableArray <MKFirstCommentModel *>*firstCommentModelMutArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self KKK];
    [self MMM];
}

-(void)MMM{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MKData" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    self.commentModel = [MKCommentModel mj_objectWithKeyValues:dic[@"data"]];
    NSLog(@"%d",self.commentModel.endRow.intValue);
    self.commentModel.listMytArr = [MKFirstCommentModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"list"]];
    MKFirstCommentModel *firstCommentModel = nil;
    for (int i = 0; i < self.commentModel.listMytArr.count; i++) {
        firstCommentModel = self.commentModel.listMytArr[i];
        NSLog(@"%@",firstCommentModel.content);
        firstCommentModel.childMutArr = [MKChildCommentModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"list"][i][@"child"]];
        for (MKChildCommentModel *childCommentModel in firstCommentModel.childMutArr) {
            NSLog(@"%@",childCommentModel.content);
        }
    }
    NSLog(@"");
}

-(void)KKK{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"MKData" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];

    self.commentModel = [MKCommentModel mj_objectWithKeyValues:dic[@"data"]];
    self.commentModel.listMytArr = [MKFirstCommentModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"list"]];
    if (self.commentModel.listMytArr) {
        [self.commentModel.listMytArr enumerateObjectsUsingBlock:^(id  _Nonnull obj,
                                                                   NSUInteger idx,
                                                                   BOOL * _Nonnull stop) {
            MKFirstCommentModel *firstCommentModel = self.commentModel.listMytArr[idx];
            [self.commentModel.listMytArr enumerateObjectsUsingBlock:^(MKFirstCommentModel * _Nonnull obj,
                                                                       NSUInteger idx,
                                                                       BOOL * _Nonnull stop) {
                firstCommentModel.childMutArr = [MKChildCommentModel mj_objectArrayWithKeyValuesArray:dic[@"data"][@"list"][idx][@"child"]];
                NSLog(@"");
            }];

            [self.firstCommentModelMutArr addObject:firstCommentModel];
            NSLog(@"");
        }];
    }
    NSLog(@"");
}

-(NSMutableArray<MKFirstCommentModel *> *)firstCommentModelMutArr{
    if (!_firstCommentModelMutArr) {
        _firstCommentModelMutArr = NSMutableArray.array;
    }return _firstCommentModelMutArr;
}



@end
