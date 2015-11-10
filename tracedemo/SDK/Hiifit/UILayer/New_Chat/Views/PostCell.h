//
//  PostCell.h
//  GuanHealth
//
//  Created by hermit on 15/4/1.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "BaseTableCell.h"
#import "PostDetailData.h"

#define kWidthThree ((kScreenWidth-30-10)/3)
#define kWidthTwo   ((kScreenWidth-15-60-10)/3)
#define kBaseImageTag   100
typedef NS_ENUM(NSInteger, COMMENT_OPERATE_TYPE){
    MSG_COMMENT_TYPE = 0,
    MSG_LIKE_TYPE,
};

typedef NS_ENUM(NSInteger, HFOperatePostType){
    HFOperatePostTypeNone   = 0,
    HFOperatePostTypeDelete = 1,
    HFOperatePostTypeReport = 2,
};

@class PostCell;

@protocol PostCellDelegate <NSObject>
@optional

- (void)commentEventWithType:(COMMENT_OPERATE_TYPE)type withCell:(PostCell *)cell;

- (void)goUserCenterView:(NSInteger)userId;

- (void)operatePostType:(HFOperatePostType)type withCell:(PostCell *)cell;

- (void)updateCellExpand:(BOOL)bExpand withCell:(PostCell *)cell;

@end

@class MLEmojiLabel;
@interface PostCell : BaseTableCell
{
    BOOL bPrised;
}
@property (nonatomic, weak  ) IBOutlet UIImageView      *headImageView;
@property (nonatomic, weak  ) IBOutlet UILabel          *nameLabel;
@property (nonatomic, weak  ) IBOutlet UILabel          *nextNameLabel;
@property (nonatomic, weak  ) IBOutlet UILabel          *habitLabel;
@property (nonatomic, weak  ) IBOutlet UILabel          *dateLabel;
@property (nonatomic, weak  ) IBOutlet MLEmojiLabel     * contentLabel;

@property (nonatomic, weak  ) IBOutlet UIButton         *headBtn;
@property (nonatomic, weak  ) IBOutlet UIButton         *praiseBtn;
@property (nonatomic, weak  ) IBOutlet UIButton         *commentBtn;
@property (nonatomic, weak  ) IBOutlet UIImageView      *praiseImage;
@property (nonatomic, weak  ) IBOutlet UIImageView      *comentImage;
@property (nonatomic, weak  ) IBOutlet UILabel          *praiseLabel;
@property (nonatomic, weak  ) IBOutlet UILabel          *commentLabel;
@property (nonatomic, weak  ) IBOutlet UIImageView      *reportImageView;
@property (nonatomic, weak  ) IBOutlet UILabel          *reportLabel;
@property (nonatomic, weak  ) IBOutlet UIButton         *reportBtn;
@property (nonatomic, weak  ) IBOutlet UIButton         *delBtn;
@property (weak, nonatomic  ) IBOutlet UILabel          *titleLabel;

@property (nonatomic, assign) BOOL             bIsDetail;
@property (nonatomic        ) BOOL             bPrised;
@property (nonatomic, weak  ) id<PostCellDelegate> delegate;
@property (nonatomic, strong) PostDetailData   *mData;


@property (weak, nonatomic) IBOutlet UIButton *expandBtn;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

- (IBAction)expandAction:(UIButton *)sender;
- (IBAction)commentAction:(UIButton *)sender;
- (IBAction)likeAction:(UIButton *)sender;
- (IBAction)goUserCenterAction:(UIButton *)sender;
- (IBAction)delAction:(id)sender;
- (IBAction)reportAction:(id)sender;

- (void)setContentToCell:(PostDetailData *)post;
- (void)updateCellWithData:(PostDetailData *)data;
- (void)setReportActivity:(BOOL)activity;

@end
