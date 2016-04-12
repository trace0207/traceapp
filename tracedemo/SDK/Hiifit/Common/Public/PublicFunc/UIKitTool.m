//
//  UIKitTool.m
//  GuanHealth
//
//  Created by hermit on 15/2/28.
//  Copyright (c) 2015年 wensihaihui. All rights reserved.
//

#import "UIKitTool.h"
#import "HFDBCenter.h"
#import "MLEmojiLabel.h"


@implementation UIKitTool

+ (AppDelegate*)getAppdelegate
{
    return (AppDelegate*)[[UIApplication sharedApplication]delegate];
}

#pragma mark - set the property of Label
+ (void)setLabelPropertyWithLab:(UILabel *)aLab fontSize:(CGFloat)size textColor:(NSString *)textColor{
    [aLab setFont:[UIFont systemFontOfSize:size]];
    [aLab setBackgroundColor:[UIColor clearColor]];
    [aLab setTextColor:[UIColor hexChangeFloat:textColor withAlpha:1.0]];
}

#pragma mark - fixed the origin
+ (void)setFixedView:(UIView *)fixedView withNewPosition:(CGPoint)point
{
    CGRect fixedFrame = [fixedView frame];
    fixedFrame.origin = point;
    [fixedView setFrame:fixedFrame];
}

#pragma mark - fixed the Size
+ (void)setFixedView:(UIView *)fixedView withNewSize:(CGSize)size
{
    CGRect fixedFrame = [fixedView frame];
    fixedFrame.size   = size;
    [fixedView setFrame:fixedFrame];
}

#pragma mark - check String is Empty
+(BOOL)isEmpty:(NSString *)string{
    if (![string isKindOfClass:[NSString class]])
    {
        string = [string description];
    }
    if (string == nil || string == NULL)
    {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0)
    {
        return YES;
    }
    if ([string isEqualToString:@"(null)"])
    {
        return YES;
    }
    if ([string isEqualToString:@"(null)(null)"])
    {
        return YES;
    }
    if ([string isEqualToString:@"<null>"])
    {
        return YES;
    }
    return NO;
}

+ (void)callPhone:(NSString*)phone{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phone];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    AppDelegate *appDelegate = [self getAppdelegate];
    [appDelegate.window addSubview:callWebview];
}

+ (void)sendMessage:(NSString*)phone{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"sms://%@", phone]]];
    
}

+ (BOOL)isMobileNumber:(NSString *)mobileNum{
#if 0
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
    
#endif
    if ([mobileNum length] != 11 || ![[mobileNum substringToIndex:1] isEqualToString:@"1"]) {
        return NO;
    }
    return YES;
}

+ (NSString*)getLargeImage:(NSString*)imageUrl
{
    if (!imageUrl) {
        return @"";
    }
   return  [imageUrl stringByReplacingOccurrencesOfString:@"_X" withString:@"_L"];
}

+ (NSString*)getSmallImage:(NSString*)imageUrl
{
    if (!imageUrl) {
        return @"";
    }
    return  [imageUrl stringByReplacingOccurrencesOfString:@"_X" withString:@"_M"];
}

+ (NSString*)getRawImage:(NSString*)imageUrl
{
    if (!imageUrl) {
        return @"";
    }
    return  [imageUrl stringByReplacingOccurrencesOfString:@"_X" withString:@"_R"];
}

+ (CGFloat)caculateHeightForMessage:(HFMessageTypeInfoData *)messageinfo
                    withMessageType:(MessageType)type

