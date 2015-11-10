//
//  BaseTableCell.m
//  rentCar
//
//  Created by duonuo on 14-6-26.
//  Copyright (c) 2014年 duonuo. All rights reserved.
//

#import "BaseTableCell.h"

@implementation BaseTableCell



- (id)init{
        return [self initWithIndex:0];
}

- (id)initWithXibName:(NSString*)strName{
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:strName owner:self options:nil];
    self = [nibs objectAtIndex:0];
    if (self) {
        self.cellIndex = 0;
    }
    return self;
}

- (id)initWithIndex:(NSInteger)index{
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil];
    self = [nibs objectAtIndex:index];
    if (self) {
        self.cellIndex = index;
    }
    return self;
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (CGFloat)calculateHeight
{
    self.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.bounds), 0.0f);
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
    
    CGSize size = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height;
}


@end
