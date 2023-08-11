//
//  RCTAppleHealthKit+Methods_Workouts.h
//  RCTAppleHealthKit
//
//  Created by Xiangxin Sun on 21/1/19.
//  Copyright © 2019 Greg Wilson. All rights reserved.
//

#import "RCTAppleHealthKit.h"

@interface RCTAppleHealthKit (Methods_Workouts)

- (void)workouts_getWorkoutSamples:(NSDictionary *)input callback:(RCTResponseSenderBlock)callback;
- (void)workouts_saveSamples:(NSArray<NSDictionary *> *)samples callback:(RCTResponseSenderBlock)callback;

@end
