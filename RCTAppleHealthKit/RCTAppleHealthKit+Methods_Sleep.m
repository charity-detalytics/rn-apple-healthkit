//
//  RCTAppleHealthKit+Methods_Sleep.m
//  RCTAppleHealthKit
//
//  Created by Greg Wilson on 2016-11-06.
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//


#import "RCTAppleHealthKit+Methods_Sleep.h"
#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+Utils.h"

@implementation RCTAppleHealthKit (Methods_Sleep)



- (void)sleep_getSleepSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    
    NSPredicate *predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    
    
    [self fetchSleepCategorySamplesForPredicate:predicate
                                          limit:limit
                                     completion:^(NSArray *results, NSError *error) {
                                         if(results){
                                             callback(@[[NSNull null], results]);
                                             return;
                                         } else {
                                             callback(@[RCTJSErrorFromNSError(error)]);
                                             return;
                                         }
                                     }];
    
}

- (void)sleep_saveSleepSamples:(NSArray<NSDictionary *> *)samples callback:(RCTResponseSenderBlock)callback {
    NSMutableArray *sampleArray = [NSMutableArray array];

    for (NSDictionary *sampleDict in samples) {
        NSDate *startDate = [RCTAppleHealthKit dateFromOptions:sampleDict key:@"startDate" withDefault:nil];
        NSDate *endDate = [RCTAppleHealthKit dateFromOptions:sampleDict key:@"endDate" withDefault:nil];
        NSString *value = [RCTAppleHealthKit stringFromOptions:sampleDict key:@"value" withDefault:@"INBED"];
        HKCategoryValueSleepAnalysis valueSleepAnalysis = HKCategoryValueSleepAnalysisAsleepUnspecified;
        if ([value isEqualToString:@"INBED"]) {
            valueSleepAnalysis = HKCategoryValueSleepAnalysisInBed;
        }
        HKCategoryType *typeSleepAnalysis = [HKCategoryType categoryTypeForIdentifier:HKCategoryTypeIdentifierSleepAnalysis];

        HKCategorySample *sample = [HKCategorySample categorySampleWithType:typeSleepAnalysis value:valueSleepAnalysis startDate:startDate endDate:endDate];

        [sampleArray addObject:sample];
    }

    [self.healthStore saveObjects:sampleArray
                   withCompletion:^(BOOL success, NSError *error) {
                     if (!success) {
                         callback(@[ RCTJSErrorFromNSError(error) ]);
                         return;
                     }
                     callback(@[ [NSNull null] ]);
                   }];
}

@end
