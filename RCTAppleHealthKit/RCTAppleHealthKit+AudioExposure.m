#import "RCTAppleHealthKit+AudioExposure.h"
#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+Utils.h"

@implementation RCTAppleHealthKit (AudioExposure)
    
- (void)getHeadphoneAudioExposureSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback {
  HKQuantityType *headphoneAudioExposureType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeadphoneAudioExposure];
  HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit decibelAWeightedSoundPressureLevelUnit]];
  NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
  BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
  NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
  NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];

  NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];
  [self fetchQuantitySamplesOfType:headphoneAudioExposureType
                              unit:unit
                          predicate:predicate
                          ascending:ascending
                              limit:limit
                        completion:^(NSArray *results, NSError *error) {
                          if(results){
                            callback(@[[NSNull null], results]);
                            return;
                          } else {
                            NSString *errStr = [NSString stringWithFormat:@"error getting Headphone Audio Exposure samples: %@", error];
                            NSLog(@"%@", errStr);
                            callback(@[RCTMakeError(errStr, nil, nil)]);
                            return;
                          }
                        }];
}

@end
