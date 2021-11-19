//
//  MyFansTBVCell.m
//  MonkeyKingVideo
//
//  Created by Jobs on 2020/7/3.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "MyFansTBVCell.h"

@interface MyFansTBVCell ()

@end

@implementation MyFansTBVCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    MyFansTBVCell *cell = (MyFansTBVCell *)[tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    if (!cell) {
        cell = [[MyFansTBVCell alloc]initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:ReuseIdentifier];
        cell.marginX = 10;
        cell.marginY = 20;
        //加阴影立体效果
        [UIView makeTargetShadowview:cell
                           superView:nil
                     shadowDirection:ShadowDirection_rightDown
                   shadowWithOffsetX:5
                             offsetY:5
                        cornerRadius:8
                        shadowOffset:DefaultSize
                       shadowOpacity:1
                    layerShadowColor:DefaultObj
                   layerShadowRadius:DefaultValue];
    }return cell;
}

-(void)drawRect:(CGRect)rect{

}

+(CGFloat)cellHeightWithModel:(id _Nullable)model{
    return 238;
}

- (void)richElementsInCellWithModel:(id _Nullable)model{
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:@" "]
                    placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpeg",[model intValue]]]];
//    self.textLabel.text = @"Test";
//    self.detailTextLabel.text = @"test";
}

-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = UIImageView.new;
        _imgView.clipsToBounds = YES;
        _imgView.layer.cornerRadius = 20;
        [self.contentView addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }return _imgView;
}


@end
