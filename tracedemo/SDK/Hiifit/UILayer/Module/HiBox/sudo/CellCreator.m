//
//  CellCreator.m
//  ShuDu
//
//  Created by hermit on 15/3/18.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import "CellCreator.h"


@implementation CellCreator

//+ (instancetype)sharedCreator
//{
//    static dispatch_once_t onceToken;
//    static CellCreator *shared;
//    if (shared == nil) {
//        dispatch_once(&onceToken, ^{
//            shared = [[CellCreator alloc]init];
//        });
//    }
//    return shared;
//}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _myCells = [[NSMutableArray alloc]initWithCapacity:81];
        _bgImages = [[NSMutableArray alloc]initWithCapacity:9];
        _selectBtns = [[NSMutableArray alloc]initWithCapacity:9];
        
        UIImage *lanscapeImage = [[UIImage imageNamed:@"landscape_indicator"]resizableImageWithCapInsets:UIEdgeInsetsMake(15, 25, 15, 25)];
        UIImage *protraitImage = [[UIImage imageNamed:@"portrait_indicator"]resizableImageWithCapInsets:UIEdgeInsetsMake(25, 15, 25, 15)];
        UIImage *indicatorImage = [[UIImage imageNamed:@"blank_highlighted"]resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
        
        _lanscapeImage = [[UIImageView alloc]initWithImage:lanscapeImage];
        _protraitImage = [[UIImageView alloc]initWithImage:protraitImage];
        _indicatorImage = [[UIImageView alloc]initWithImage:indicatorImage];
        
        _markBtn = [[UIButton alloc]init];
        _voiceBtn = [[UIButton alloc]init];
       
    }
    return self;
}
//初始化数独
- (BOOL)initializeGameCells:(NSDictionary *)cellsDic inView:(UIView *)view;
{
    NSAssert(cellsDic != nil, @"cells can't be nil");
    
    NSArray *values = [cellsDic objectForKey:kValueKey];
    NSArray *blanks = [cellsDic objectForKey:kBlankKey];
    
    NSAssert(values.count == 81, @"values's count is not 81");
    NSAssert(blanks.count == 81, @"blanks's count is not 81");
    
    [_myCells removeAllObjects];
    [_bgImages removeAllObjects];
    [_selectBtns removeAllObjects];
    _selectedIndex = -1;
    _finishedFlag = 0;
    _seconds = 0;
    errorCount = 0;
    _lanscapeImage.frame = CGRectMake(kCellSpace - 4, kCellSpace - 4, kScreenWidth - 2*kCellSpace + 8, kCellWidth+6);
    _protraitImage.frame = CGRectMake(kCellSpace - 4, kCellSpace - 4, kCellWidth + 6, kScreenWidth - 2*kCellSpace + 8);
    _indicatorImage.frame = CGRectMake(0, 0, kHighlitedWidth+8, kHighlitedWidth+8);
    _lanscapeImage.hidden = YES;
    _protraitImage.hidden = YES;
    _indicatorImage.hidden = YES;
    
    _markBtn.frame = CGRectMake(kScreenWidth-95-(kScreenWidth-9*kCellWidth)/2, kScreenHeight-kCellSpace-kBottomHeight-50 - 64, 95, 50);
    _markBtn.backgroundColor = [UIColor clearColor];
    [_markBtn setBackgroundImage:[UIImage imageNamed:@"mark"] forState:UIControlStateNormal];
    [_markBtn setBackgroundImage:[UIImage imageNamed:@"write"] forState:UIControlStateSelected];
    [_markBtn addTarget:self action:@selector(markAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_markBtn];
    
    _voiceBtn.frame = CGRectMake(_markBtn.frame.origin.x-12-57, _markBtn.frame.origin.y+3, 57, 43);
    [_voiceBtn setBackgroundImage:[UIImage imageNamed:@"button_sound_on"] forState:UIControlStateNormal];
    [_voiceBtn setBackgroundImage:[UIImage imageNamed:@"button_sound_off"] forState:UIControlStateSelected];
    [_voiceBtn addTarget:self action:@selector(controlVoice:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_voiceBtn];
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-9*kCellWidth)/2, kScreenHeight-kCellSpace-kBottomHeight-43 - 64, 100, 40)];
    timeLabel.textColor = [UIColor colorWithRed:151.0/255.0 green:151.0/255.0 blue:151.0/255.0 alpha:1];
    timeLabel.text = @"00:00:00";
    timeLabel.font = [UIFont boldSystemFontOfSize:20];
    //timeLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:timeLabel];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(time:) userInfo:timeLabel repeats:YES];

    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
    
    for (NSInteger i=0; i<kGridNum; i++)
    {
        for (NSInteger j=0; j<kGridNum; j++)
        {
            NSInteger value = [[values objectAtIndex:i*kGridNum+j]integerValue];
            NSInteger flag = [[blanks objectAtIndex:i*kGridNum+j]integerValue];
            BOOL blank = flag == 0 ? YES:NO;
            if (blank) {
                _finishedFlag += 1;
            }
            Cell *cell = [[Cell alloc]initWithX:i andY:j];
            cell.tag = i*kGridNum + j;
            [cell setValue:value isBlank:blank];
            [cell.cellBtn addTarget:self action:@selector(touchCell:) forControlEvents:UIControlEventTouchUpInside];
            [_myCells addObject:cell];
            [view addSubview:cell];
        }
        
        UIImageView *bgImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"number_normal"]];
        bgImage.frame = CGRectMake((kScreenWidth-9*kCellWidth)/2 + i*kCellWidth, view.frame.size.height-kCellSpace-kBottomHeight, kCellWidth, kBottomHeight);
        bgImage.tag = 100 + i + 1;
        bgImage.userInteractionEnabled = YES;
        [_bgImages addObject:bgImage];
        [view addSubview:bgImage];
        
        UIButton *bt = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, kCellWidth, kCellWidth)];
        bt.backgroundColor = [UIColor clearColor];
        [bt.titleLabel setFont:[UIFont fontWithName:@"Futura-Mediumltalic" size:18]];
        [bt setTitle:[NSString stringWithFormat:@"%@",@(i+1)] forState:UIControlStateNormal];
        [bt setBackgroundImage:[UIImage imageNamed:@"number"] forState:UIControlStateNormal];
        [bt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bgImage addSubview:bt];
        
        UIButton *selectBtn = [[UIButton alloc]initWithFrame:CGRectMake(bgImage.frame.origin.x, bgImage.frame.origin.y, kCellWidth, kCellWidth)];
        selectBtn.backgroundColor = [UIColor clearColor];
        selectBtn.tag = i + 1;
        [selectBtn.titleLabel setFont:[UIFont fontWithName:@"Futura-Mediumltalic" size:18]];
        [selectBtn setTitle:[NSString stringWithFormat:@"%@",@(i+1)] forState:UIControlStateNormal];
        [selectBtn setBackgroundImage:[UIImage imageNamed:@"number"] forState:UIControlStateNormal];
        [selectBtn setBackgroundImage:[UIImage imageNamed:@"num_selected"] forState:UIControlStateSelected];
        [selectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [selectBtn addTarget:self action:@selector(selectCell:) forControlEvents:UIControlEventTouchUpInside];
        [_selectBtns addObject:selectBtn];
        [view addSubview:selectBtn];

    }
    
    [view addSubview:_lanscapeImage];
    [view addSubview:_protraitImage];
    [view addSubview:_indicatorImage];
    return YES;
}
//选中目标
- (void)touchCell:(UIButton*)bt
{
    if (self.selectedIndex == bt.tag) {
        return;
    }
    if (self.markBtn.selected == YES) {
        [self setBottomStatusUnmark];
    }
    self.selectedIndex = bt.tag;
    Cell *cell = [_myCells objectAtIndex:bt.tag];
    if (cell.isBlank) {
        [[AFSoundManager sharedManager]startPlayingLocalFileWithName:@"click_blank.wav" andBlock:nil];
        if (self.markBtn.selected == YES) {
            [self traverseBottomStatus:cell.discreetLabel.text];
        }
        self.indicatorImage.center = cell.center;
        self.indicatorImage.hidden = NO;
        
        if (self.protraitImage.hidden == YES) {
            self.lanscapeImage.center = CGPointMake(self.lanscapeImage.center.x, cell.center.y);
            self.protraitImage.center = CGPointMake(cell.center.x, self.protraitImage.center.y);
            self.lanscapeImage.hidden = NO;
            self.protraitImage.hidden = NO;
            [self traverseCells:_myCells andCell:cell];
        }else{
            WS(weakSelf)
            [UIView animateWithDuration:0.2f animations:^{
                weakSelf.lanscapeImage.center = CGPointMake(weakSelf.lanscapeImage.center.x, cell.center.y);
                weakSelf.protraitImage.center = CGPointMake(cell.center.x, weakSelf.protraitImage.center.y);
            } completion:^(BOOL finished) {
                if (finished) {
                    [weakSelf traverseCells:weakSelf.myCells andCell:cell];
                }
            }];
        }
    }else{
        [[AFSoundManager sharedManager]startPlayingLocalFileWithName:@"click_number.wav" andBlock:nil];
        self.lanscapeImage.hidden = YES;
        self.protraitImage.hidden = YES;
        self.indicatorImage.hidden = YES;
        [self traverseCells:self.myCells andCell:cell];
    }
}

