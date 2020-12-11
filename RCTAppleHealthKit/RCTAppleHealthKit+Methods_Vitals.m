#import "RCTAppleHealthKit+Methods_Vitals.h"
#import "RCTAppleHealthKit+Queries.h"
#import "RCTAppleHealthKit+Utils.h"

@implementation RCTAppleHealthKit (Methods_Vitals)


- (void)vitals_getHeartRateSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityTypeIdentifier identifier;
    BOOL resting = [[input objectForKey:@"resting"] boolValue];
    if (resting) {
      if (@available(iOS 11.0, *)) {
        identifier = HKQuantityTypeIdentifierRestingHeartRate;
      } else {
        callback(@[RCTMakeError(@"Resting heart rate is only available on iOS 11 and above", nil, nil)]);
        return;
      }
    } else {
      identifier = HKQuantityTypeIdentifierHeartRate;
    }

    HKQuantityType *heartRateType = [HKQuantityType quantityTypeForIdentifier:identifier];

    HKUnit *count = [HKUnit countUnit];
    HKUnit *minute = [HKUnit minuteUnit];

    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[count unitDividedByUnit:minute]];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];

    [self fetchQuantitySamplesOfType:heartRateType
                                unit:unit
                           predicate:predicate
                           ascending:ascending
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


- (void)vitals_getBodyTemperatureSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *bodyTemperatureType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyTemperature];

    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit degreeCelsiusUnit]];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];

    [self fetchQuantitySamplesOfType:bodyTemperatureType
                                unit:unit
                           predicate:predicate
                           ascending:ascending
                               limit:limit
                          completion:^(NSArray *results, NSError *error) {
        if(results){
            callback(@[[NSNull null], results]);
            return;
        } else {
            NSLog(@"error getting body temperature samples: %@", error);
            callback(@[RCTMakeError(@"error getting body temperature samples", nil, nil)]);
            return;
        }
    }];
}


- (void)vitals_getBloodPressureSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKCorrelationType *bloodPressureCorrelationType = [HKCorrelationType correlationTypeForIdentifier:HKCorrelationTypeIdentifierBloodPressure];
    HKQuantityType *systolicType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureSystolic];
    HKQuantityType *diastolicType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureDiastolic];


    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[HKUnit millimeterOfMercuryUnit]];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];

    [self fetchCorrelationSamplesOfType:bloodPressureCorrelationType
                                   unit:unit
                           predicate:predicate
                           ascending:ascending
                               limit:limit
                          completion:^(NSArray *results, NSError *error) {
        if(results){
            NSMutableArray *data = [NSMutableArray arrayWithCapacity:1];

            for (NSDictionary *sample in results) {
                HKCorrelation *bloodPressureValues = [sample valueForKey:@"correlation"];

                HKQuantitySample *bloodPressureSystolicValue = [bloodPressureValues objectsForType:systolicType].anyObject;
                HKQuantitySample *bloodPressureDiastolicValue = [bloodPressureValues objectsForType:diastolicType].anyObject;

                NSDictionary *elem = @{
                                       @"bloodPressureSystolicValue" : @([bloodPressureSystolicValue.quantity doubleValueForUnit:unit]),
                                       @"bloodPressureDiastolicValue" : @([bloodPressureDiastolicValue.quantity doubleValueForUnit:unit]),
                                       @"startDate" : [sample valueForKey:@"startDate"],
                                       @"endDate" : [sample valueForKey:@"endDate"],
                                      };

                [data addObject:elem];
            }

            callback(@[[NSNull null], data]);
            return;
        } else {
            NSLog(@"error getting blood pressure samples: %@", error);
            callback(@[RCTMakeError(@"error getting blood pressure samples", nil, nil)]);
            return;
        }
    }];
}


- (void)vitals_getRespiratoryRateSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback
{
    HKQuantityType *respiratoryRateType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierRespiratoryRate];

    HKUnit *count = [HKUnit countUnit];
    HKUnit *minute = [HKUnit minuteUnit];

    HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:[count unitDividedByUnit:minute]];
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    if(startDate == nil){
        callback(@[RCTMakeError(@"startDate is required in options", nil, nil)]);
        return;
    }
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];

    [self fetchQuantitySamplesOfType:respiratoryRateType
                                unit:unit
                           predicate:predicate
                           ascending:ascending
                               limit:limit
                          completion:^(NSArray *results, NSError *error) {
        if(results){
            callback(@[[NSNull null], results]);
            return;
        } else {
            NSLog(@"error getting respiratory rate samples: %@", error);
            callback(@[RCTMakeError(@"error getting respiratory rate samples", nil, nil)]);
            return;
        }
    }];
}

- (void)vitals_getVo2MaxSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback {
  HKQuantityType *vo2MaxType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierVO2Max];

  HKUnit *ml = [HKUnit literUnitWithMetricPrefix:HKMetricPrefixMilli];
  HKUnit *kg = [HKUnit gramUnitWithMetricPrefix:HKMetricPrefixKilo];
  HKUnit *min = [HKUnit minuteUnit];
  HKUnit *u = [ml unitDividedByUnit:[kg unitMultipliedByUnit:min]]; // ml/(kg*min)

  HKUnit *unit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"unit" withDefault:u];
  NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
  BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
  NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
  NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];

  NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];
  [self fetchQuantitySamplesOfType:vo2MaxType
                              unit:unit
                         predicate:predicate
                         ascending:ascending
                             limit:limit
                        completion:^(NSArray *results, NSError *error) {
                          if(results){
                            callback(@[[NSNull null], results]);
                            return;
                          } else {
                            NSString *errStr = [NSString stringWithFormat:@"error getting Vo2Max samples: %@", error];
                            NSLog(errStr);
                            callback(@[RCTMakeError(errStr, nil, nil)]);
                            return;
                          }
                        }];
}


