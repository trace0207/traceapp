//
//  MJZoomingScrollView.m
//
//  Created by mj on 13-3-4.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MJPhotoView.h"
#import "MJPhoto.h"
#import "MJPhotoLoadingView.h"
#import "UIImageView+WebCache.h"
#import <QuartzCore/QuartzCore.h>

@interface MJPhotoView ()
{
    BOOL _doubleTap;
    UIImageView *_imageView;//  当前显示的 ImageView
    MJPhotoLoadingView *_photoLoadingView;
}
@end

@implementation MJPhotoView

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        
        self.clipsToBounds = YES;
		// 图片
		_imageView = [[UIImageView alloc] init];
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
		_imageView.contentMode = UIViewContentModeCenter;
		[self addSubview:_imageView];
        
        // 进度条
        _photoLoadingView = [[MJPhotoLoadingView alloc] init];
		
		// 属性
		self.backgroundColor = [UIColor clearColor];
		self.delegate = self;
		self.showsHorizontalScrollIndicator = NO;
		self.showsVerticalScrollIndicator = NO;
		self.decelerationRate = UIScrollViewDecelerationRateFast;
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        // 监听点击
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
//        singleTap.delaysTouchesBegan = YES;
        singleTap.numberOfTapsRequired = 1;
        [self addGestureRecognizer:singleTap];
        
//        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
//        doubleTap.numberOfTapsRequired = 2;
//        [self addGestureRecognizer:doubleTap];
    }
    return self;
}

#pragma mark - photoSetter
- (void)setPhoto:(MJPhoto *)photo {
    _photo = photo;
    
    [self showImage];
}

#pragma mark 显示图片
- (void)showImage
{
    if (_photo.firstShow)
    { // 首次显示
        _imageView.image = _photo.placeholder; // 占位图片
//        _photo.srcImageView.image = nil;
        [self adjustFrame];
        // 不是gif，就马上开始下载
        if (![_photo.url.absoluteString hasSuffix:@"gif"]) {
            __weak MJPhotoView *photoView = self;
            __weak MJPhoto *photo = _photo;
            [_imageView setImageWithURL:_photo.url placeholderImage:_photo.placeholder options:SDWebImageRetryFailed|SDWebImageLowPriority completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                photo.image = image;
                // 调整frame参数
                [photoView adjustFrame];
            }];
        }
    }
    else
    {
        [self photoStartLoad];
    }

//    // 调整frame参数
//    [self adjustFrame];
}

#pragma mark 开始加载图片
- (void)photoStartLoad
{
    if (_photo.image) {
        self.scrollEnabled = YES;
        _imageView.image = _photo.image;
        [self photoDidFinishLoadWithImage:_photo.image];
    } else {
        self.scrollEnabled = NO;
        // 直接显示进度条
        [_photoLoadingView showLoading];
        [self addSubview:_photoLoadingView];
        
        __weak MJPhotoView *photoView = self;
        __weak MJPhotoLoadingView *loading = _photoLoadingView;
//        [_imageView setImageWithURL:_photo.url placeholderImage:_photo.srcImageView.image options:SDWebImageRetryFailed|SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//            if (receivedSize > kMinProgress) {
//                loading.progress = (float)receivedSize/expectedSize;
//            }
//        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
//            [photoView photoDidFinishLoadWithImage:image];
//        }];
        [_imageView sd_setImageWithURL:_photo.url placeholderImage:_photo.placeholder options:SDWebImageRetryFailed|SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            if (receivedSize > kMinProgress) {
                if (loading)
                {
                    loading.progress = (float)receivedSize/expectedSize;
                }
                
            }
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [photoView photoDidFinishLoadWithImage:image];
        }];
    }
}

