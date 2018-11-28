//
//  RCTAppleHealthKit+Methods_Activity.m
//  RCTAppleHealthKit
//
//  Created by Alexander Vallorosi on 4/27/17.
//  Copyright © 2017 Alexander Vallorosi. All rights reserved.
//

#import "RCTAppleHealthKit+Methods_Activity.h"
#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+Utils.h"

@implementation RCTAppleHealthKit (Methods_Activity)

- (void)activity_getActiveEnergyBurned:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *activeEnergyType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    HKUnit *cal = [HKUnit kilocalorieUnit];

    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];

    [self fetchQuantitySamplesOfType:activeEnergyType
                                unit:cal
                           predicate:predicate
                           ascending:false
                               limit:HKObjectQueryNoLimit
                          completion:^(NSArray *results, NSError *error) {
                              if(results){
                                  callback(@[[NSNull null], results]);
                                  return;
                              } else {
                                  NSLog(@"error getting active energy burned samples: %@", error);
                                  callback(@[RCTMakeError(@"error getting active energy burned samples", nil, nil)]);
                                  return;
                              }
                          }];
}

- (void)activity_getBasalEnergyBurned:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *basalEnergyType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBasalEnergyBurned];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    HKUnit *cal = [HKUnit kilocalorieUnit];
    
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];
    
    [self fetchQuantitySamplesOfType:basalEnergyType
                                unit:cal
                           predicate:predicate
                           ascending:false
                               limit:HKObjectQueryNoLimit
                          completion:^(NSArray *results, NSError *error) {
                              if(results){
                                  callback(@[[NSNull null], results]);
                                  return;
                              } else {
                                  NSLog(@"error getting basal energy burned samples: %@", error);
                                  callback(@[RCTMakeError(@"error getting basal energy burned samples", nil, nil)]);
                                  return;
                              }
                          }];
    
}

- (void)activity_getActivitySummary:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback {
  NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
  NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
  NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
  NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitEra;
  NSDateComponents *startDateComponents = [calendar components:unit fromDate:startDate];
  startDateComponents.calendar = calendar;
  NSDateComponents *endDateComponents = [calendar components:unit fromDate:endDate];
  endDateComponents.calendar = calendar;
  NSPredicate *summariesWithinRange =
    [HKQuery predicateForActivitySummariesBetweenStartDateComponents:startDateComponents
                                                   endDateComponents:endDateComponents];
  HKActivitySummaryQuery *query =
    [[HKActivitySummaryQuery alloc] initWithPredicate:summariesWithinRange
                                       resultsHandler:^(HKActivitySummaryQuery * _Nonnull query,
                                                        NSArray<HKActivitySummary *> * _Nullable activitySummaries,
                                                        NSError * _Nullable error) {

    if (activitySummaries == nil) {
      NSString *errStr = [NSString stringWithFormat:@"error getting activity summaries: %@", error];
      NSLog(errStr);
      callback(@[RCTMakeError(errStr, nil, nil)]);
    } else {
      NSMutableArray *data = [NSMutableArray arrayWithCapacity:1];
      for (HKActivitySummary *summary in activitySummaries) {
        NSDateComponents *dateComponents = [summary dateComponentsForCalendar:calendar];
        NSDate *date = [calendar dateFromComponents:dateComponents];
        NSString *dateString = [RCTAppleHealthKit buildISO8601StringFromDate:date];
        double exerciseTime = [summary.appleExerciseTime doubleValueForUnit:[HKUnit minuteUnit]];
        double standingHours = [summary.appleStandHours doubleValueForUnit:[HKUnit countUnit]];
        double energyBurned = [summary.activeEnergyBurned doubleValueForUnit:[HKUnit kilocalorieUnit]];
        NSDictionary *elem = @{
                               @"exerciseTime": @(exerciseTime),
                               @"standingHours": @(standingHours),
                               @"energyBurned": @(energyBurned),
                               @"date" : dateString
                               };
        [data addObject:elem];
      }
      callback(@[[NSNull null], data]);
    }
  }];
  [self.healthStore executeQuery:query];
}

@end
