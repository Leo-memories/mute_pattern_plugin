#import "MutePatternPlugin.h"
#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface MutePatternPlugin()

@property(nonatomic, copy) FlutterResult flutterResult;

@end

static id _instance = nil;  //定义static全局变量

@implementation MutePatternPlugin

+ (id)shareInstance {
    if (_instance == nil) {
        _instance = [[self alloc] init];
    }
    return _instance;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"mute_pattern_plugin"
            binaryMessenger:[registrar messenger]];
    MutePatternPlugin* instance = [MutePatternPlugin shareInstance];
//    [[MutePatternPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}
- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
      result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else if ([@"checkMutePattern" isEqualToString:call.method]) {
      _flutterResult = result;
      [self monitorMute:result];
  } else {
      result(FlutterMethodNotImplemented);
  }
}

- (void)monitorMute:(FlutterResult)result {
    // 记录开始播放的时间
    startPlayTime = CACurrentMediaTime();
    // 假设本地存放一个长度为 0.2s 的空白音频，detection.aiff
    CFURLRef soundFileURLRef = CFBundleCopyResourceURL(CFBundleGetMainBundle(), CFSTR("detection"), CFSTR("aiff"), NULL);
    SystemSoundID soundFileID;
    AudioServicesCreateSystemSoundID(soundFileURLRef, &soundFileID);
    AudioServicesAddSystemSoundCompletion(soundFileID, NULL, NULL, PlaySoundCompletionBlock, (__bridge void *)self);
    AudioServicesPlaySystemSound(soundFileID);
}

static void PlaySoundCompletionBlock(SystemSoundID SSID, void *clientData) {
    AudioServicesRemoveSystemSoundCompletion(SSID);
    // 播放结束时，记录时间差，如果小于 0.1s，则认为是静音
    CFTimeInterval playDuring = CACurrentMediaTime() - startPlayTime;
    MutePatternPlugin* instance = [MutePatternPlugin shareInstance];
    if (playDuring < 0.1) {
        NSLog(@"静音");
        instance.flutterResult(@"1");
    } else {
        NSLog(@"非静音");
        instance.flutterResult(@"0");
    }
}

static CFTimeInterval startPlayTime;

@end