#pragma mark 加载完毕
- (void)photoDidFinishLoadWithImage:(UIImage *)image
{
    if (image) {
        self.scrollEnabled = YES;
        _photo.image = image;
        [_photoLoadingView removeFromSuperview];
        
        if ([self.photoViewDelegate respondsToSelector:@selector(photoViewImageFinishLoad:)]) {
            [self.photoViewDelegate photoViewImageFinishLoad:self];
        }
    } else {
        [self addSubview:_photoLoadingView];
        [_photoLoadingView showFailure];
    }
    
    // 设置缩放比例
    [self adjustFrame];
}
#pragma mark 调整frame
- (void)adjustFrame
{
	if (_imageView.image == nil) return;
    
    // 基本尺寸参数
    CGSize boundsSize = self.bounds.size;
    CGFloat boundsWidth = boundsSize.width;
    CGFloat boundsHeight = boundsSize.height;
    
    CGSize imageSize = _imageView.image.size;
    CGFloat imageWidth = imageSize.width;
    CGFloat imageHeight = imageSize.height;
	
	// 设置伸缩比例
    CGFloat minScale = boundsWidth / imageWidth;
	if (minScale > 1) {
		minScale = 1.0;
	}
	CGFloat maxScale = 3.0;
	if ([UIScreen instancesRespondToSelector:@selector(scale)]) {
		maxScale = maxScale / [[UIScreen mainScreen] scale];
	}
	self.maximumZoomScale = maxScale;
	self.minimumZoomScale = minScale;
	self.zoomScale = minScale;
    
    CGRect imageFrame = CGRectMake(0, 0, boundsWidth, imageHeight * minScale);//  让显示的图片 横向填充屏幕宽度， 高度按照比例适配
    // 内容尺寸
    self.contentSize = CGSizeMake(0, imageFrame.size.height);
    
    // y值
    if (imageFrame.size.height < boundsHeight) {
        imageFrame.origin.y = floorf((boundsHeight - imageFrame.size.height) / 2.0);
	} else {
        imageFrame.origin.y = 0;//  如果是长图，或者是长宽比大于屏幕长宽比的图， 默认显示顶部。
	}
    
   // NSLog(@"~~~~~~~~~~~~~~~~~%f,%f,%f,%f", imageFrame.origin.x, imageFrame.origin.y,imageFrame.size.width,imageFrame.size.height);
    
    if (_photo.firstShow) { // 第一次显示的图片
        _photo.firstShow = NO; // 已经显示过了
        
        // 显示的起始frame，和原来的 srcImage boud frame 一致 开始做动画
        _imageView.frame = [_photo.srcImageView convertRect:_photo.srcImageView.bounds toView:nil];
        
        _imageView.clipsToBounds = _photo.srcImageView.clipsToBounds;
        
        
//        DDLogInfo(@"show begin frame w = %f, h = %f",_imageView.frame.size.width,_imageView.frame.size.height);
//        DDLogInfo(@"show begin  x = %f, y = %f",_imageView.center.x,_imageView.center.y);
        
        [UIView animateWithDuration:0.35 animations:^{
            _imageView.frame = imageFrame;
            DDLogInfo(@"show end  x = %f, y = %f",_imageView.center.x,_imageView.center.y);
        } completion:^(BOOL finished) {
            _imageView.image = _photo.placeholder;
//            _photo.srcImageView.image = _photo.placeholder;//  先显示传过来的图片
            [self photoStartLoad];
        }];
    } else {
        _imageView.clipsToBounds = _photo.srcImageView.clipsToBounds;
        _imageView.frame = imageFrame;
    }
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
	return _imageView;
}

