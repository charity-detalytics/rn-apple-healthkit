#import "RCTAppleHealthKit+TimeInDaylight.h"
#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+Utils.h"

@implementation RCTAppleHealthKit (TimeInDaylight)
    
- (void)getTimeInDaylightSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback {
  HKQuantityType *timeInDayLightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierTimeInDaylight];
  HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit minuteUnit]];
  NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
  BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
  NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
  NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];

  NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];
  [self fetchQuantitySamplesOfType:timeInDayLightType
                              unit:unit
                          predicate:predicate
                          ascending:ascending
                              limit:limit
                        completion:^(NSArray *results, NSError *error) {
                          if(results){
                            callback(@[[NSNull null], results]);
                            return;
                          } else {
                            NSString *errStr = [NSString stringWithFormat:@"error getting Time In Daylight samples: %@", error];
                            NSLog(@"%@", errStr);
                            callback(@[RCTMakeError(errStr, nil, nil)]);
                            return;
                          }
                        }];
}

@end
