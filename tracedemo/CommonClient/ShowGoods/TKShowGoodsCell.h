//
//  TKShowGoodsCell.h
//  tracedemo
//
//  Created by 罗田佳 on 15/12/15.
//  Copyright © 2015年 trace. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TKIShowGoodsRowM.h"
#import "TKHeadImageView.h"


@protocol TKShowGoodsCellDelegate<NSObject>

@required
-(TKShowGoodsRowData *)getRowDataByIndex:(NSIndexPath *) indexPath;

@optional
-(void)onCommentBtnClick:(NSIndexPath *) indexPath;

@end


@interface TKShowGoodsCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *imageContentView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imageFiledHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textHeight;
@property (strong, nonatomic) IBOutlet TKHeadImageView *userHeadImage;
@property (strong, nonatomic) IBOutlet UIImageView *buyerHeadImage;
@property (weak, nonatomic) IBOutlet UILabel *buyerVipLevelText;
@property (weak, nonatomic) IBOutlet UILabel *buyerNameText;

@property (strong, nonatomic) IBOutlet UILabel *contentText;
@property (strong, nonatomic) IBOutlet UILabel *headSecondLabel;
@property (strong, nonatomic) IBOutlet UILabel *headFirstLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressText;
@property (weak, nonatomic) IBOutlet UILabel *timeText;

@property (weak, nonatomic) IBOutlet UILabel *zanCount;

@property (weak, nonatomic) IBOutlet UILabel *zanMore;
@property (weak, nonatomic) IBOutlet UILabel *followCount;

@property (weak, nonatomic) IBOutlet UIButton *brandBtn;
@property (weak, nonatomic) IBOutlet UIButton *categoryBtn;
@property (weak, nonatomic) IBOutlet UILabel *followMore;

- (IBAction)followAction:(id)sender;

@property (strong,nonatomic) NSIndexPath * indexPath;
@property (weak,nonatomic) id<TKShowGoodsCellDelegate> tkShowGoodscellDelegate;


- (IBAction)imageFieldBtn:(id)sender;



//head cell
@property (nonatomic, weak) IBOutlet UIImageView *headImage;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;;
@property (nonatomic, weak) IBOutlet UILabel *gradeLabel;
@property (nonatomic, weak) IBOutlet UILabel *describleLabel;
- (IBAction)messageAction:(id)sender;

- (void)setHeadViewModel:(id)model;
@end
