//
//  NSDate+Extension.m
//  Pods
//
//  Created by Kings Yan on 16/4/18.
//
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

- (NSDate *)addComponentWithMonth:(NSUInteger)month
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setMonth:month];
    
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:self options:0];
    return mDate;
}

- (NSDate *)addComponentWithDays:(NSUInteger)days
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:days];
    
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:self options:0];
    return mDate;
}

- (NSDate *)addComponentWithHour:(NSUInteger)hour
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setHour:hour];
    
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:self options:0];
    return mDate;
}

- (NSInteger)getHour
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:NSHourCalendarUnit fromDate:self];
    
    return [components hour];
}

- (NSInteger)getMinute
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:NSMinuteCalendarUnit fromDate:self];
    
    return [components minute];
}

- (NSInteger)compareDaysWithDateObject:(NSDate *)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned int unitFlag = NSDayCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlag fromDate:self toDate:date options:0];
    NSInteger days = [components day];
    return days;
}

- (NSString *)getDateStringWithFormatter:(NSString *)formate
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = formate;
    return [formatter stringFromDate:self];
}

@end
