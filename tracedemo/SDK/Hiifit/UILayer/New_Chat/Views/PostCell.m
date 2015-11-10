//
//  PostCell.m
//  GuanHealth
//
//  Created by hermit on 15/4/1.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "PostCell.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "MLEmojiLabel.h"
#import "NSString+HFStrUtil.h"
#import "UIImage+Scale.h"
@interface PostCell()

@end

@implementation PostCell
@synthesize delegate;
@synthesize bPrised;
@synthesize mData;
- (void)awakeFromNib
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _contentLabel.font                 = [UIFont systemFontOfSize:16.0f];
    _contentLabel.numberOfLines        = 0;
    _contentLabel.isNeedAtAndPoundSign = YES;
    _contentLabel.customEmojiRegex     = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
    _contentLabel.customEmojiPlistName = @"expression.plist";
    self.nameLabel.textColor = [UIColor HFColorStyle_5];
    self.nextNameLabel.textColor = [UIColor HFColorStyle_5];
    //CGFloat edgeWidth = self.cellIndex == 1?75:30;
    //CGFloat width = ((kScreenWidth - edgeWidth)-6)/3.0f;
    for (NSInteger i = 0; i < 9; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.tag = kBaseImageTag + i;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkLargeImage:)];
        [imageView addGestureRecognizer:tap];
        [self.contentView addSubview:imageView];
        
//        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(_contentLabel.mas_bottom).with.offset(10 + i/3*(width + 3));
//            make.left.equalTo(_contentLabel.mas_left).with.offset(i%3*(width + 3));
//            make.size.mas_equalTo(CGSizeMake(width, width));
//        }];
    }
    self.delBtn.hidden = YES;
    [self.expandBtn setTitleColor:[UIColor HFColorStyle_5] forState:UIControlStateNormal];
    [self.delBtn setTitleColor:[UIColor HFColorStyle_5] forState:UIControlStateNormal];
    if (self.backgroundImageView) {
        UIImage *img = [UIImage scaleWithImage:@"cell_bg"];
        [self.backgroundImageView setImage:img];
        self.contentView.backgroundColor = [UIColor HFColorStyle_6];
        self.backgroundColor = [UIColor HFColorStyle_6];
    }
    [self.delBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.expandBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.praiseLabel setFont:[UIFont systemFontOfSize:12]];
    [self.commentLabel setFont:[UIFont systemFontOfSize:12]];
    [self.dateLabel setFont:[UIFont systemFontOfSize:12]];
    [self.dateLabel setTextColor:[UIColor HFColorStyle_2]];
    [self.commentLabel setTextColor:[UIColor HFColorStyle_2]];
    [self.praiseLabel setTextColor:[UIColor HFColorStyle_2]];
}

- (IBAction)expandAction:(UIButton *)sender {
    
    BOOL  expand;
    
    if ([sender.titleLabel.text isEqualToString:@"全文"])
    {
        expand = YES;
    }
    else
    {
        expand = NO;
    }
    
    if (self.delegate  && [self.delegate respondsToSelector:@selector(updateCellExpand:withCell:)])
    {
        [self.delegate updateCellExpand:expand withCell:self];
    }
}

- (IBAction)commentAction:(UIButton *)sender
{
    if (delegate && [delegate respondsToSelector:@selector(commentEventWithType:withCell:)])
    {
        [delegate commentEventWithType:MSG_COMMENT_TYPE withCell:self];
    }
}

- (IBAction)likeAction:(UIButton *)sender
{
    [MobClick event:EmotionPage_Parise_Click];
    if (delegate && [delegate respondsToSelector:@selector(commentEventWithType:withCell:)])
    {
        [delegate commentEventWithType:MSG_LIKE_TYPE withCell:self];
    }
}

- (IBAction)goUserCenterAction:(UIButton *)sender
{
    [MobClick event:Emotion_Head_Click];
    if (delegate && [delegate respondsToSelector:@selector(goUserCenterView:)])
    {
        [delegate goUserCenterView:sender.tag];
    }
}

#pragma mark - 天写内容

- (void)updateCellWithData:(PostDetailData *)data
{
    self.mData = data;
    if (self.mData.commentNum>0) {
        [_commentLabel setText:[NSString stringWithFormat:@"%@",@(self.mData.commentNum)]];
    }else {
        [_commentLabel setText:@"评论"];
    }
    
    if (!self.mData.praised)
    {
        [self.praiseImage setImage:[UIImage imageNamed:@"bad"]];
    }
    else
    {
        [self.praiseImage setImage:[UIImage imageNamed:@"good"]];
    }
    if (self.mData.praiseNum>0) {
        self.praiseLabel.text = [NSString stringWithFormat:@"%@",@(self.mData.praiseNum)];
    }else {
        self.praiseLabel.text = @"赞";
    }
    
}

