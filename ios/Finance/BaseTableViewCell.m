//
//  BaseTableViewCell.m
//  Finance
//
//  Created by Bob on 2017/7/5.
//  Copyright © 2017年 Bob. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
//    
//    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSLog(@"class:%@",NSStringFromClass([obj class]));
//        if ([obj isKindOfClass:NSClassFromString(@"_UITableViewCellSeparatorView")]) {
//            if (idx) {
//                [obj setHidden:YES];
//            }
//        }
//    }];
    
}

@end
