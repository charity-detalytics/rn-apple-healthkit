#import "RCTAppleHealthKit.h"

@interface RCTAppleHealthKit (AudioExposure)

- (void)getEnvironmentalAudioExposureSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)getHeadphoneAudioExposureSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

@end
