#import "RCTAppleHealthKit.h"

@interface RCTAppleHealthKit (AudioExposure)

- (void)getHeadphoneAudioExposureSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)saveEnvironmentalAudioExposureSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;

@end
