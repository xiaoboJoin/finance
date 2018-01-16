//
//  TextInputTableViewCell.m
//  Finance
//
//  Created by Bob on 2017/11/19.
//  Copyright © 2017年 Bob. All rights reserved.
//

#import "TextInputTableViewCell.h"

@implementation TextInputTableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textField = [[UITextField alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:self.textField];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    [_textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(self.separatorInset.left);
        make.right.equalTo(self.contentView.mas_right).with.offset(self.separatorInset.right);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.top.equalTo(self.contentView.mas_top);
    }];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