- (void)setContentToCell:(PostDetailData *)post
{
    self.mData = post;
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:[UIKitTool getSmallImage:post.headPortraitUrl]] placeholderImage:[UIImage imageNamed:@"head_default"]];
    
    
    
    _headBtn.tag = (NSInteger)post.authorId;
    bPrised = post.praised;
    [self updateCellWithData:post];
    if (post.title.length>0) {
        _titleLabel.text = post.title;
        if (self.bIsDetail) {
            _contentLabel.text = post.content;
        }
        self.nextNameLabel.text = post.nickName;
    }else {
        _contentLabel.text = post.content;
        NSString *habitName = nil;
        if (post.type == HIWeiboTypeHabit) {
            if (post.name.length > 0) {
                if ([post.name hasPrefix:@"习惯"]) {
                    habitName = post.name;
                }else{
                    habitName = [NSString stringWithFormat:@"习惯#%@#",post.name];
                }
            }
        }else{
            if (post.name.length > 0) {
                if ([post.name hasPrefix:@"模块"]) {
                    habitName = post.name;
                }else{
                    habitName = [NSString stringWithFormat:@"模块#%@#",post.name];
                }
            }
        }
        if (habitName) {
            _nameLabel.hidden = NO;
            _nextNameLabel.hidden = YES;
            _nameLabel.text = post.nickName;
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:habitName];
            [attrStr setAttributes:@{NSForegroundColorAttributeName:[UIColor HFColorStyle_5]} range:NSMakeRange(3, habitName.length-4)];
            
            self.habitLabel.attributedText = attrStr;
            
        }else {
            _nameLabel.hidden = YES;
            _nextNameLabel.hidden = NO;
            _nextNameLabel.text = post.nickName;
            self.habitLabel.attributedText = nil;
        }
    }
    
    if (post.expandFlag == PostExpandUnExpand)
    {
        self.expandBtn.hidden = NO;
        [self.expandBtn setTitle:@"全文" forState:UIControlStateNormal];
        _contentLabel.numberOfLines = 4;
        
    }
    else if (post.expandFlag == PostExpandExpand)
    {
        self.expandBtn.hidden = NO;
        [self.expandBtn setTitle:@"收起" forState:UIControlStateNormal];
        _contentLabel.numberOfLines = 0;
    }
    else
    {
        self.expandBtn.hidden = YES;
        _contentLabel.numberOfLines = 0;
    }
    
    if (post.secondTime>0) {
        _dateLabel.text = [NSDate stringWithTimeUTC:post.secondTime];
    }
    
    NSDictionary *dic = [post toDictionary];
    NSMutableArray *picUrls = [[NSMutableArray alloc]init];
    for (int i = 0; i < 9; i++) {
        NSString *key = [NSString stringWithFormat:@"picAddr%i",i+1];
        NSString *imgStr = [dic objectForKey:key];
        if (imgStr.length>0) {
            [picUrls addObject:imgStr];
        }
    }
    
    CGFloat height = 0;
    if (self.expandBtn.hidden)
    {
        if (post.content > 0) {
            height = 10.0;
        }
    }
    else
    {
        height = 40.0;
    }
    
    if (picUrls.count == 0) {
        for (int j = 0; j< 9; j++) {
            UIImageView *imageView = (UIImageView*)[self.contentView viewWithTag:j+kBaseImageTag];
            if (imageView) {
                imageView.hidden = YES;
            }
        }
    }else if (picUrls.count == 1) {
        UIImageView *imageView = (UIImageView*)[self.contentView viewWithTag:kBaseImageTag];
        imageView.hidden = NO;
        [imageView sd_setImageWithURL:[NSURL URLWithString:[UIKitTool getRawImage:[picUrls firstObject]]] placeholderImage:[UIImage imageNamed:@"img_default"]];
        
        [imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_contentLabel.mas_bottom).with.offset(height);
            make.left.equalTo(_contentLabel.mas_left);
            make.size.mas_equalTo(CGSizeMake(kWidthThree*2.4f, kWidthThree*1.8f));
        }];
        [imageView updateConstraints];
        for (int j = 1; j< 9; j++) {
            UIImageView *imageView = (UIImageView*)[self.contentView viewWithTag:j+kBaseImageTag];
            if (imageView) {
                imageView.hidden = YES;
            }
        }
    }else if (picUrls.count == 4) {
        for (int i = 0; i < 9; i++) {
            if (i < 4) {
                UIImageView *imageView = (UIImageView*)[self.contentView viewWithTag:i+kBaseImageTag];
                imageView.hidden = NO;
                [imageView sd_setImageWithURL:[NSURL URLWithString:[UIKitTool getSmallImage:[picUrls objectAtIndex:i]]] placeholderImage:[UIImage imageNamed:@"img_default"]];
                [imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(_contentLabel.mas_bottom).with.offset(height + i/2*(kWidthThree*1.154 + 5));
                    make.left.equalTo(_contentLabel.mas_left).with.offset(i%2*(kWidthThree*1.154 + 5));
                    make.size.mas_equalTo(CGSizeMake(kWidthThree*1.154, kWidthThree*1.154));
                }];
                [imageView updateConstraints];
            }else{
                UIImageView *imageView = (UIImageView*)[self.contentView viewWithTag:i+kBaseImageTag];
                if (imageView) {
                    imageView.hidden = YES;
                }
            }
        }
    }else {
        for (int i = 0; i < 9; i++) {
            
            if (i < picUrls.count) {
                UIImageView *imageView = (UIImageView*)[self.contentView viewWithTag:i+kBaseImageTag];
                imageView.hidden = NO;
                [imageView sd_setImageWithURL:[NSURL URLWithString:[UIKitTool getSmallImage:[picUrls objectAtIndex:i]]] placeholderImage:[UIImage imageNamed:@"img_default"]];
                [imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(_contentLabel.mas_bottom).with.offset(height + i/3*(kWidthThree + 5));
                    make.left.equalTo(_contentLabel.mas_left).with.offset(i%3*(kWidthThree + 5));
                    make.size.mas_equalTo(CGSizeMake(kWidthThree, kWidthThree));
                }];
                [imageView updateConstraints];
            }else{
                UIImageView *imageView = (UIImageView*)[self.contentView viewWithTag:i+kBaseImageTag];
                if (imageView) {
                    imageView.hidden = YES;
                }
            }
        }
    }
}

