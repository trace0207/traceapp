//
//  HFHabitHeaderCell.m
//  GuanHealth
//
//  Created by hermit on 15/6/1.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFHabitHeaderCell.h"

@interface HFHabitHeaderCell()
{
    UILabel * titleLabel;
}
@end

@implementation HFHabitHeaderCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 12, 100, 18)];
        titleLabel.font = [UIFont systemFontOfSize:12.0f];
        titleLabel.textColor = [UIColor HFColorStyle_2];
        [self addSubview:titleLabel];
        
        UIImageView *rightImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width- 16 -6, 12+4, 6, 9)];
        rightImage.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        [rightImage setImage:IMG(@"cusp_right")];
        [self addSubview:rightImage];
        
        UILabel *moreLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width - rightImage.frame.size.width - 16 - 5 - 60, 12, 60, 18)];
        moreLabel.font = [UIFont systemFontOfSize:12.0f];
        moreLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        moreLabel.textColor = [UIColor HFColorStyle_5];
        moreLabel.text = @"更多";
        moreLabel.textAlignment = NSTextAlignmentRight;
        [self addSubview:moreLabel];
        
        UIButton *moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width - 100, 4, 100, 30)];
        moreBtn.backgroundColor = [UIColor clearColor];
        moreBtn.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        [moreBtn addTarget:self action:@selector(goHabitView:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:moreBtn];
        
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, moreBtn.frame.origin.y+moreBtn.frame.size.height, kScreenWidth, kHabitWidth)];
        _scrollView.alwaysBounceVertical = NO;
        _scrollView.alwaysBounceHorizontal = YES;
        _scrollView.pagingEnabled = NO;
        _scrollView.scrollsToTop = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:_scrollView];
        
        self.addItem = [[CommonItem alloc]initWithFrame:CGRectMake(0, 15, kHabitWidth, kHabitWidth)];
        self.addItem.center = CGPointMake(_scrollView.frame.size.width/2, _scrollView.frame.size.height/2);
        self.addItem.textLabel.font = [UIFont systemFontOfSize:12];
        [self.addItem.textLabel setTextColor:[UIColor HFColorStyle_2]];
        self.addItem.delegate = self;
        self.addItem.tag = 10086;
        HFHabitAlarmClockData *habit = [[HFHabitAlarmClockData alloc]init];
        habit.habitName = @"添加";
        habit.habitIconUrl = @"add_picture";
        habit.habitId = 10086;
        _scrollView.scrollEnabled = NO;
        [self.addItem setContentToCell:habit];
        [_scrollView addSubview:self.addItem];
        
//        _separatorLine = [[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height - 1, kScreenWidth, 1)];
//        _separatorLine.backgroundColor = [UIColor HFLightGrayColor];
//        _separatorLine.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
//        [self addSubview:_separatorLine];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -
#pragma mark public
- (void)headerTitle:(NSString *)title
{
    titleLabel.text = title;
}

- (void)setHabitsToCell:(NSArray*)sources
{
    for (NSUInteger j = 0; j < self.habitsCount; j++) {
        UIView *view = [self viewWithTag:j+100];
        if (view) {
            [view removeFromSuperview];
        }
    }
    
    if (self.itemType == HFItemTypeHabit) {
        self.addItem.hidden = NO;
        if (sources.count == 0) {
            _scrollView.scrollEnabled = NO;
            self.addItem.center = CGPointMake(kScreenWidth/2.0f, self.addItem.center.y);
        }else if (sources.count <=3) {
            _scrollView.scrollEnabled = NO;
            self.addItem.frame = CGRectMake(sources.count*kHabitWidth, self.addItem.frame.origin.y, CGRectGetWidth(self.addItem.frame), CGRectGetHeight(self.addItem.frame));
        }else {
            _scrollView.scrollEnabled = YES;
            self.addItem.frame = CGRectMake(sources.count*kHabitWidth, self.addItem.frame.origin.y, CGRectGetWidth(self.addItem.frame), CGRectGetHeight(self.addItem.frame));
            [_scrollView setContentSize:CGSizeMake((sources.count+1)*kHabitWidth, _scrollView.frame.size.height)];
        }
    }else if (self.itemType == HFItemTypeModule) {
        if (sources.count == 0) {
            self.addItem.center = CGPointMake(kScreenWidth/2.0f, self.addItem.center.y);
            _scrollView.scrollEnabled = NO;
            self.addItem.hidden = NO;
        }else if (sources.count <= 4) {
            _scrollView.scrollEnabled = NO;
            self.addItem.hidden = YES;
        }else{
            _scrollView.scrollEnabled = YES;
            self.addItem.hidden = YES;
            [_scrollView setContentSize:CGSizeMake(sources.count*kHabitWidth, _scrollView.frame.size.height)];
        }
    }
    for (NSUInteger i = 0; i < sources.count; i++) {
        id data = [sources objectAtIndex:i];
        CommonItem *habitItem = [[CommonItem alloc]initWithFrame:CGRectMake(i * kHabitWidth, 0, kHabitWidth, kHabitWidth)];
        habitItem.tag = i + 100;
        habitItem.delegate = self;
        [habitItem setContentToCell:data];
        [_scrollView addSubview:habitItem];
        
        if ([data isKindOfClass:[HFHabitListData class]])
        {
            HFHabitListData * habitData = (HFHabitListData *)data;
            habitItem.finishImage.hidden = habitData.flag == 1 ? NO : YES;
        }
        
        if (i == sources.count - 1) {
            self.habitsCount = sources.count;
        }
    }
    [_scrollView setContentOffset:CGPointZero animated:NO];
}

- (void)goHabitView:(UIButton*)btn
{
    if (_delegate && [_delegate respondsToSelector:@selector(moreActionWithCell:)]) {
        [_delegate moreActionWithCell:self];
    }
}

#pragma mark item delegate
- (void)chooseHabitItem:(CommonItem*)item  withTag:(NSInteger)tag
{
    if (tag == 10086) {
        if (_delegate && [_delegate respondsToSelector:@selector(addActionWithCell:)]) {
            [_delegate addActionWithCell:self];
        }
    }else{
        if (_delegate && [_delegate respondsToSelector:@selector(goDetailAction:withCell:)]) {
            [_delegate goDetailAction:item withCell:self];
        }
    }
}

@end
