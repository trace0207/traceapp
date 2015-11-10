//
//  HFActionSheet.h
//  UIButtonExtension
//
//  Created by 朱伟特 on 15/9/16.
//  Copyright (c) 2015年 朱伟特. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HFActionSheetDelegate <NSObject>

- (void)didSelectItemAtIndex:(NSInteger)index;

@end
@interface HFActionSheet : UIView

@property (nonatomic, weak) id<HFActionSheetDelegate>delegate;

- (void)showInSuperView:(UIView *)superView cancelButton:(NSString *)cancel otherButton:(NSString *)title,... NS_REQUIRES_NIL_TERMINATION;

@end
