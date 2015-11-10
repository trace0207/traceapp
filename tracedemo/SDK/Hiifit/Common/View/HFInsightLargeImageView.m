//
//  HFInsightLargeImageView.m
//  GuanHealth
//
//  Created by 栋栋 施 on 15/8/31.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "HFInsightLargeImageView.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"

@interface HFInsightLargeImageView ()
{
    
}
@property(nonatomic,strong)NSURL * mImageURL;
@property(nonatomic,strong)UIImage * mImage;
@end


@implementation HFInsightLargeImageView

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self initGesture];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self initGesture];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        [self initGesture];
    }
    return self;
}

- (void)initGesture
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkLargeImage)];
    [self addGestureRecognizer:tap];
}

- (void)checkLargeImage
{
    NSMutableArray * photoSources = [[NSMutableArray alloc] init];
    
    MJPhoto *photo = [[MJPhoto alloc] init];
    if (self.image) {
        photo.srcImageView = self;
    }
    
   // [NSURL URLWithString:[UIKitTool getRawImage:self.mImageURL]
    
    if (self.mImageURL)
    {
        photo.url = self.mImageURL;
    }
    else if (self.mImage)
    {
        photo.image = self.mImage;
    }
    else
    {
        NSLog(@"请至少设置一个参数，或者URL，或者image");
    }
    
    [photoSources addObject:photo];
    
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = 0;
    browser.photos = photoSources;
    [browser show];
}

#pragma mark -
#pragma mark public

- (void)dd_setImageURL:(NSURL *)imageURL
{
    [self dd_setImageURL:imageURL withPlaceholder:nil];
}

- (void)dd_setImageURL:(NSURL *)imageURL withPlaceholder:(UIImage *)image
{
    [self sd_setImageWithURL:imageURL placeholderImage:image];
    self.mImageURL = imageURL;
}

- (void)dd_setImage:(UIImage *)image
{
    self.mImage = image;
}


@end
