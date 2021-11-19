//
//  MyFansTBVCell.h
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "UITableViewCell+Margin.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyFansTBVCell : UITableViewCell

@property(nonatomic,strong)UIImageView *imgView;

+(instancetype)cellWithTableView:(UITableView *)tableView;
+(CGFloat)cellHeightWithModel:(id _Nullable)model;
- (void)richElementsInCellWithModel:(id _Nullable)model;

@end

NS_ASSUME_NONNULL_END
