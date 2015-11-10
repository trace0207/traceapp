//
//  libIwownBLE.h
//  libIwownBLE
//
//  Created by Jackie on 15/4/27.
//  Copyright (c) 2015年 Jackie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreBluetooth/CBService.h>


typedef enum _tagBLEState{
    kBLEUnBindUnConnectState = 0,   //未绑定未连接
    kBLEUnBindConnectedState,       //未绑定连接
    kBLEPaireState,                 //配对   (已连接)
    KBLEBindUnConnectedState,       //绑定未连接
    kBLEBindConnectedState,         //绑定连接
    KBLEReadDayDataState,           //读一整天的数据(Normally)
}BLEState;

typedef enum _ProtocolVer{
    kProtocolVer1_0 = 0,        //2014年11月之前的协议。
    kProtocolVer2_0 = 1,        //2014年11月之后的协议。
}ProtocolVer;

@protocol libIwownBLEDelegate <NSObject>

@optional

// 各种开关
- (BOOL)phoneCallSwitch;
- (BOOL)qqSwitch;
- (BOOL)wechatSwitch;
- (BOOL)msgSwitch;
- (BOOL)whatsAppSwitch;
- (BOOL)facebookSwitch;
- (BOOL)skypeSwitch;
- (BOOL)twitterSwitch;

/**
 *  读取手环中的久坐提醒信息
 *
 *  @param metionInfo 久坐提醒信息的字典
 */
- (void)libMotionReminder:(NSDictionary *)metionInfo;
/**
 *  读取久坐提醒信息命令开关。设置yes 实现- (NSDictionary *)libMotionReminder; 可获得设置的久坐信息，用于验证写入是否成功
 *
 *  @return yes & no
 */
- (BOOL)readMotionReminder;

@required

/*!
 * 描述:SDK检测到固件的协议变化了，通知APP，目前能使用的是 kProtocolVer2_0，
 * 如果出现 kProtocolVer1_0则在界面上告知用户连接了错误的手环。
 * ver:版本号， kProtocolVer1_0， 1.0协议， kProtocolVer2_0， 2.0协议。
 */
- (void)updateProtocolVerTo:(NSInteger)ver;//

/*!
 * 注意:下面两个函数当第一次连接和断开重连会被call到
 * updateDeviceInfo:
 * 描述:SDK连接上手环之后通知App端设备信息
 * deviceInfo: {@"MODEL":@"I5", @"VERSION":@"1.0.0.1", @"SERIESNO":@"39f27c18eb84"};
 * updateBattery:
 * 描述:SDK连接上手环之后通知App端手环电量
 * batteryLevel: 电量值（80 --> 80%）
 */
- (void)updateDeviceInfo:(NSMutableDictionary *)deviceInfo;     // SDK更新设备信息给App
- (void)updateBattery:(NSInteger)batteryLevel;      // SDK更新电池电量给App

/*!
 * 描述:SDK更新日冻结数据后通知App端
 * dict: {CDATE(yyyyMMdd0000)，CDAY, CMONTH, CYEAR, CCALO, CDIST, CSTEP}
 * App可以call syncDayData 可以主动获取，手环也会定时Notify上来。
 */
- (void)updateDayData:(NSMutableDictionary *)dict;      // 日冻结

/*!
 * 描述:SDK更新分冻结数据后通知App端,SDK在连接后主动update。
 * dict: {CMINUTE CHOUR CDAY CMONTH CYEAR CFLAG CSTEPS CDIST CCALO CCALO}
 */
- (void)update5MinData:(NSMutableDictionary *)dict;     // 分冻结

/*!
 * 描述: APP主动call setKeyNotify:1，让手环进入到拍照模式，手环上出现拍照按钮，
 *      按键或点击按钮手环SDK会通过 notifyToTakePicture 通知App拍照。
 * 注意: setKeyNotify 进入App智拍模式后设置1. 退出拍照界面设置0
 *      需要做拍照保护，拍照在未保存完成前不要开启第二次拍照。
 */
