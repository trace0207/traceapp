//
//  HFMessageCell.h
//  GuanHealth
//
//  Created by shi_dongdong on 15/5/22.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableCell.h"

@class HFMessageTypeInfoData;
@class HFMessageCell;
@protocol HFMessageCellDelegate <NSObject>

- (void)headImageAction:(HFMessageCell *)cell;

@end

@class MLEmojiLabel;
@interface HFMessageCell : BaseTableCell

@property (weak, nonatomic) IBOutlet BasePortraitView *mHeadImage;
@property (weak, nonatomic) IBOutlet UILabel     *mNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mDetailImage;
@property (weak, nonatomic) IBOutlet UIImageView *mPriseImage;
@property (weak, nonatomic) IBOutlet MLEmojiLabel     *mContentLabel;
@property (weak, nonatomic) IBOutlet UILabel     *mTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel     *mSystemLabel;
@property (weak, nonatomic) IBOutlet MLEmojiLabel *mDetailContentedLabelCover;


@property (weak, nonatomic) id<HFMessageCellDelegate>delegate;
- (void)setContentToCell:(HFMessageTypeInfoData *)post withType:(MessageType)type;

@end
