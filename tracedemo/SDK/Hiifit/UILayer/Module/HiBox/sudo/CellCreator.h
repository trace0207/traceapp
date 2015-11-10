//
//  CellCreator.h
//  ShuDu
//
//  Created by hermit on 15/3/18.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cell.h"
#import "AFSoundManager.h"

@protocol CellCreatorDelegate <NSObject>

- (void)gameOver:(int)seconds isSuccess:(BOOL)success;

@end

@interface CellCreator : NSObject
{
    NSUInteger errorCount;
}
@property (nonatomic, assign) int      seconds;

@property (nonatomic, assign) NSInteger      selectedIndex;
@property (nonatomic, assign) NSUInteger     finishedFlag;
@property (nonatomic, strong) NSMutableArray *myCells;
@property (nonatomic, strong) NSMutableArray *bgImages;
@property (nonatomic, strong) NSMutableArray *selectBtns;
@property (nonatomic, strong) UIImageView    *lanscapeImage;
@property (nonatomic, strong) UIImageView    *protraitImage;
@property (nonatomic, strong) UIImageView    *indicatorImage;
@property (nonatomic, strong) UIButton       *markBtn;
@property (nonatomic, strong) UIButton       *voiceBtn;
@property (nonatomic,   weak) NSTimer        *timer;

@property (nonatomic,   weak) id<CellCreatorDelegate>delegate;
//+ (instancetype)sharedCreator;

- (BOOL)initializeGameCells:(NSDictionary *)cellsDic inView:(UIView *)view;



@end
