//
//  HFCommentInfoView.m
//  GuanHealth
//
//  Created by shi_dongdong on 15/5/13.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFCommentInfoView.h"
#import "HFCommentUsersData.h"
#import "MLEmojiLabel.h"

@interface HFCommentInfoView()<UIGestureRecognizerDelegate>
{
    UILongPressGestureRecognizer * longTapGesture;
}
@property(nonatomic,copy)NSString  *mNickName;
@end

@implementation HFCommentInfoView
@synthesize delegate;
@synthesize mNickName;
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}
- (BOOL)canBecomeFirstResponder
{
    return YES;
}
- (CGFloat)reloadUI:(HFCommentUsersData *)data msgImage:(BOOL)bShow
{
    self.content = data.content;
    self.commentId = data.commentId;
    mAuthorId = data.followerId;
    self.mNickName = data.followerNickName;
    UIButton * bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bgButton.frame = self.bounds;
    bgButton.backgroundColor = [UIColor clearColor];
    bgButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [bgButton addTarget:self action:@selector(selectClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bgButton];
    
    
    CGFloat height = 0.0;
    
    if (bShow) {
        UIImageView * starView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 25, 15, 14)];
        starView.image = [UIImage imageNamed:@"discuss"];
        [self addSubview:starView];
    }
    
    BasePortraitView * headView = [[BasePortraitView alloc] initWithFrame:CGRectMake(25, 16, 30, 30)];
    [headView addAction:@selector(headViewAction:) forTarget:self];
    if (data.headPortraitUrl)
    {
        [headView sd_setImageWithURL:[NSURL URLWithString:[UIKitTool getSmallImage:data.headPortraitUrl]] placeholderImage:[UIImage imageNamed:@"head_default"]];
    }
    else
    {
        headView.image = [UIImage imageNamed:@"head_default"];
    }
    
    [self addSubview:headView];
    
    UILabel * timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 32 - 80, 10, 80, 20)];
    timeLabel.textAlignment = NSTextAlignmentRight;
    timeLabel.font = [UIFont systemFontOfSize:12.0];
    NSString * timeText = [NSDate stringWithTimeUTC:data.createTime];
    timeLabel.textColor = [UIColor lightGrayColor];
    timeLabel.text = timeText;
    [self addSubview:timeLabel];
    
    UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(headView.frame) + 10, 16, CGRectGetMinX(timeLabel.frame) - CGRectGetMaxX(headView.frame) - 10, 18)];
    name.font = [UIFont systemFontOfSize:12.0];
    name.textAlignment = NSTextAlignmentLeft;
    name.textColor = [UIColor HFColorStyle_5];
    name.text = data.followerNickName;
    [self addSubview:name];
    
    
    MLEmojiLabel * comment = [[MLEmojiLabel alloc] initWithFrame:CGRectZero];
    comment.numberOfLines = 0;
    comment.font = [UIFont systemFontOfSize:14.0f];
    comment.isNeedAtAndPoundSign = YES;
    comment.customEmojiRegex = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    comment.customEmojiPlistName = @"expression.plist";
    CGFloat width = kScreenWidth - 32 - CGRectGetMinX(name.frame);
    CGFloat textHeight;

    if (data.authorNickName) {
        NSMutableAttributedString * attributString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"回复%@：%@", data.authorNickName, data.content]];
        [attributString addAttribute:NSForegroundColorAttributeName value:[UIColor HFColorStyle_5] range:NSMakeRange(0, data.authorNickName.length + 3)];
        [attributString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0] range:NSMakeRange(0, data.authorNickName.length + 3)];
        [attributString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(data.authorNickName.length + 3, data.content.length)];
        //paragraphStyle用来调整nsmutableattributedstring的行间距什么的
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:1];
        paragraphStyle.lineHeightMultiple = 15;
        paragraphStyle.maximumLineHeight = 20;
        paragraphStyle.minimumLineHeight = 10;
        paragraphStyle.alignment = NSTextAlignmentJustified;
        [attributString addAttribute: NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(data.authorNickName.length + 3, data.content.length)];
        comment.text = attributString;
        textHeight = [comment preferredSizeWithMaxWidth:width].height;
    }else{
        comment.text = data.content;
        textHeight = [comment preferredSizeWithMaxWidth:width].height;
    }
    //[comment setBaselineAdjustment:UIBaselineAdjustmentAlignBaselines];
    comment.frame = CGRectMake(CGRectGetMinX(name.frame),CGRectGetMaxY(name.frame) + 5, width, textHeight);
    
    
    [self addSubview:comment];
    
    
    height = CGRectGetMaxY(comment.frame) + 15;
    
    //添加细线
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(name.frame), height, width, 0.5)];
    line.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    line.backgroundColor = [UIColor HFColorStyle_6];
    [self addSubview:line];
    
    height++;
    return height;
}

- (void)selectClick
{
    if (delegate && [delegate respondsToSelector:@selector(selectCommentInfo:withNickName:)])
    {
        [delegate selectCommentInfo:mAuthorId withNickName:mNickName];
    }
}

- (void)headViewAction:(UITapGestureRecognizer *)tap
{
    if (delegate && [delegate respondsToSelector:@selector(commentInfoHeadAction:)])
    {
        [delegate commentInfoHeadAction:mAuthorId];
    }
}
- (void)addLongAction:(SEL)selector forTarget:(id)target
{
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:target action:selector];
    gesture.minimumPressDuration = 1.0;
    [self addGestureRecognizer:gesture];
}
- (NSString *)intervalSinceNow: (CGFloat ) theDate
{
    
    NSDate* dat = [NSDate date];
    NSTimeInterval now=[dat timeIntervalSince1970]*1;
    NSString *timeString=@"";
    
    NSTimeInterval cha=now-theDate;
    if (cha/3600<1) {
        if (cha > 60) {
            timeString = [NSString stringWithFormat:@"%f", cha/60];
            timeString = [timeString substringToIndex:timeString.length-7];
            timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
        }else{
            timeString = [NSString stringWithFormat:@"%d秒前", (int)cha];
        }
    }
    if (cha/3600>1&&cha/86400<1) {
        timeString = [NSString stringWithFormat:@"%f", cha/3600];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    }
    if (cha/86400>1)
    {
        timeString = [NSString stringWithFormat:@"%f", cha/86400];
        timeString = [timeString substringToIndex:timeString.length-7];
        timeString=[NSString stringWithFormat:@"%@天前", timeString];
        
    }
    return timeString;
}
@end
