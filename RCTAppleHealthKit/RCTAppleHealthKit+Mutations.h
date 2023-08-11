#import "RCTAppleHealthKit.h"

@interface RCTAppleHealthKit (Mutations)

- (void)saveQuantitySamples:(NSArray<NSDictionary *> *)samples quantityType:(HKQuantityType *)quantityType unit:(HKUnit *)unit completion:(void (^)(NSError *))completionHandler;

@end
