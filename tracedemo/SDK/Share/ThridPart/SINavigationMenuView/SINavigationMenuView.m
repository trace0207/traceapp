//
//  SINavigationMenuView.m
//  NavigationMenu
//
//  Created by Ivan Sapozhnik on 2/19/13.
//  Copyright (c) 2013 Ivan Sapozhnik. All rights reserved.
//

#import "SINavigationMenuView.h"
#import "SIMenuButton.h"
#import "QuartzCore/QuartzCore.h"
#import "SIMenuConfiguration.h"

@interface SINavigationMenuView  ()
{
    BOOL showing;
}
@property (nonatomic, strong) SIMenuButton *menuButton;
@property (nonatomic, strong) SIMenuTable *table;
@property (nonatomic, strong) UIView *menuContainer;
@end

@implementation SINavigationMenuView

- (id)initWithFrame:(CGRect)frame title:(NSString *)title
{
    self = [super initWithFrame:frame];
    if (self) {
        frame.origin.y += 1.0;
        self.menuButton = [[SIMenuButton alloc] initWithFrame:frame];
        self.menuButton.title.text = title;
        [self.menuButton addTarget:self action:@selector(onHandleMenuTap:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.menuButton];
    }
    return self;
}
- (void)setTitle:(NSString *)title
{
    self.menuButton.title.text = title;
}
- (void)displayMenuInView:(UIView *)view
{
    self.menuContainer = view;
    //self.menuContainer.backgroundColor = [UIColor hexChangeFloat:kColorWhite withAlpha:1];
}

#pragma mark -
#pragma mark Actions

- (void)hidenMenu
{
    if (showing) {
        [self onHandleMenuTap:self.menuButton];
    }
}

- (void)onHandleMenuTap:(id)sender
{
    if (!showing) {
        NSLog(@"On show");
        [self onShowMenu];
    } else {
        NSLog(@"On hide");
        [self onHideMenu];
    }
    showing = !showing;
}

- (void)onShowMenu
{
    if (!self.table) {
    UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
    CGRect frame = CGRectMake(0, 64, mainWindow.frame.size.width, mainWindow.frame.size.height);
//    CGRect frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 75, 0-64, 150, 88);
  
        self.table = [[SIMenuTable alloc] initWithFrame:frame items:self.items];
        self.table.menuDelegate = self;
    }
    [self.menuContainer addSubview:self.table];
    [self rotateArrow:M_PI];
    [self.table show];
}

- (void)onHideMenu
{
    [self rotateArrow:0];
    [self.table hide];
}

- (void)rotateArrow:(float)degrees
{
    [UIView animateWithDuration:[SIMenuConfiguration animationDuration] delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.menuButton.arrow.layer.transform = CATransform3DMakeRotation(degrees, 0, 0, 1);
    } completion:NULL];
}

#pragma mark -
#pragma mark Delegate methods
- (void)didSelectItemAtIndex:(NSUInteger)index
{
    //self.menuButton.isActive = !self.menuButton.isActive;
    [self onHandleMenuTap:nil];
    [self.delegate didSelectItemAtIndex:index];
}

#pragma mark - SIMenuDelegate
- (void)didBackgroundTap
{
    //self.menuButton.isActive = !self.menuButton.isActive;
    [self onHandleMenuTap:nil];
}

#pragma mark -
#pragma mark Memory management
- (void)dealloc
{
    self.items = nil;
    self.menuButton = nil;
    self.menuContainer = nil;
}

@end
