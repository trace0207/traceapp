//
//  HabitItem.m
//  GuanHealth
//
//  Created by hermit on 15/4/9.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "CommonItem.h"


@implementation CommonItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        CGFloat width = MIN(frame.size.width, frame.size.height) ;
        _iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width-0.5*width)/2, 0.1*width, 0.5f*width, 0.5f*width)];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [self addSubview:_iconImageView];
        _iconImageView.center = CGPointMake(frame.size.width*0.5, _iconImageView.center.y);
        
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _iconImageView.frame.origin.y+_iconImageView.frame.size.height, frame.size.width, frame.size.height-_iconImageView.frame.origin.y-_iconImageView.frame.size.height)];
        _textLabel.center = CGPointMake(frame.size.width*0.5, _textLabel.center.y);
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.textColor = [UIColor hexChangeFloat:@"333333" withAlpha:1.0f];
        
        _textLabel.font = [UIFont systemFontOfSize:13];
        [self addSubview:_textLabel];
        
        _chooseBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [_chooseBtn addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_chooseBtn];
        
        _cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0.2*width, 0.2*width)];
        _cancelBtn.center = CGPointMake(_iconImageView.frame.origin.x, _iconImageView.frame.origin.y);
        _cancelBtn.hidden = YES;
        [_cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [_cancelBtn setBackgroundImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
        [self addSubview:_cancelBtn];
        
        _finishImage = [[UIImageView alloc]initWithFrame:CGRectMake(_iconImageView.frame.origin.x+_iconImageView.frame.size.width*2/3, _iconImageView.frame.origin.y+_iconImageView.frame.size.height*2/3, _iconImageView.frame.size.width/3, _iconImageView.frame.size.width/3)];
        [_finishImage setImage:IMG(@"finished")];
        _finishImage.hidden = YES;
        [self addSubview:_finishImage];
    }
    return self;
}

- (void)setActive:(BOOL)active
{
    if (active) {
        
    
    srand([[NSDate date] timeIntervalSince1970]);
    float rand=(float)random();
    CFTimeInterval t=rand*0.0000000001;
    [UIView animateWithDuration:0.1 delay:t options:0  animations:^
     {
         _iconImageView.transform=CGAffineTransformMakeRotation(-0.05);
     } completion:^(BOOL finished)
     {
         [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse|UIViewAnimationOptionAllowUserInteraction  animations:^
          {
              _iconImageView.transform=CGAffineTransformMakeRotation(0.05);
          } completion:^(BOOL finished) {}];
     }];
    }else{
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:^
         {
             _iconImageView.transform=CGAffineTransformIdentity;
         } completion:^(BOOL finished) {}];
    }
}

- (void)chooseAction:(UIButton*)btn
{
    if (_delegate && [_delegate respondsToSelector:@selector(chooseHabitItem:withTag:)]) {
        [_delegate chooseHabitItem:self withTag:self.tag];
    }
}

- (void)cancelAction:(UIButton*)btn
{
    if (_delegate && [_delegate respondsToSelector:@selector(removeHabitItem:withTag:)]) {
        [_delegate removeHabitItem:self withTag:self.tag];
    }
}

- (void)setContentToCell:(id)data
{
    self.data = data;
    if ([data isKindOfClass:[HFHabitAlarmClockData class]]) {
        HFHabitAlarmClockData *habit = (HFHabitAlarmClockData *)data;
        if ([habit.habitIconUrl hasPrefix:@"http"]) {
            [_iconImageView sd_setImageWithURL:[NSURL URLWithString:habit.habitIconUrl] placeholderImage:IMG(@"heabit")];
        }else{
            [_iconImageView setImage:IMG(habit.habitIconUrl)];
        }
        _textLabel.text = habit.habitName;
        _itemId = habit.habitId;
    }else if ([data isKindOfClass:[ModelData class]]){
        ModelData *module = (ModelData *)data;
        if ([module.picAddr hasPrefix:@"http"]) {
            [_iconImageView sd_setImageWithURL:[NSURL URLWithString:module.picAddr] placeholderImage:IMG(@"heabit")];
        }else{
            [_iconImageView setImage:IMG(module.picAddr)];
        }
        
        _textLabel.text = module.modelName;
        _itemId = module.modelId;
    }else if ([data isKindOfClass:[HFHabitListData class]]){
        HFHabitListData *habit = (HFHabitListData*)data;
        if ([habit.habitIconUrl hasPrefix:@"http"]) {
            [_iconImageView sd_setImageWithURL:[NSURL URLWithString:habit.habitIconUrl] placeholderImage:IMG(@"heabit")];
        }else{
            [_iconImageView setImage:IMG(habit.habitIconUrl)];
        }
        if (habit.habitName.length>4) {
            NSString *str = [habit.habitName substringToIndex:3];
            _textLabel.text = [NSString stringWithFormat:@"%@...",str];
        }else{
            _textLabel.text = habit.habitName;
        }
        _itemId = habit.habitId;
    }
}
@end
