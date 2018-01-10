//
//  AppleAPIHelper+Event.m
//  NewFrame
//
//  Created by 张超 on 2017/6/5.
//  Copyright © 2017年 orzer. All rights reserved.
//

#import "CUISystemService+Event.h"

NS_ASSUME_NONNULL_BEGIN


@implementation CUISystemService (Event)

- (void)cui_accessForEventKitType:(EKEntityType)type result:(void(^)(BOOL))result
{
    [self.cui_event_store requestAccessToEntityType:type completion:^(BOOL granted, NSError * _Nullable error) {
        if (!granted) {
            NSLog(@"%@",error);
        }
        if (result) {
            result(granted);
        }
    }];
}

- (BOOL)cui_accessForEventKit:(EKEntityType)type
{
    return [EKEventStore authorizationStatusForEntityType:type] == EKAuthorizationStatusAuthorized;
}

- (NSArray*)cui_calendarWithType:(EKEntityType)type
{
    return [self.cui_event_store calendarsForEntityType:type];
}

- (EKSource*)cui_sourceWithType:(EKSourceType)type
{
    EKSource *localSource = nil;
//    NSLog(@"source %@",self.cui_event_store.sources);
    for (EKSource *source in self.cui_event_store.sources)
    {
        if (source.sourceType == type)
        {
            localSource = source;
            break;
        }
    }
    return localSource;
}

- (nullable NSString *)cui_calendarIdentifierWithKey:(NSString *)key
{
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    NSString* calendarIdentifier = [def valueForKey:key];
    return calendarIdentifier;
}

- (void)cui_setIdentifier:(NSString *)identifier withCalendarKey:(NSString *)key
{
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    [def setValue:identifier forKey:key];
    [def synchronize];
}

- (EKCalendar *)cui_createOrGetCalendarWithIdentifier:(NSString *)identifier type:(EKEntityType)type createBlock:(void (^)(EKCalendar* calendar))createBlock;
{
    if (identifier) {
        EKCalendar* calendar = [self.cui_event_store calendarWithIdentifier:identifier];
        if (calendar) {
            return calendar;
        }
    }
    EKCalendar* calendar = [EKCalendar calendarForEntityType:type eventStore:self.cui_event_store];
    if(createBlock)
    {
        createBlock(calendar);
    }
    return calendar;
}



@end

NS_ASSUME_NONNULL_END
