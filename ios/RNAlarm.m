
#import "RNAlarm.h"
@import UserNotifications;

@implementation RNAlarm

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE()

// Thanks, AshFurrow
static const unsigned componentFlags = (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit);
RCT_EXPORT_METHOD(setAlarm:(NSString *)triggerTime
                  title:(NSString *)title
                  musicUri:(nullable NSString *)musicUri
                  successCallback:(RCTResponseSenderBlock)successCallback
                  errorCallback:(RCTResponseSenderBlock)errorCallback){
    @try
    {
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = [NSString localizedUserNotificationStringForKey:@"RNALarm" arguments:nil];
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


RCT_EXPORT_METHOD(setAlarm:(NSString *)triggerTime
                  title:(NSString *)title
                  musicUri:(nullable NSString *)musicUri
                  resolver:(RCTPromiseResolveBlock)resolver
                  reject:(RCTPromiseRejectBlock)reject){
    @try
    {
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = [NSString localizedUserNotificationStringForKey:@"RNALarm" arguments:nil];
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
  
