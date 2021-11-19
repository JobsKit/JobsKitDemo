//
//  YGNewsTBVCell.m
//  YG_electronicSports
//
//  Created by hello on 2019/6/29.
//  Copyright © 2019 YG_Corp. All rights reserved.
//

#import "YGNewsTBVCell.h"

@interface YGNewsTBVCell (){
    
    
}

@property(nonatomic,strong)UIImageView *imageViewer;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)UILabel *readNumLab;


@end

@implementation YGNewsTBVCell

+(instancetype)cellWith:(UITableView *)tableView{
    
    YGNewsTBVCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];
    
    if (!cell) {
        
        cell = [[YGNewsTBVCell alloc]initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:ReuseIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

+(CGFloat)cellHeight:(id)model{
    
    return MAINSCREEN_HEIGHT / 7;
}

-(void)richElementsInCellWithModel:(id)model{
    
    self.imageViewer;
    
    self.titleLab;
//
    self.timeLab;
//
    self.readNumLab;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style
                    reuseIdentifier:reuseIdentifier]) {
        
        //        self.backgroundColor = RandomColor;
        
    }
    
    return self;
}

-(UIImageView *)imageViewer{
    
    if (!_imageViewer) {
        
        _imageViewer = UIImageView.new;
        
        _imageViewer.backgroundColor = KYellowColor;
        
        [UIView cornerCutToCircleWithView:_imageViewer
                          AndCornerRadius:5.f];
        
        [self.contentView addSubview:_imageViewer];
        
        [_imageViewer mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.left.equalTo(self.contentView).offset(SCALING_RATIO(5));
            
            make.bottom.equalTo(self.contentView).offset(-SCALING_RATIO(5));

            make.width.mas_equalTo(MAINSCREEN_WIDTH / 3);
//            make.width.mas_equalTo(100);
        }];
    }
    
    return _imageViewer;
}

-(UILabel *)titleLab{
    
    if (!_titleLab) {
        
        _titleLab = UILabel.new;
        
        _titleLab.backgroundColor = RandomColor;
        
        [self.contentView addSubview:_titleLab];
        
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.imageViewer);
            
            make.bottom.equalTo(self.contentView.mas_centerY).offset(SCALING_RATIO(-10));
            
            make.right.equalTo(self.contentView).offset(SCALING_RATIO(-5));
            
            make.left.equalTo(self.imageViewer.mas_right).offset(SCALING_RATIO(5));
        }];
    }
    
    return _titleLab;
}

-(UILabel *)timeLab{
    
    if (!_timeLab) {
        
        _timeLab = UILabel.new;
        
        _timeLab.backgroundColor = RandomColor;
        
        [self.contentView addSubview:_timeLab];
        
        [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(self.imageViewer);
            
            make.top.equalTo(self.contentView.mas_centerY).offset(SCALING_RATIO(10));
            
            make.width.mas_equalTo(MAINSCREEN_WIDTH / 3);
            
            make.left.equalTo(self.imageViewer.mas_right).offset(SCALING_RATIO(5));
        }];
    }
    
    return _timeLab;
}

-(UILabel *)readNumLab{
    
    if (!_readNumLab) {
        
        _readNumLab = UILabel.new;
        
        _readNumLab.backgroundColor = RandomColor;
        
        [self.contentView addSubview:_readNumLab];
        
        [_readNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.top.equalTo(self.timeLab);
            
            make.width.mas_equalTo(MAINSCREEN_WIDTH / 5);
            
            make.right.equalTo(self.contentView).offset(SCALING_RATIO(-5));
        }];
    }
    
    return _readNumLab;
}

@end