- (void)vitals_getEcgSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback {
    HKElectrocardiogramType *ecgType = [HKObjectType electrocardiogramType];
    
    NSDate *startDate = [RCTAppleHealthKit dateFromOptions:input key:@"startDate" withDefault:nil];
    NSDate *endDate = [RCTAppleHealthKit dateFromOptions:input key:@"endDate" withDefault:[NSDate date]];
    NSPredicate * predicate = [RCTAppleHealthKit predicateForSamplesBetweenDates:startDate endDate:endDate];
    
    NSUInteger limit = [RCTAppleHealthKit uintFromOptions:input key:@"limit" withDefault:HKObjectQueryNoLimit];
    
    BOOL ascending = [RCTAppleHealthKit boolFromOptions:input key:@"ascending" withDefault:false];
    NSSortDescriptor *timeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:HKSampleSortIdentifierEndDate
                                                                       ascending:ascending];
    
    HKSampleQuery *query = [[HKSampleQuery alloc] initWithSampleType:ecgType
                                                           predicate:predicate
                                                               limit:limit
                                                     sortDescriptors:@[timeSortDescriptor]
                                                      resultsHandler:^(HKSampleQuery *query, NSArray *results, NSError *error) {
        if (error != nil) {
            NSLog(@"error with sample query: %@", error);
            callback(@[RCTMakeError(@"error with sample query", error, nil)]);
            return;
        }
        __block NSMutableArray *data = [NSMutableArray arrayWithCapacity:10];
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_group_t group = dispatch_group_create();
        HKUnit *voltUnit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"voltUnit" withDefault:[HKUnit voltUnit]];
        
        HKUnit *count = [HKUnit countUnit];
        HKUnit *minute = [HKUnit minuteUnit];
        HKUnit *heartRateUnit = [RCTAppleHealthKit hkUnitFromOptions:input key:@"heartRateUnit" withDefault:[count unitDividedByUnit:minute]];
        
        for (HKElectrocardiogram *sample in results) {
            __block NSMutableDictionary *sampleDatum = [NSMutableDictionary new];
            sampleDatum[@"startDate"] = [RCTAppleHealthKit buildISO8601StringFromDate:sample.startDate];
            sampleDatum[@"endDate"] = [RCTAppleHealthKit buildISO8601StringFromDate:sample.endDate];
            sampleDatum[@"sourceId"] = [[[sample sourceRevision] source] bundleIdentifier];
            sampleDatum[@"sourceName"] = [[[sample sourceRevision] source] name];
            sampleDatum[@"numberOfVoltageMeasurements"] = @([sample numberOfVoltageMeasurements]);
            sampleDatum[@"samplingFrequency"] = @([[sample samplingFrequency] doubleValueForUnit:[HKUnit hertzUnit]]);
            sampleDatum[@"classification"] = @([sample classification]);
            sampleDatum[@"averageHeartRate"] = @([[sample averageHeartRate] doubleValueForUnit:heartRateUnit]);
            sampleDatum[@"symptomsStatus"] = @([sample symptomsStatus]);
            sampleDatum[@"voltageMeasurements"] = [NSMutableArray new];
            
            dispatch_group_async(group, queue, ^{
                dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
                
                NSLog(@"Block START");
                HKElectrocardiogramQuery *voltageQuery = [[HKElectrocardiogramQuery alloc] initWithElectrocardiogram:sample
                                                                                                         dataHandler:^(HKElectrocardiogramQuery *query, HKElectrocardiogramVoltageMeasurement *voltageMeasurement, BOOL done, NSError *error) {
                    if (done) {
                        NSLog(@"done %@", sample);
                        [data addObject:sampleDatum];
                        dispatch_semaphore_signal(semaphore);
                    } else if (error != nil) {
                        NSLog(@"err %@", error);
                        [data addObject:sampleDatum];
                        dispatch_semaphore_signal(semaphore);
                    } else {
                        HKQuantity *voltageQuantity = [voltageMeasurement quantityForLead:HKElectrocardiogramLeadAppleWatchSimilarToLeadI];
                        [sampleDatum[@"voltageMeasurements"] addObject:@{
                            @"timeSinceSampleStart": @([voltageMeasurement timeSinceSampleStart]),
                            @"voltageQuantity": @([voltageQuantity doubleValueForUnit:voltUnit]),
                        }];
                    }
                }];
                
                [self.healthStore executeQuery:voltageQuery];
                dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
                NSLog(@"Block END");
            });
        }
        
        dispatch_group_notify(group, queue,^{
            NSLog(@"FINAL block");
            callback(@[[NSNull null], data]);
        });
    }];
    
    [self.healthStore executeQuery:query];
}

@end
