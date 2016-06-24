//
//  TKCountrySelectVC.h
//  tracedemo
//
//  Created by 罗田佳 on 16/6/13.
//  Copyright © 2016年 trace. All rights reserved.
//

#import "TKIBaseNavWithDefaultBackVC.h"


@protocol CountrySelectDelegate <NSObject>

-(void)onCountrySelect:(NSString *)country countryCode:(NSString *)code;

@end


@interface TKCountrySelectVC : TKIBaseNavWithDefaultBackVC

@property (weak,nonatomic) id<CountrySelectDelegate> delegate;

-(void)onCountrySelect:(NSString *)country countryCode:(NSString *)code;

@end
