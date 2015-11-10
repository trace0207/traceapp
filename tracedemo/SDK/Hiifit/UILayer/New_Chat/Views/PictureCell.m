//
//  PictureCell.m
//  GuanHealth
//
//  Created by hermit on 15/4/28.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "PictureCell.h"

@implementation PictureCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.addBtn.frame = CGRectMake(10, 0, kPictureWidth, kPictureWidth);
    [self.addBtn setBackgroundImage:[UIImage imageNamed:@"addPhotos"] forState:UIControlStateNormal];
    [self addSubview:self.addBtn];
    
//    self.placehordLable = [[UILabel alloc]initWithFrame:CGRectMake(15 + kPictureWidth, 0, 100, 20)];
//    self.placehordLable.center = CGPointMake(self.placehordLable.center.x, self.addBtn.center.y+5);
//    self.placehordLable.font = [UIFont systemFontOfSize:14.0f];
//    self.placehordLable.textColor = [UIColor hexChangeFloat:@"979797" withAlpha:1.0f];
//    self.placehordLable.text = @"添加图片";
//    [self addSubview:self.placehordLable];
    
    return self;
}

- (void)setPicturesToCell:(NSArray *)pictures
{
//    if (pictures.count == 0) {
//        self.placehordLable.hidden = NO;
//    }else{
//        self.placehordLable.hidden = YES;
//    }
    for (int i = 0; i < 9; i++) {
        UIImageView *imgView = (UIImageView*)[self viewWithTag:i+100];
        if (imgView) {
            [imgView removeFromSuperview];
        }
    }
    
    for (int i=0; i<pictures.count; i++) {
        UIImage *tempImg = [pictures objectAtIndex:i];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i%4*(kPictureWidth+5)+10, (i/4)*(kPictureWidth+5)+5, kPictureWidth, kPictureWidth)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.image = tempImg;
        imageView.tag = i+100;
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(preview:)];
        [imageView addGestureRecognizer:tap];
        [self addSubview:imageView];
    }
    if (pictures.count == 9) {
        self.addBtn.hidden = YES;
    }else{
        self.addBtn.hidden = NO;
    }
    WS(weakSelf);
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.addBtn.frame = CGRectMake(10+(pictures.count%4)*(kPictureWidth+5), ((kPictureWidth+5)*(pictures.count/4)+5), kPictureWidth, kPictureWidth);
    });
}

- (void)preview:(UITapGestureRecognizer*)tap
{
    if (_delegate && [_delegate respondsToSelector:@selector(previewPicturesAtIndex:)]) {
        NSInteger index = tap.view.tag - 100 + 1;
        [_delegate previewPicturesAtIndex:index];
    }
}

@end
