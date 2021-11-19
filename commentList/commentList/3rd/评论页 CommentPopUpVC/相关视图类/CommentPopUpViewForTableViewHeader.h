//
//  CommentPopUpNonHoveringHeaderView.h
//  My_BaseProj
//
//  Created by Jobs on 2020/10/2.
//  Copyright © 2020 Jobs. All rights reserved.
//

#import "ViewForTableViewHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommentPopUpViewForTableViewHeader : ViewForTableViewHeader

@property(nonatomic,assign)long indexSection;

-(instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier
                              withData:(id)data;

-(void)actionBlockCommentPopUpNonHoveringHeaderView:(MKDataBlock _Nullable)commentPopUpNonHoveringHeaderViewBlock;

@end

NS_ASSUME_NONNULL_END
