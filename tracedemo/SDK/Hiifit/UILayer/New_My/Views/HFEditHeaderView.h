//
//  HFEditHeaderView.h
//  GuanHealth
//
//  Created by 朱伟特 on 15/10/26.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HFEditHeaderDelegate <NSObject>

- (void)choosePicture;
- (void)chooseGirl;
- (void)chooseBoy;

@end
@interface HFEditHeaderView : BaseTableCell

@property (nonatomic, weak) id<HFEditHeaderDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIButton *boyBtn;
@property (weak, nonatomic) IBOutlet UIButton *girlBtn;
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;


- (IBAction)selectPicture:(id)sender;
- (IBAction)chooseBoyBtn:(id)sender;
- (IBAction)chooseGirlBtn:(id)sender;

- (void)changeUserSex:(BOOL)boy;
@end
