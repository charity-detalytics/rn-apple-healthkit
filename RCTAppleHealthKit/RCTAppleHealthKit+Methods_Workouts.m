//
//  RCTAppleHealthKit+Methods_Workouts.m
//  RCTAppleHealthKit
//
//  Created by Xiangxin Sun on 21/1/19.
//  Copyright © 2019 Greg Wilson. All rights reserved.
//

#import "RCTAppleHealthKit+Methods_Workouts.h"
#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+Utils.h"
#import "RCTAppleHealthKit+TypesAndPermissions.h"

@implementation RCTAppleHealthKit (Methods_Workouts)

- (void)workouts_getWorkoutSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback {
  NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
  NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
  if (startDate == nil) {
    callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
    return;
  }
  NSPredicate *predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];
  NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];

  NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc]
                                          initWithKey:HKSampleSortIdentifierEndDate
                                          ascending:NO
                                          ];
  HKSampleQuery *query = [[HKSampleQuery alloc]
                          initWithSampleType:HKSampleType.workoutType
                          predicate:predicate
                          limit:limit
                          sortDescriptors:@[timeSortDescriptor]
                          resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {
                            if (!results) {
                              NSLog(@"error getting workout samples: %@", error);
                              callback(@[RCTMakeError(@"error getting workout samples", nil, nil)]);
                              return;
                            }
                            NSDictionary *numberToWorkoutNameDictionary = [RCTAppleHealthKit getNumberToWorkoutNameDictionary];
                            NSMutableArray *workouts = [NSMutableArray arrayWithCapacity:1];
                            for (HKWorkout *workout in results) {
                              NSTimeInterval duration = [workout duration];
                              double distance = [[workout totalDistance] doubleValueForUnit:[HKUnit meterUnit]];
                              double energy = [[workout totalEnergyBurned] doubleValueForUnit:[HKUnit kilocalorieUnit]];
                              NSNumber *type =  [NSNumber numberWithInt:[workout workoutActivityType]];
                              NSString *startDateString = [RCTAppleHealthKit buildISO8601StringFromDate:workout.startDate];
                              NSString *endDateString = [RCTAppleHealthKit buildISO8601StringFromDate:workout.endDate];
                              double flightsClimbed = 0;
                              if (@available(iOS 11.0, *)) {
                                flightsClimbed = [[workout totalFlightsClimbed] doubleValueForUnit:[HKUnit countUnit]];
                              }
                              double swimmingStroke = [[workout totalSwimmingStrokeCount] doubleValueForUnit:[HKUnit countUnit]];
                              NSDictionary *elem = @{
                                                     @"duration": @(duration),
                                                     @"distance": @(distance),
                                                     @"flightsClimbed": @(flightsClimbed),
                                                     @"start": startDateString,
                                                     @"end": endDateString,
                                                     @"swimmingStroke": @(swimmingStroke),
                                                     @"type": [numberToWorkoutNameDictionary objectForKey:type] ?: @"Other",
                                                     @"energy": @(energy)
                                                     };
                              [workouts addObject:elem];
                            }
                            callback(@[[NSNull null], workouts]);
                          }];
  [self.healthStore executeQuery:query];
}

@end