{
    if (type == MSGBOX_FOLLOW_TYPE || type == MSGBOX_PRISE_TYPE) {
        return 90;
    }
    CGFloat height = 70;
    if (type == MSGBOX_COMMENT_TYPE) {
        height += [self heightForCell:messageinfo.content withFont:16.0f withWidth:(kScreenWidth-60-83)];
    }else if (type == MSGBOX_SYSTEM_TYPE) {
        height += [self caculateHeight:messageinfo.content sizeOfWidth:(kScreenWidth-60-15) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    }
    if (height > 135) {
        return 135;
    }else if (height < 90) {
        return 90;
    }else{
        return height;
    }
}

+ (NSString*)getTimeStrFromUTC:(int)seconds
{
    int hours = seconds/3600;
    int minutes = (seconds - hours*3600)/60;
    int second = seconds - hours*3600 - minutes*60;
    NSString *string = [NSString stringWithFormat:@"%02i:%02i:%02i",hours,minutes,second];
    return string;
}

+ (UIImage *)fixOrientation:(UIImage *)aImage
{
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

+ (CGFloat)caculateHeight:(NSString *)text sizeOfWidth:(CGFloat)width withAttributes:(NSDictionary *)attributes
{
    if (text.length == 0) {
        return 0.0f;
    }
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:NULL];
    return rect.size.height;
    
//    if (IOS7_OR_LATER) {
    //        CGRect rect = [text boundingRectWithSize:CGSizeMake(width, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:NULL];
    //return rect.size.height;
//    }else{
//        UIFont *font = [attributes objectForKey:NSFontAttributeName];
//        return [text sizeWithFont:font constrainedToSize:CGSizeMake(width, 2000)].height;
//    }
}

+ (NSString *)transfromFromWeeksStr:(NSString *)weeks
{
    NSMutableString * retStr = [[NSMutableString alloc] init];
    NSMutableArray * days = [[NSMutableArray alloc] init];
    NSArray * dayInfos = [NSArray arrayWithObjects:_T(@"HF_Common_Mon_M"),_T(@"HF_Common_Tus_M"),_T(@"HF_Common_Wen_M"),_T(@"HF_Common_Thu_M"),_T(@"HF_Common_Fri_M"),_T(@"HF_Common_Sat_M"),_T(@"HF_Common_Sun_M"),nil];
    
    for (int i = 0; i < weeks.length; i++) {
        NSString * day = [weeks substringWithRange:NSMakeRange(i, 1)];
        if ([day isEqualToString:@"1"])
        {
            [retStr appendString:[dayInfos objectAtIndex:i]];
            [days addObject:@(i)];
            
            if (i != weeks.length - 1) {
                [retStr appendString:@" "];
            }
        }
    }
    
    if ([days count] == 5 && [[days lastObject] integerValue] == 4)
    {
        [retStr setString:_T(@"HF_Common_Date_Work")];
    }
    else if([days count] == 0)
    {
        [retStr setString:_T(@"HF_Common_Date_Never")];
    }
    else if ([days count] == 7)
    {
        [retStr setString:_T(@"HF_Common_Date_EveryDay")];
    }
    
    return retStr;
}

+ (BOOL)checkSensitiveWords:(NSString *)text
{
    
    NSArray *wordList = [[HFDBCenter shareInstance]getSensitiveWords];
    for (NSString *words in wordList) {
        if ([text rangeOfString:words].length > 0) {
            return NO;
        }
    }
    return YES;
}

+ (HFCaculateHeightModel *)heightForEmojiText:(PostDetailData*)post isMainView:(BOOL)mainView
{
    CGFloat height = mainView?950:110;
    CGFloat kWidth = mainView?kWidthTwo:kWidthThree;
    CGFloat o_x = mainView?60:15;
    
    CGFloat  contentHeight = 0.0;
    
    if (post.title.length>0) {
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:16.0f]};
        contentHeight= [self caculateHeight:post.title sizeOfWidth:kScreenWidth - o_x - 15 withAttributes:attributes];
    }else{
        if (post.content.length>0) {
            contentHeight= [self heightForCell:post.content withFont:16.0f withWidth:kScreenWidth - o_x - 15];
        }
    }
    if (contentHeight<=0) {
        height -= 10;
    }
    
    HFCaculateHeightModel * model = [[HFCaculateHeightModel alloc] init];
    model.state = post.expandFlag;
    
    if (model.state == PostExpandUnkonw)
    {
        if (contentHeight > 90.0)
        {
            model.state = PostExpandUnExpand;
            contentHeight = 115.0;
        }
        else
        {
            model.state = PostExpandNone;
        }
    }
    else if (model.state == PostExpandUnExpand)
    {
        contentHeight = 115.0;
    }
    else if (model.state == PostExpandExpand)
    {
        contentHeight += 30.0;
    }
    
    height += contentHeight ;
    
    NSDictionary *dic = [post toDictionary];
    NSMutableArray *picUrls = [[NSMutableArray alloc]init];
    for (int i = 0; i < 9; i++) {
        NSString *key = [NSString stringWithFormat:@"picAddr%i",i+1];
        NSString *imgStr = [dic objectForKey:key];
        if (imgStr.length>0) {
            [picUrls addObject:imgStr];
        }
    }

    if (picUrls.count == 0) {
        height -= 15;
    }else if (picUrls.count == 1){
        height += kWidth* 1.8;
    }else if (picUrls.count == 4) {
        height += 2*kWidth*1.154 + 5;
    }
    else{
        if (picUrls.count<=3) {
            height += kWidth + 5;
        }else if (picUrls.count<=6) {
            height += 2*kWidth + 10;
        }else {
            height += 3*kWidth + 15;
        }
    }
    model.cellHeight  = height;
    return model;
}

+ (CGFloat)heightForCell:(NSString *)emojiText
                withFont:(CGFloat)fontSize
               withWidth:(CGFloat)width;
{
    static MLEmojiLabel *protypeLabel = nil;
    if (!protypeLabel) {
        protypeLabel = [[MLEmojiLabel alloc]initWithFrame:CGRectZero];
        protypeLabel.numberOfLines = 0;
        protypeLabel.isNeedAtAndPoundSign = YES;
        protypeLabel.customEmojiRegex = @"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]";
        protypeLabel.customEmojiPlistName = @"expression.plist";
    }
    protypeLabel.font = [UIFont systemFontOfSize:fontSize];
    [protypeLabel setText:emojiText];
    
    return [protypeLabel preferredSizeWithMaxWidth:width].height;
}

@end
