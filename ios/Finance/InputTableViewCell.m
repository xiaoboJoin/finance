//
//  InputTableViewCell.m
//  Finance
//
//  Created by Bob on 2017/6/28.
//  Copyright © 2017年 Bob. All rights reserved.
//

#import "InputTableViewCell.h"
#import <Masonry.h>


@implementation InputTableViewCell
@synthesize textField;

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
    [self.textField setFrame:CGRectMake(96, 0,self.contentView.bounds.size.width-96 , self.contentView.bounds.size.height)];
    
}


@end
