#import "RCTAppleHealthKit+Mutations.h"
#import "RCTAppleHealthKit+Utils.h"

#import <React/RCTBridgeModule.h>
#import <React/RCTEventDispatcher.h>

@implementation RCTAppleHealthKit (Mutations)

- (void)saveQuantitySamples:(NSArray<NSDictionary *> *)samples quantityType:(HKQuantityType *)quantityType unit:(HKUnit *)unit completion:(void (^)(NSError *))completionHandler {
    NSMutableArray *sampleArray = [NSMutableArray array];

    for (NSDictionary *sampleDict in samples) {
        double value = [RCTAppleHealthKit doubleValueFromOptions:sampleDict];
        NSDate *startDate = [RCTAppleHealthKit dateFromOptions:sampleDict key:@"startDate" withDefault:nil];
        NSDate *endDate = [RCTAppleHealthKit dateFromOptions:sampleDict key:@"endDate" withDefault:nil];

        HKQuantity *quantityValue = [HKQuantity quantityWithUnit:unit doubleValue:value];
        HKQuantitySample *sample = [HKQuantitySample quantitySampleWithType:quantityType quantity:quantityValue startDate:startDate endDate:endDate];

        [sampleArray addObject:sample];
    }

    [self.healthStore saveObjects:sampleArray
                   withCompletion:^(BOOL success, NSError *error) {
                     if (!success) {
                         completionHandler(error);
                         return;
                     }
                     completionHandler(nil);
                   }];
}

@end
