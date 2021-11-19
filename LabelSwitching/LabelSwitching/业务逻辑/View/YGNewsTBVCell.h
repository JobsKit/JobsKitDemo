//
//  YGNewsTBVCell.h
//  YG_electronicSports
//
//  Created by hello on 2019/6/29.
//  Copyright © 2019 YG_Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YGNewsTBVCell : UITableViewCell

+(instancetype)cellWith:(UITableView *)tableView;

+(CGFloat)cellHeight:(id)model;

-(void)richElementsInCellWithModel:(id)model;

@end

NS_ASSUME_NONNULL_END
