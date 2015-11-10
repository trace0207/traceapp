//
//  BandCenter.h
//  GuanHealth
//
//  Created by 栋栋 施 on 15/9/6.
//  Copyright (c) 2015年 ChinaMobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreBluetooth/CBService.h>

typedef NS_ENUM(NSInteger, syncDataCode) {
    SyncDataCode_Success = 0,
    SyncDataCode_NoBlueTooth,
};


typedef void (^BandDeviceBlock) (NSArray *devices);
typedef void (^ConBandFinishBlock) ();
typedef void (^SyncBandBlock) (NSInteger error);
typedef void (^StopSearchBlock) ();
typedef void (^UnBindBlock) (BOOL);
/**
 * 如果需要及时的同步数据 ，请注册此通知
 */
typedef void (^BlueToothBlock) (BOOL);


#define KBandSyncDayDataNotication   @"KBandSyncDataNotication"
#define KBandSync5minDataNotication  @"KBandSync5minDataNotication"

@interface BandCenter : NSObject

SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(BandCenter, shareInstance)

/**
 *  搜索设备
 */
- (void)searchDevice:(BandDeviceBlock)block  andStop:(StopSearchBlock)stop;

/**
 *  获取手环的绑定状态
 */
- (BOOL)getBindStauts;

/**
 *  获取到蓝牙状态
 *
 */
- (void)getBlueTooth:(BlueToothBlock)block;

/**
 *  绑定手环
 */
- (void)bindBand:(CBPeripheral *)dev finish:(ConBandFinishBlock)block;

/**
 *  断开连接
 */
- (void)disConnectBand;

/**
 *  断开绑定
 */
- (void)disBindBand:(UnBindBlock)block;

/**
 *  同步与手环
 */
- (void)syncBandData:(SyncBandBlock)block;

/**
 *  连接到lib库
 */
- (void)connnetLib;

///**
// *  重新设置来电提醒开关
// */
//- (void)resetPhoneCallSwitch:(BOOL)state;
//
///**
// *  重新设置短信
// */
//- (void)resetMsgSwitch:(BOOL)state;

/**
 *  判断手环是不是I5 ，以后可能扩展出更多型号
 *
 *  @return yes or no
 */
- (BOOL)isBandI5;


@end