- (void)notifyToTakePicture;

/*!
 * 描述: 长按手环按钮或者点击触屏选择找手机按钮，手环SDK会通过 notifyToSearchPhone告诉App，手环需要找手机。
 *       接下来App可以播放寻找手机的音乐或者其他操作
 */
- (void)notifyToSearchPhone;

/*!
 * 描述: App call了Scan或者findConnectedDevice之后，手环SDK会通过这个接口更新列表到App端，
 *       app可以将数据更新到table上展示。
 */
- (void)updateDeviceSearch:(NSMutableArray *)peripherals;

/*!
 * 描述: 通知设备已经连接上，需做pair检查，才能bind，pair检查请call showPairCodeOnDevice:endBlock:
 */
- (void)didConnectedPeripheralNotice;

/*!
 * 描述: 已检查pair成功的通知，需调用bindDevice和App其他逻辑。
 */
- (void)pairSuccess;

/*!
 * 描述: SDK里面的一些需要show的通知，如果不需要，请直接返回。
 * 需要show的字串是:
 * Please turn on the Bluetooth
 * No device connect now, please connect a device
 * System bluetooth should be repaired, please go to Setting -> Bluetooth -> %d ⓘ -> Forget This Device, Turn off and on system Bluetooth, then repair it in App.
 */
- (void)makeToast:(NSString *)str;

@end


@interface libIwownBLE : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate>

@property (nonatomic, copy)         CBPeripheral *connectedPeri;
@property (nonatomic, assign)       BLEState state;


@property (nonatomic, weak) id<libIwownBLEDelegate> delegate;

/*!
 * 单例对象
 */
+(libIwownBLE *)shareInstance;

/*!
 * 获取SDK版本
 */
- (NSString *)getSDKVersion;

/*!
 * 获取centeral的状态，判断是否开启蓝牙
 */
- (BOOL)getCentralStatus;

/*!
 * scanDevice,扫描设备
 * stopScanDevice,停止扫描设备
 */
- (void)scanDevice;
- (void)stopScanDevice;

/*!
 * retrieveConnectedDevice,重新连接手机和scan一起调用。
 * findConnectedDevice,寻找已绑定或与系统连接设备。
 */
- (void)retrieveConnectedDevice;
- (void)findConnectedDevice;

/*!
 * isDeviceConnected,判断设备是否绑定
 * connectDevice，连接指定设备
 * disConnectCurrentDevice，断开绑定连接的设备
 * disConnectAllDevice，断开所有连接设备
 */
- (BOOL)isDeviceConnected;
- (void)connectDevice:(CBPeripheral *)device;
- (void)disConnectCurrentDevice;
- (void)disConnectAllDevice;

/*!
 * 参数检查pair，成功会call pairsucess的notify
 */
- (void) showPairCodeOnDevice:(BOOL) isShow endBlock:(void(^)()) endBlock; // checking pair --> pair success --> bindDevice

/*!
 * isBind，判断是否绑定
 * bindDevice，绑定设备，配对成功后可以绑定设备
 * unbindDevice，解除绑定，在没有连接的情况下也可解除绑定，会将bindDevice 记录的设备清除
 * debindFromSystem，断开手环和系统连接。慎重调用，只有在手动断开设备连接时可以调用。
 */
- (BOOL)isBind;
- (void)bindDevice;
- (void)unbindDevice;
- (void)debindFromSystem;

/*!
 * 获取数据分主动和被动，主动只能获取日冻结数据，这在用户点击sync按钮的时候需要及时
 * 返回数据刷新页面，被动接受数据的是手环主动发送数据给app端，这个在设备绑定后就会有
 * 数据notify上来，被动的日冻结和主动的日冻结数据格式是一样的，从updateDayData出来
 */
- (BOOL)syncDayData;

