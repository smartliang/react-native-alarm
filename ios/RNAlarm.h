
#if __has_include("RCTBridgeModule.h")
#import "RCTBridgeModule.h"
#else
#import <React/RCTBridgeModule.h>
#endif
@import UserNotifications;

@interface RNAlarm : NSObject <RCTBridgeModule, UNUserNotificationCenterDelegate>

@end
  