//隐藏或显示举报按钮
- (void)setReportActivity:(BOOL)activity
{
    self.reportLabel.hidden = !activity;
    self.reportImageView.hidden = !activity;
    self.reportBtn.hidden = !activity;
}

#pragma mark - 查看大图

- (void)checkLargeImage:(UITapGestureRecognizer *)tap
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    [MobClick event:Check_Emotion_BigImage];
    UIImageView * view = (UIImageView *)[tap view];
    NSInteger index = view.tag - kBaseImageTag;
    [self inSightLargeImage:index];
}

- (void)inSightLargeImage:(NSInteger)index
{
    //创建图片浏览器
    NSDictionary *dic = [mData toDictionary];
    NSMutableArray *picUrls = [[NSMutableArray alloc]init];
    for (int i = 0; i < 9; i++) {
        NSString *key = [NSString stringWithFormat:@"picAddr%i",i+1];
        NSString *imgStr = [dic objectForKey:key];
        if (imgStr.length>0) {
            [picUrls addObject:[UIKitTool getRawImage:imgStr]];
        }
    }
    NSMutableArray * photoSources = [[NSMutableArray alloc] init];
    for (int i = 0; i < picUrls.count; i++) {
        UIImageView * srcImageView = (UIImageView*)[self.contentView viewWithTag:i+kBaseImageTag];
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.srcImageView = srcImageView;
        photo.url = [NSURL URLWithString:[picUrls objectAtIndex:i]];
        [photoSources addObject:photo];
    }
    
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = index;
    browser.photos = photoSources;
    [browser show];
    
}

#pragma mark - 删除和举报操作

- (IBAction)reportAction:(id)sender
{
    if (delegate && [delegate respondsToSelector:@selector(operatePostType:withCell:)]) {
        [delegate operatePostType:HFOperatePostTypeReport withCell:self];
    }
}

- (IBAction)delAction:(id)sender
{
    if (delegate && [delegate respondsToSelector:@selector(operatePostType:withCell:)]) {
        [delegate operatePostType:HFOperatePostTypeDelete withCell:self];
    }
}

@end