/*!
 * 推送字串，比如： [iwownBLE pushStr:@"这是个测试例子"];
 */
- (void)pushStr:(NSString *)str; //推送字串

/*!
 *  发送进入 固件升级的命令。
 ** 只有支持固件升级的设备需要使用，(当前使用nordic的I5PLUS设备平台支持；I5，I6设备不支持）
 */
- (void)deviceUpdate;

/*!
 *        led灯开关，翻腕开关,24小时制和12小时制切换，公英制切换，自动睡眠开关。
 * hwOpt: LED,      WRIST,         UNIT,        HOURS,     SLEEP
 */
//
- (void)setHardWareOption:(NSDictionary *)hwOpt;

/*!
 * setKeyNotify 进入App智拍模式后设置1. 退出拍照界面设置0   // 通知拍照从 - (void)notifyToTakePicture; 出来
 */
- (void)setKeyNotify:(NSUInteger)keyNotify;

/*
 *  dictionary里面是 HEIGHT, WEIGHT, GENDER, AGE, GOAL
 *  HEIGHT: 身高的整数值(NSNumber)，单位CM
 *  WEIGHT: 体重的整数值(NSNumber)，单位KG
 *  GENDER: 性别(NSNumber),1表示女性，0表示男性
 *  AGE:    年龄的整数值(NSNumber)
 *  GOAL:   步数目标的整数值(NSNumber)
 */
- (void)setPersonalInfo:(NSMutableDictionary *)perInfo;

/*
 *系统支持6个闹钟，设置闹钟的时候需要传mutable array，顺序依次为第0到第5个闹钟
 *
 *每个Array成员是一个mutable dictionary，里面包括
 * VISABLE SWITCH HOUR MINUTE REPEAT
 *
 * VISABLE: 表示闹钟是否可见，删除的闹钟或者该编号闹钟没有被添加的VISABLE为0 (NSNumber)
 * SWITCH:  开关状态，闹钟的开关，1表示开。(NSNumber)
 * HOUR:    该闹钟设置的小时数字 (NSNumber)
 * MINUTE:  该闹钟设置的分钟数字 (NSNumber)
 * REPEAT:  该闹钟的重复设置 详情请参考 checkBoxStateChanged 函数。(NSNumber)
 
 //check box的tag从0到6分别表示星期一到星期天，checkbox按下的时候调用下面函数算出 REPEAT 参数的值
 - (Byte) checkBoxStateChanged:(id)sender
 {
 Byte _repeat = 0x00; // _repeat 是从闹钟总览页面进入到选择星期重复页面时候的初始值
 NSLog(@"%s,view.tag = %ld,status=%d",__FUNCTION__,(long)((UIView *)sender).tag,((SSCheckBoxView *)sender).checked);
 
 if (((SSCheckBoxView *)sender).checked == 0) // 从选中到未选中
 {
 _repeat = _repeat&(~(0x01<<(6-((UIView *)sender).tag)));
 }
 else //从未选中到选中
 {
 _repeat = _repeat|(0x01<<(6-((UIView *)sender).tag));
 }
 
 if (_repeat == 0x80) {
 _repeat = 0x0;
 }
 
 if (_repeat != 0) {
 _repeat = _repeat | 0x80;
 }
 
 return _repeat;
 }
 */
- (void)setAlertByIndex:(NSMutableArray *)alertInfo;

/*
 *  dictionary里面是 SWITCH, STARTTIME, ENDTIME, REPEAT
 *  SWITCH:     开关状态，闹钟的开关，1表示开。(NSNumber)
 *  STARTTIME:  开始时间，整数(NSNumber),需要是整点
 *  ENDTIME:    结束时间，整数(NSNumber),需要是整点
 *  REPEAT:     同上
 */
// SWITCH, STARTTIME, ENDTIME, REPEAT
- (void)setMotionRemind:(NSMutableDictionary *)motionInfo;


@end
