//
//  PictureCell.h
//  GuanHealth
//
//  Created by hermit on 15/4/28.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kPictureWidth (kScreenWidth-35)/4

@protocol PictureCellDelegate <NSObject>

- (void)previewPicturesAtIndex:(NSInteger)index;

@end

@interface PictureCell : UITableViewCell

@property (nonatomic, strong) UIButton *addBtn;

@property (nonatomic,   weak) id<PictureCellDelegate>delegate;

- (void)setPicturesToCell:(NSArray *)pictures;

@end
