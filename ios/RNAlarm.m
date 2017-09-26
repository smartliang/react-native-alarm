
#import "RNAlarm.h"
@import UserNotifications;

@implementation RNAlarm

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    completionHandler(UNNotificationPresentationOptionAlert);
    completionHandler(UNNotificationPresentationOptionSound);
}

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE()

// Thanks, AshFurrow
static const unsigned componentFlags = (NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal);
RCT_EXPORT_METHOD(setAlarm:(NSString *)triggerTime
                  title:(NSString *)title
                  musicUri:(NSString *)musicUri
                  successCallback:(RCTResponseSenderBlock)successCallback
                  errorCallback:(RCTResponseSenderBlock)errorCallback){
    @try
    {
        UNUserNotificationCenter *rCenter = UNUserNotificationCenter.currentNotificationCenter;
        [rCenter requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound)
                               completionHandler:^(BOOL granted, NSError * _Nullable error){
                                   // Enable or disable based on authorization
                               }];
        
        
        
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        //content.title = [NSString localizedUserNotificationStringForKey:@"RNALarm" arguments:nil];
        content.body = [NSString localizedUserNotificationStringForKey:title arguments:nil];
        if(musicUri == nil) {
            content.sound = [UNNotificationSound defaultSound];
        }else {
            content.sound = [UNNotificationSound soundNamed:musicUri];
        }
        NSTimeInterval time =[triggerTime doubleValue];
        NSDate *tgTime = [NSDate dateWithTimeIntervalSinceNow:time];
        NSDateComponents *components = [[NSCalendar autoupdatingCurrentCalendar] components:componentFlags fromDate:tgTime];
        UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:NO];

        //UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
        
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"RNAlarm" content:content trigger:trigger];
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            if(error != nil)
            {
               // NSLog(error.localizedDescription);
                @throw error;
            }
        }];
        
        NSArray *result = [NSArray arrayWithObjects:@"0", nil];
        if(successCallback != nil){
           successCallback(result);
        }
        
    }
    @catch(NSException *exception){
        NSLog(@"%@", exception.reason);
        NSArray *result = [NSArray arrayWithObjects:@"1",exception.reason, nil];
        if(errorCallback != nil) {
            errorCallback(result);
        }
    }
}



RCT_EXPORT_METHOD(setAlarmWithPromise:(NSString *)triggerTime
                  title:(NSString *)title
                  musicUri:(nullable NSString *)musicUri
                  resolver:(RCTPromiseResolveBlock)resolver
                  reject:(RCTPromiseRejectBlock)reject){
    @try
    {
        UNUserNotificationCenter *rCenter = UNUserNotificationCenter.currentNotificationCenter;
        [rCenter requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound)
                               completionHandler:^(BOOL granted, NSError * _Nullable error){
                                   // Enable or disable based on authorization
                               }];
        
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        //content.title = [NSString localizedUserNotificationStringForKey:@"RNALarm" arguments:nil];
        content.body = [NSString localizedUserNotificationStringForKey:title arguments:nil];
        if(musicUri == nil) {
            content.sound = [UNNotificationSound defaultSound];
        }else {
            content.sound = [UNNotificationSound soundNamed:musicUri];
        }
        NSTimeInterval time =[triggerTime doubleValue];
        NSDate *tgTime = [NSDate dateWithTimeIntervalSince1970:time];
        NSDateComponents *components = [[NSCalendar autoupdatingCurrentCalendar] components:componentFlags fromDate:tgTime];
        UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:NO];

        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"RNAlarm" content:content trigger:trigger];
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
            if(error != nil)
            {
                // NSLog(error.localizedDescription);
                @throw error;
            }
        }];

        NSArray *result = [NSArray arrayWithObjects:@"0", nil];
        resolver(result);
    }
    @catch(NSException *exception){
        NSLog(@"%@", exception.reason);
        NSError *error = [[NSError alloc] init];

        reject(@"RNAlarm_Errror", exception.name, error);
    }
}

@end
  
