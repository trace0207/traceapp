//
//  HFLevelView.m
//  UIButtonExtension
//
//  Created by 朱伟特 on 15/9/18.
//  Copyright (c) 2015年 朱伟特. All rights reserved.
//

#import "HFLevelView.h"

@interface HFLevelView()

@property (nonatomic, strong) NSMutableArray * imageArray;

@end
@implementation HFLevelView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self loadUI];
    }
    return self;
}
- (void)loadUI
{
    self.levelCounts = 5;
}
- (void)setLevelCounts:(NSInteger)levelCounts
{
    WS(weakSelf);
    [self.imageArray removeAllObjects];
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (int i = 0; i < levelCounts; i++) {
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.image = IMG(@"lightning_dark");
        [self addSubview:imageView];
        [self.imageArray addObject:imageView];
        if (i == 0) {
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf.mas_left);
                make.top.equalTo(weakSelf.mas_top);
                make.height.mas_equalTo(13);
                make.width.mas_equalTo(7);
            }];
        }else{
            UIImageView * formerImage = [self.imageArray objectAtIndex:i - 1];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(formerImage.mas_right).with.offset(5);
                make.top.height.width.equalTo(formerImage);
            }];
        }
    }
}
- (void)setHighlightedCounts:(NSInteger)highlightedCounts
{
    if (highlightedCounts > self.imageArray.count) {
        highlightedCounts = self.imageArray.count;
    }
    if (highlightedCounts < 0) {
        highlightedCounts = 0;
    }
    for (int i = 0; i < highlightedCounts; i++) {
        UIImageView * image = [self.imageArray objectAtIndex:i];
        image.image = IMG(@"lightning_highlit");
    }
}
- (NSMutableArray *)imageArray
{
    if (!_imageArray) {
        self.imageArray = [NSMutableArray array];
    }
    return _imageArray;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
