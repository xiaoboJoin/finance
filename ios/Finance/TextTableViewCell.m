//
//  TextTableViewCell.m
//  Finance
//
//  Created by Bob on 2017/6/28.
//  Copyright © 2017年 Bob. All rights reserved.
//

#import "TextTableViewCell.h"

@implementation TextTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.textAlignment = NSTextAlignmentLeft;
        self.textLabel.font = [UIFont systemFontOfSize:17];
        self.textLabel.textColor = [UIColor blackColor];
        self.detailTextLabel.font = [UIFont systemFontOfSize:17];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

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
    self.textLabel.textAlignment = NSTextAlignmentLeft;
    [self.textLabel setFrame:CGRectMake(self.separatorInset.left, 0, 96-self.separatorInset.left, self.contentView.bounds.size.height)];
    [self.detailTextLabel setFrame:CGRectMake(96, 0, self.contentView.bounds.size.width-96, self.contentView.bounds.size.height)];
}

@end
