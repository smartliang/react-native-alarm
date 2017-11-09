
#if __has_include("RCTBridgeModule.h")
#import "RCTBridgeModule.h"
#else
#import <React/RCTBridgeModule.h>
#endif
@import UserNotifications;
@import UIKit;

@interface RNAlarm : NSObject <RCTBridgeModule, UNUserNotificationCenterDelegate>
//-(void)playSound();
@end
  