- (void)setBottomStatusUnmark
{
    for (int j = 0; j < self.selectBtns.count; j++) {
        UIButton *btn = [self.selectBtns objectAtIndex:j];
        btn.selected = NO;
    }
}

//修改底部按钮的背景状态
- (void)traverseBottomStatus:(NSString *)values
{
    if (values.length == 0) {
        return;
    }
    NSString *valueStr = [values stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    for (int i = 0; i < valueStr.length; i++) {
        NSString *value = [valueStr substringWithRange:NSMakeRange(i, 1)];
        for (int j = 0; j < self.selectBtns.count; j++) {
            UIButton *btn = [self.selectBtns objectAtIndex:j];
            if (btn.tag == [value integerValue]) {
                btn.selected = YES;
                break;
            }
        }
    }
}
//标记状态还是写入状态
- (void)markAction:(UIButton*)markBtn
{
    [MobClick event:Sudo_Game_Write];
    if (markBtn.selected) {
        [self setBottomStatusUnmark];
    }else{
        [MobClick event:Sudo_Game_Make_Click];
        if (self.selectedIndex >= 0) {
            Cell *cell = [self.myCells objectAtIndex:self.selectedIndex];
            if (cell.isBlank) {
                [self traverseBottomStatus:cell.discreetLabel.text];
            }
        }
    }
    markBtn.selected = !markBtn.selected;
    
}

//开／关声音
- (void)controlVoice:(UIButton *)btn
{
    [AFSoundManager sharedManager].keepSilence = !btn.selected;
    btn.selected = !btn.selected;
}

//遍历数独数组并修改状态
- (void)traverseCells:(NSArray *)cells andCell:(Cell *)c
{
    int flag = 0;
    for (NSInteger i = 0; i < cells.count; i++) {
        Cell *cell = [cells objectAtIndex:i];
        if (c.isBlank) {
            cell.higlitedImageView.hidden = YES;
        }else{
            if (cell.value == c.value) {
                if (!cell.isBlank) {
                    cell.higlitedImageView.hidden = NO;
                    flag = flag + 1;
                }else{
                    cell.higlitedImageView.hidden = YES;
                }
            }else{
                cell.higlitedImageView.hidden = YES;
            }
        }
    }
    if (flag == kGridNum) {
        UIImageView *imageView = [_bgImages objectAtIndex:c.value - 1];
        [imageView removeFromSuperview];
        
        UIButton *button = [_selectBtns objectAtIndex:c.value - 1];
        [button removeFromSuperview];
        
        if (_finishedFlag == 0) {
            NSLog(@"Game over !");
            if (_delegate && [_delegate respondsToSelector:@selector(gameOver:isSuccess:)]) {
                [_timer invalidate];
                _timer = nil;
                [_delegate gameOver:_seconds isSuccess:YES];
            }
        }
    }
}
//点击底部按钮进行选择或标记
- (void)selectCell:(UIButton*)bt
{
    [[AFSoundManager sharedManager]startPlayingLocalFileWithName:@"select_number.wav" andBlock:nil];
    if (self.selectedIndex < 0) {
        Cell *ce = [[Cell alloc]init];
        ce.value = bt.tag;
        ce.blank = NO;
        [self traverseCells:self.myCells andCell:ce];
        return;
    }
    
    Cell *cell = [_myCells objectAtIndex:self.selectedIndex];
    if (!cell.isBlank) {
        Cell *ce = [[Cell alloc]init];
        ce.value = bt.tag;
        ce.blank = NO;
        [self traverseCells:self.myCells andCell:ce];
        return;
    }
    if (self.markBtn.selected) {
        NSString *markValues = [cell.discreetLabel.text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        if (!markValues) {
            markValues = @"";
        }
        NSMutableString *markCopy = [[NSMutableString alloc]initWithString:markValues];
        for (int k = 0; k < markValues.length; k++) {
            NSString *value = [markValues substringWithRange:NSMakeRange(k, 1)];
            if (bt.tag == [value integerValue]) {
                [markCopy deleteCharactersInRange:NSMakeRange(k, 1)];
                break;
            }
        }
        if (markCopy.length == markValues.length) {
            [markCopy appendFormat:@"%i",(int)bt.tag];
        }
        if (markCopy.length > 3 && markCopy.length <= 6) {
            [markCopy insertString:@"\n" atIndex:3];
        }else if (markCopy.length > 6) {
            [markCopy insertString:@"\n" atIndex:3];
            [markCopy insertString:@"\n" atIndex:7];
        }
        [cell setValueMarkLabel:markCopy];
        bt.selected = !bt.selected;
        return;
    }
    CGPoint startPoint = bt.center;
    CGPoint endPoint = cell.center;
    [bt bringToFront];
    WS(weakSelf)
    [UIView animateWithDuration:0.2f animations:^{
        bt.center = endPoint;
    } completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:0.1f animations:^{
                bt.transform = CGAffineTransformMakeRotation(-M_PI_4);
            } completion:^(BOOL finished) {
                if (finished) {
                    [UIView animateWithDuration:0.1f animations:^{
                        bt.transform = CGAffineTransformMakeRotation(0);
                    } completion:^(BOOL finished) {
                        if (finished) {
                            if (cell.value == bt.tag) {
                                //NSLog(@"Right !");
                                [[AFSoundManager sharedManager]startPlayingLocalFileWithName:@"right.wav" andBlock:nil];
                                _finishedFlag -= 1;
                                [cell showTheNumber];
                                weakSelf.lanscapeImage.hidden = YES;
                                weakSelf.protraitImage.hidden = YES;
                                weakSelf.indicatorImage.hidden = YES;
                                [weakSelf.myCells replaceObjectAtIndex:weakSelf.selectedIndex withObject:cell];
                                [weakSelf traverseCells:weakSelf.myCells andCell:cell];
                                bt.center = startPoint;
                            }else{
                                //NSLog(@"Wrong !");
                                [[AFSoundManager sharedManager]startPlayingLocalFileWithName:@"error.wav" andBlock:nil];
                                errorCount = errorCount + 1;
                                [UIView animateWithDuration:0.2f animations:^{
                                    bt.center = startPoint;
                                } completion:^(BOOL finished) {
                                    if (errorCount == 4) {
                                        if (_delegate && [_delegate respondsToSelector:@selector(gameOver:isSuccess:)]) {
                                            [_timer invalidate];
                                            _timer = nil;
                                            [_delegate gameOver:_seconds isSuccess:NO];
                                        }
                                    }
                                }];
                            }
                        }
                    }];
                }
            }];
        }
    }];
}

- (void)time:(NSTimer*)timer
{
    UILabel *timeLabel = (UILabel*)[timer userInfo];
    _seconds ++;
    [timeLabel setText:[UIKitTool getTimeStrFromUTC:_seconds]];
}

- (void)dealloc
{
    [_timer invalidate];
    _timer = nil;
}

@end
