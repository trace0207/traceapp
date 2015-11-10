//
//  HFMessageCell.m
//  GuanHealth
//
//  Created by shi_dongdong on 15/5/22.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFMessageCell.h"
#import "MLEmojiLabel.h"

@implementation HFMessageCell
@synthesize delegate;
- (void)awakeFromNib {
    // Initialization code
    [_mHeadImage addAction:@selector(clickHeadImageEvent:) forTarget:self];
    _mContentLabel.font = [UIFont systemFontOfSize:16.0f];
    _mContentLabel.numberOfLines = 0;
    _mContentLabel.textColor = [UIColor HFColorStyle_1];
    _mContentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _mContentLabel.isNeedAtAndPoundSign = YES;
    _mContentLabel.customEmojiRegex = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    _mContentLabel.customEmojiPlistName = @"expression.plist";
    
    _mDetailContentedLabelCover.font = [UIFont systemFontOfSize:14.0f];
    _mDetailContentedLabelCover.numberOfLines = 0;
    _mDetailContentedLabelCover.textColor = [UIColor HFColorStyle_2];
    _mDetailContentedLabelCover.isNeedAtAndPoundSign = YES;
    _mDetailContentedLabelCover.customEmojiRegex = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    _mDetailContentedLabelCover.customEmojiPlistName = @"expression.plist";
    [_mDetailContentedLabelCover setBackgroundColor:[UIColor HFColorStyle_6]];
    
    _mSystemLabel.font = [UIFont systemFontOfSize:16];
    _mSystemLabel.textColor = [UIColor HFColorStyle_1];
    _mTimeLabel.textColor = [UIColor HFColorStyle_3];
    _mTimeLabel.font = [UIFont systemFontOfSize:12];
    _mNameLabel.font = [UIFont systemFontOfSize:16];
    _mNameLabel.textColor = [UIColor HFColorStyle_5];
}

- (void)setContentToCell:(HFMessageTypeInfoData *)post withType:(MessageType)type
{
    if (post.flag == 1) {
        self.contentView.backgroundColor = [UIColor whiteColor];
    }else {
        self.contentView.backgroundColor = [UIColor hexChangeFloat:@"eff1f1"];
    }
    if (type != MSGBOX_PRISE_TYPE) {
        self.mPriseImage.hidden = YES;
        if (type != MSGBOX_COMMENT_TYPE) {
            self.mDetailContentedLabelCover.hidden = YES;
            self.mDetailImage.hidden = YES;
        }
    }else{
        self.mContentLabel.hidden = YES;
        self.mSystemLabel.hidden = YES;
    }
    if (type != MSGBOX_SYSTEM_TYPE)
    {
        [_mHeadImage sd_setImageWithURL:[NSURL URLWithString:[UIKitTool getSmallImage:post.headPortraitUrl]] placeholderImage:[UIImage imageNamed:@"head_default"]];
        
         _mNameLabel.text = post.operatorName;
        
        if (type == MSGBOX_FOLLOW_TYPE) {
            self.mSystemLabel.text = @"关注了你";
        }else {
            if (post.picAddr1 && [post.picAddr1 hasPrefix:@"http"]) {
                self.mDetailContentedLabelCover.hidden = YES;
                self.mDetailImage.hidden = NO;
                [_mDetailImage sd_setImageWithURL:[NSURL URLWithString:[UIKitTool getSmallImage:post.picAddr1]] placeholderImage:IMG(@"img_default")];
            }else {
                self.mDetailContentedLabelCover.hidden = NO;
                self.mDetailImage.hidden = YES;
                _mDetailContentedLabelCover.text = post.goalContent;
            }
        }
    
        if (type == MSGBOX_COMMENT_TYPE) {
            self.mContentLabel.text = post.content;
        }
    }
    else
    {
        _mHeadImage.image = IMG(@"mes_system");
        _mNameLabel.text = @"系统通知";
        self.mSystemLabel.text = post.content;
    }
    if (post.secondTime)
    {
        _mTimeLabel.text = [NSDate stringWithTimeUTC:post.secondTime];
    }
}

- (void)clickHeadImageEvent:(UITapGestureRecognizer *)tap
{
    if (delegate && [delegate respondsToSelector:@selector(headImageAction:)])
    {
        [delegate headImageAction:self];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