#pragma mark - 手势处理
- (void)handleSingleTap:(UITapGestureRecognizer *)tap {
    _doubleTap = NO;
    [self performSelector:@selector(hide) withObject:nil afterDelay:0.1];
}
- (void)hide
{
    if (_doubleTap) return;
    
    // 移除进度条
    [_photoLoadingView removeFromSuperview];
//    self.contentOffset = CGPointZero;
    
    // 清空底部的小图
//    _photo.srcImageView.image = nil;
    
    
    DDLogInfo(@"hide begin   center  x = %f, y = %f",_imageView.center.x,_imageView.center.y);
    
//    CGFloat duration = 0.;
//    if (_photo.srcImageView.clipsToBounds) {
//        [self performSelector:@selector(reset) withObject:nil afterDelay:duration];
//    }
//
    
//    [UIView animateWithDuration:1.0 animations: ^{
//        
//         CGRect frame = _photo.srcImageView.bounds;
//        _imageView.frame = [_photo.srcImageView convertRect:frame toView:nil];
//        DDLogInfo(@"hide end   center  x = %f, y = %f",_imageView.center.x,_imageView.center.y);
//        
//    }];
    
    
//    _imageView.image = _photo.srcImageView.image;
    
    CGRect frame =[_photo.srcImageView convertRect:_photo.srcImageView.bounds toView:nil];
     DDLogInfo(@"hide begin   center  x = %f, y = %f",frame.size.width,frame.size.height);
    
//    _imageView.contentMode = UIViewContentModeCenter;
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds  = _photo.srcImageView.clipsToBounds;

    
   
//    _imageView.backgroundColor = [UIColor clearColor];
    
    [UIView animateWithDuration: 0.35 animations:^{

//        _imageView.center  =  CGPointMake(frame.size.width/2, frame.size.height/2);
        _imageView.frame = frame;
        self.contentOffset = CGPointZero;
        // gif图片仅显示第0张
        if (_imageView.image.images) {
            _imageView.image = _imageView.image.images[0];
        }
//        
        // 通知代理
        if ([self.photoViewDelegate respondsToSelector:@selector(photoViewSingleTap:)]) {
            [self.photoViewDelegate photoViewSingleTap:self];
        }
    } completion:^(BOOL finished) {
        
//                 _imageView.image = _photo.placeholder;
        // 设置底部的小图片
//        _photo.srcImageView.image = _photo.placeholder;
        
        // 通知代理
        if ([self.photoViewDelegate respondsToSelector:@selector(photoViewDidEndZoom:)]) {
            [self.photoViewDelegate photoViewDidEndZoom:self];
        }
    }];
}

- (void)reset
{
    _imageView.image = _photo.capture;
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)handleDoubleTap:(UITapGestureRecognizer *)tap {
    _doubleTap = YES;
    
   // CGPoint touchPoint = [tap locationInView:self];
	if (self.zoomScale == self.maximumZoomScale) {
		[self setZoomScale:self.minimumZoomScale animated:YES];
	} else {
        CGRect zoomRect = [self zoomRectForScale:self.maximumZoomScale withCenter:[tap locationInView:tap.view]];
        [self zoomToRect:zoomRect animated:YES];
	}
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGRect rect = _imageView.frame;
    CGFloat orignY = (self.bounds.size.height - _imageView.frame.size.height)/2;
    
    if (orignY < 0)
    {
        orignY = 0;
        
    }
    
    rect.origin.y = orignY;
    
     CGFloat orignX = (self.bounds.size.width - _imageView.frame.size.width)/2;
    if(orignX < 0)
    {
        orignX = 0;
        
    }
    
    rect.origin.x = orignX;
    
    _imageView.frame = rect;
    _imageView.center = CGPointMake(orignX + rect.size.width/2, orignY + rect.size.height/2);
    
    DDLogInfo(@"move to  center  x = %f, y = %f",_imageView.center.x,_imageView.center.y);
}

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {//传入缩放比例和手势的点击的point返回<span style="color:#ff0000;">缩放</span>后的scrollview的大小和X、Y坐标点
    
    CGRect zoomRect;
    
    // the zoom rect is in the content view's coordinates.
    //    At a zoom scale of 1.0, it would be the size of the imageScrollView's bounds.
    //    As the zoom scale decreases, so more content is visible, the size of the rect grows.
    zoomRect.size.height = [self frame].size.height / scale;
    zoomRect.size.width  = [self frame].size.width  / scale;
    
    // choose an origin so as to get the right center.
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    //    zoomRect.origin.x=center.x;
    //    zoomRect.origin.y=center.y;
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}

- (void)dealloc
{
    // 取消请求
    [_imageView setImageWithURL:[NSURL URLWithString:@"file:///abc"]];
}
@end