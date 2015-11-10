//
//  HFGifView.h
//  GuanHealth
//
//  Created by 朱伟特 on 15/8/3.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HFGifView : UIView


//@property (nonatomic, strong) NSURL * fileURL;
/*
 * @brief desingated initializer
 */
- (id)initWithFrame:(CGRect)frame fileURL:(NSURL *)fileURL;
/*
 * @brief start Gif Animation
 */
- (void)startGif;

/*
 * @brief stop Gif Animation
 */
- (void)stopGif;

@end
