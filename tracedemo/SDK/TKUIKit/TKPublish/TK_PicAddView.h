//
//  TK_PicAddView.h
//  tracedemo
//
//  Created by 罗田佳 on 15/11/29.
//  Copyright © 2015年 trace. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TK_PicAddDelegate <NSObject>

-(void)onAddBtnAction;
-(void)tkPreviewPicturesAtIndex:(NSInteger)index;

@end

@interface TK_PicAddView : UIView

@property (nonatomic,assign)CGFloat paddingLeft;
@property (nonatomic,assign)CGFloat paddingTop;
@property (nonatomic,assign)CGFloat picWidth;
@property (nonatomic,assign)CGFloat picHeight;
@property (nonatomic,strong)NSString * defaultAddPicStr;
@property (nonatomic,assign)NSInteger maxCount;
@property (nonatomic,strong)id<TK_PicAddDelegate> tkAddDelegate;


-(instancetype)initDefaultAddWithFrame:(CGRect)frame;

-(instancetype)initDefaultAdd;

-(void)tkReloadWithDefaultPic:(NSArray *)pics;

-(CGFloat)tkGetViewsHeight;

@end
