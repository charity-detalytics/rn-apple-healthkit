//
//  RCTAppleHealthKit+TypesAndPermissions.m
//  RCTAppleHealthKit
//
//  Created by Greg Wilson on 2016-06-26.
//  This source code is licensed under the MIT-style license found in the
//  LICENSE file in the root directory of this source tree.
//

#import "RCTAppleHealthKit+TypesAndPermissions.h"

@implementation RCTAppleHealthKit (TypesAndPermissions)

#pragma mark - HealthKit Permissions

- (nullable HKObjectType *)getReadPermFromText:(nonnull NSString*)key {
    UIDevice *deviceInfo = [UIDevice currentDevice];
    float systemVersion = deviceInfo.systemVersion.floatValue;

    // Characteristic Identifiers
    if ([@"DateOfBirth" isEqualToString: key]) {
        return [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierDateOfBirth];
    }else if ([@"Height" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    }else if ([@"Weight" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    }else if ([@"BiologicalSex" isEqualToString: key]) {
        return [HKObjectType characteristicTypeForIdentifier:HKCharacteristicTypeIdentifierBiologicalSex];
    }

    // Body Measurements
    if ([@"BodyMass" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    }else if ([@"BodyFatPercentage" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyFatPercentage];
    }else if ([@"BodyMassIndex" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMassIndex];
    }else if ([@"LeanBodyMass" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierLeanBodyMass];
    }

    // Fitness Identifiers
    if ([@"Steps" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    }else if ([@"StepCount" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    }else if ([@"DistanceWalkingRunning" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    }else if ([@"DistanceCycling" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceCycling];
    }else if ([@"BasalEnergyBurned" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBasalEnergyBurned];
    }else if ([@"ActiveEnergyBurned" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
    }else if ([@"FlightsClimbed" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierFlightsClimbed];
    }else if ([@"NikeFuel" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierNikeFuel];
    }

//    if ([@"AppleExerciseTime" isEqualToString: key]) {
//        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierAppleExerciseTime];
//    }

    // Nutrition Identifiers
    if ([@"DietaryEnergy" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryEnergyConsumed];
    }

    // Vital Signs Identifiers
    if ([@"HeartRate" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate];
    }else if ([@"BodyTemperature" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyTemperature];
    }else if ([@"BloodPressureSystolic" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureSystolic];
    }else if ([@"BloodPressureDiastolic" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodPressureDiastolic];
    }else if ([@"RespiratoryRate" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierRespiratoryRate];
    }

    // Results Identifiers
    if ([@"BloodGlucose" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBloodGlucose];
    }

    // Sleep
    if ([@"SleepAnalysis" isEqualToString: key]) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierSleepAnalysis];
    }

    // workouts
    if ([@"MindfulSession" isEqualToString: key] && systemVersion >= 10.0) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierMindfulSession];
    } else if ([@"MindfulSession" isEqualToString: key]){
        return [HKObjectType workoutType];
    }

    if ([@"Vo2Max" isEqualToString: key] && systemVersion >= 11.0) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierVO2Max];
    }

    if ([@"RestingHeartRate" isEqualToString: key] && systemVersion >= 11.0) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierRestingHeartRate];
    }

    if ([@"ActivitySummary" isEqualToString: key]) {
        return [HKObjectType activitySummaryType];
    }

    if ([@"Workouts" isEqualToString: key]) {
        return [HKObjectType workoutType];
    }

    if ([@"ECG" isEqualToString: key] && systemVersion >= 14.0) {
        return [HKObjectType electrocardiogramType];
    }

    if ([@"BloodOxygen" isEqualToString: key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierOxygenSaturation];
    }

    return nil;
}

- (nullable HKObjectType *)getWritePermFromText:(nonnull NSString*) key {


    // Body Measurements
    if([@"Height" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    } else if([@"Weight" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    } else if([@"BodyMass" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMass];
    } else if([@"BodyFatPercentage" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyFatPercentage];
    } else if([@"BodyMassIndex" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBodyMassIndex];
    } else if([@"LeanBodyMass" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierLeanBodyMass];
    }

    // Fitness Identifiers
    if([@"Steps" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    } else if([@"StepCount" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    } else if([@"DistanceWalkingRunning" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    } else if([@"DistanceCycling" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceCycling];
    } else if([@"BasalEnergyBurned" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierBasalEnergyBurned];
    } else if([@"ActiveEnergyBurned" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
    } else if([@"FlightsClimbed" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierFlightsClimbed];
    }

    // Nutrition Identifiers
    if([@"Biotin" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryBiotin];
    } else if([@"Caffeine" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryCaffeine];
    } else if([@"Calcium" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryCalcium];
    } else if([@"Carbohydrates" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryCarbohydrates];
    } else if([@"Chloride" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryChloride];
    } else if([@"Cholesterol" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryCholesterol];
    } else if([@"Copper" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryCopper];
    } else if([@"EnergyConsumed" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryEnergyConsumed];
    } else if([@"FatMonounsaturated" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryFatMonounsaturated];
    } else if([@"FatPolyunsaturated" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryFatPolyunsaturated];
    } else if([@"FatSaturated" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryFatSaturated];
    } else if([@"FatTotal" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryFatTotal];
    } else if([@"Fiber" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryFiber];
    } else if([@"Folate" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryFolate];
    } else if([@"Iodine" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryIodine];
    } else if([@"Iron" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryIron];
    } else if([@"Magnesium" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryMagnesium];
    } else if([@"Manganese" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryManganese];
    } else if([@"Molybdenum" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryMolybdenum];
    } else if([@"Niacin" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryNiacin];
    } else if([@"PantothenicAcid" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryPantothenicAcid];
    } else if([@"Phosphorus" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryPhosphorus];
    } else if([@"Potassium" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryPotassium];
    } else if([@"Protein" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryProtein];
    } else if([@"Riboflavin" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryRiboflavin];
    } else if([@"Selenium" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietarySelenium];
    } else if([@"Sodium" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietarySodium];
    } else if([@"Sugar" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietarySugar];
    } else if([@"Thiamin" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryThiamin];
    } else if([@"VitaminA" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryVitaminA];
    } else if([@"VitaminB12" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryVitaminB12];
    } else if([@"VitaminB6" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryVitaminB6];
    } else if([@"VitaminC" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryVitaminC];
    } else if([@"VitaminD" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryVitaminD];
    } else if([@"VitaminE" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryVitaminE];
    } else if([@"VitaminK" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryVitaminK];
    } else if([@"Zinc" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryZinc];
    } else if([@"Water" isEqualToString:key]) {
        return [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDietaryWater];
    }

    // Sleep
    if([@"SleepAnalysis" isEqualToString:key]) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierSleepAnalysis];
    }

    // Mindfulness
    if([@"MindfulSession" isEqualToString:key]) {
        return [HKObjectType categoryTypeForIdentifier:HKCategoryTypeIdentifierMindfulSession];
    }
    return nil;
}

// Returns HealthKit read permissions from options array
- (NSSet *)getReadPermsFromOptions:(NSArray *)options {
    NSMutableSet *readPermSet = [NSMutableSet setWithCapacity:1];

    for(int i=0; i<[options count]; i++) {
        NSString *optionKey = options[i];
        if(optionKey != nil){
            HKObjectType *val = [self getReadPermFromText:optionKey];
            if(val != nil) {
                [readPermSet addObject:val];
            }
        }
    }
    return readPermSet;
}


// Returns HealthKit write permissions from options array
- (NSSet *)getWritePermsFromOptions:(NSArray *)options {
    NSMutableSet *writePermSet = [NSMutableSet setWithCapacity:1];

    for(int i=0; i<[options count]; i++) {
        NSString *optionKey = options[i];
        if(optionKey != nil){
            HKObjectType *val = [self getWritePermFromText:optionKey];
            if(val != nil) {
                [writePermSet addObject:val];
            }
        }
    }
    return writePermSet;
}

NSString * const AmericanFootball = @"AmericanFootball";
NSString * const Archery = @"Archery";
NSString * const AustralianFootball = @"AustralianFootball";
NSString * const Badminton = @"Badminton";
NSString * const Baseball = @"Baseball";
NSString * const Basketball = @"Basketball";
NSString * const Bowling = @"Bowling";
NSString * const Boxing = @"Boxing";
NSString * const Climbing = @"Climbing";
NSString * const Cricket = @"Cricket";
NSString * const CrossTraining = @"CrossTraining";
NSString * const Curling = @"Curling";
NSString * const Cycling = @"Cycling";
NSString * const Dance = @"Dance";
NSString * const Elliptical = @"Elliptical";
NSString * const EquestrianSports = @"EquestrianSports";
NSString * const Fencing = @"Fencing";
NSString * const Fishing = @"Fishing";
NSString * const FunctionalStrengthTraining = @"FunctionalStrengthTraining";
NSString * const Golf = @"Golf";
NSString * const Gymnastics = @"Gymnastics";
NSString * const Handball = @"Handball";
NSString * const Hiking = @"Hiking";
NSString * const Hockey = @"Hockey";
NSString * const Hunting = @"Hunting";
NSString * const Lacrosse = @"Lacrosse";
NSString * const MartialArts = @"MartialArts";
NSString * const MindAndBody = @"MindAndBody";
NSString * const PaddleSports = @"PaddleSports";
NSString * const Play = @"Play";
NSString * const PreparationAndRecovery = @"PreparationAndRecovery";
NSString * const Racquetball = @"Racquetball";
NSString * const Rowing = @"Rowing";
NSString * const Rugby = @"Rugby";
NSString * const Running = @"Running";
NSString * const Sailing = @"Sailing";
NSString * const SkatingSports = @"SkatingSports";
NSString * const SnowSports = @"SnowSports";
NSString * const Soccer = @"Soccer";
NSString * const Softball = @"Softball";
NSString * const Squash = @"Squash";
NSString * const StairClimbing = @"StairClimbing";
NSString * const SurfingSports = @"SurfingSports";
NSString * const Swimming = @"Swimming";
NSString * const TableTennis = @"TableTennis";
NSString * const Tennis = @"Tennis";
NSString * const TrackAndField = @"TrackAndField";
NSString * const TraditionalStrengthTraining = @"TraditionalStrengthTraining";
NSString * const Volleyball = @"Volleyball";
NSString * const Walking = @"Walking";
NSString * const WaterFitness = @"WaterFitness";
NSString * const WaterPolo = @"WaterPolo";
NSString * const WaterSports = @"WaterSports";
NSString * const Wrestling = @"Wrestling";
NSString * const Yoga = @"Yoga";
NSString * const Barre = @"Barre";
NSString * const CoreTraining = @"CoreTraining";
NSString * const CrossCountrySkiing = @"CrossCountrySkiing";
NSString * const DownhillSkiing = @"DownhillSkiing";
NSString * const Flexibility = @"Flexibility";
NSString * const HighIntensityIntervalTraining = @"HighIntensityIntervalTraining";
NSString * const JumpRope = @"JumpRope";
NSString * const Kickboxing = @"Kickboxing";
NSString * const Pilates = @"Pilates";
NSString * const Snowboarding = @"Snowboarding";
NSString * const Stairs = @"Stairs";
NSString * const StepTraining = @"StepTraining";
NSString * const WheelchairWalkPace = @"WheelchairWalkPace";
NSString * const WheelchairRunPace = @"WheelchairRunPace";
NSString * const TaiChi = @"TaiChi";
NSString * const MixedCardio = @"MixedCardio";
NSString * const HandCycling = @"HandCycling";

+ (NSDictionary *)getNumberToWorkoutNameDictionary {
  return @{
           @(HKWorkoutActivityTypeAmericanFootball) : AmericanFootball,
           @(HKWorkoutActivityTypeArchery) : Archery,
           @(HKWorkoutActivityTypeAustralianFootball) : AustralianFootball,
           @(HKWorkoutActivityTypeBadminton) : Badminton,
           @(HKWorkoutActivityTypeBaseball) : Baseball,
           @(HKWorkoutActivityTypeBasketball) : Basketball,
           @(HKWorkoutActivityTypeBowling) : Bowling,
           @(HKWorkoutActivityTypeBoxing)  : Boxing,
           @(HKWorkoutActivityTypeClimbing) : Climbing,
           @(HKWorkoutActivityTypeCricket) : Cricket,
           @(HKWorkoutActivityTypeCrossTraining)  : CrossTraining,
           @(HKWorkoutActivityTypeCurling) : Curling,
           @(HKWorkoutActivityTypeCycling) : Cycling,
           @(HKWorkoutActivityTypeDance) : Dance,
           @(HKWorkoutActivityTypeElliptical) : Elliptical,
           @(HKWorkoutActivityTypeEquestrianSports)  : EquestrianSports,
           @(HKWorkoutActivityTypeFencing) : Fencing,
           @(HKWorkoutActivityTypeFishing) : Fishing,
           @(HKWorkoutActivityTypeFunctionalStrengthTraining)  : FunctionalStrengthTraining,
           @(HKWorkoutActivityTypeGolf) : Golf,
           @(HKWorkoutActivityTypeGymnastics) : Gymnastics,
           @(HKWorkoutActivityTypeHandball) : Handball,
           @(HKWorkoutActivityTypeHiking) : Hiking,
           @(HKWorkoutActivityTypeHockey)  : Hockey,
           @(HKWorkoutActivityTypeHunting) : Hunting,
           @(HKWorkoutActivityTypeLacrosse) : Lacrosse,
           @(HKWorkoutActivityTypeMartialArts) : MartialArts,
           @(HKWorkoutActivityTypeMindAndBody)  : MindAndBody,
           @(HKWorkoutActivityTypePaddleSports)  : PaddleSports,
           @(HKWorkoutActivityTypePlay)  : Play,
           @(HKWorkoutActivityTypePreparationAndRecovery)  : PreparationAndRecovery,
           @(HKWorkoutActivityTypeRacquetball) : Racquetball,
           @(HKWorkoutActivityTypeRowing) : Rowing,
           @(HKWorkoutActivityTypeRugby) : Rugby,
           @(HKWorkoutActivityTypeRunning) : Running,
           @(HKWorkoutActivityTypeSailing) : Sailing,
           @(HKWorkoutActivityTypeSkatingSports)  : SkatingSports,
           @(HKWorkoutActivityTypeSnowSports)  : SnowSports,
           @(HKWorkoutActivityTypeSoccer) : Soccer,
           @(HKWorkoutActivityTypeSoftball) : Softball,
           @(HKWorkoutActivityTypeSquash) : Squash,
           @(HKWorkoutActivityTypeStairClimbing)  : StairClimbing,
           @(HKWorkoutActivityTypeSurfingSports)  : SurfingSports,
           @(HKWorkoutActivityTypeSwimming) : Swimming,
           @(HKWorkoutActivityTypeTableTennis) : TableTennis,
           @(HKWorkoutActivityTypeTennis) : Tennis,
           @(HKWorkoutActivityTypeTrackAndField)  : TrackAndField,
           @(HKWorkoutActivityTypeTraditionalStrengthTraining)  : TraditionalStrengthTraining,
           @(HKWorkoutActivityTypeVolleyball) : Volleyball,
           @(HKWorkoutActivityTypeWalking) : Walking,
           @(HKWorkoutActivityTypeWaterFitness) : WaterFitness,
           @(HKWorkoutActivityTypeWaterPolo) : WaterPolo,
           @(HKWorkoutActivityTypeWaterSports)  : WaterSports,
           @(HKWorkoutActivityTypeWrestling) : Wrestling,
           @(HKWorkoutActivityTypeYoga)   : Yoga,
           @(HKWorkoutActivityTypeBarre) : Barre,
           @(HKWorkoutActivityTypeCoreTraining) : CoreTraining,
           @(HKWorkoutActivityTypeCrossCountrySkiing) : CrossCountrySkiing,
           @(HKWorkoutActivityTypeDownhillSkiing) : DownhillSkiing,
           @(HKWorkoutActivityTypeFlexibility) : Flexibility,
           @(HKWorkoutActivityTypeHighIntensityIntervalTraining) : HighIntensityIntervalTraining,
           @(HKWorkoutActivityTypeJumpRope) : JumpRope,
           @(HKWorkoutActivityTypeKickboxing) : Kickboxing,
           @(HKWorkoutActivityTypePilates) : Pilates,
           @(HKWorkoutActivityTypeSnowboarding) : Snowboarding,
           @(HKWorkoutActivityTypeStairs) : Stairs,
           @(HKWorkoutActivityTypeStepTraining) : StepTraining,
           @(HKWorkoutActivityTypeWheelchairWalkPace) : WheelchairWalkPace,
           @(HKWorkoutActivityTypeWheelchairRunPace) : WheelchairRunPace,
           @(HKWorkoutActivityTypeTaiChi) : TaiChi,
           @(HKWorkoutActivityTypeMixedCardio) : MixedCardio,
           @(HKWorkoutActivityTypeHandCycling) : HandCycling
           };
}

- (HKObjectType *)getWritePermFromString:(NSString *)writePerm {
    return [self getWritePermFromText:writePerm];
}

- (NSString *)getAuthorizationStatusString:(HKAuthorizationStatus)status {
    switch (status) {
        case HKAuthorizationStatusNotDetermined:
            return @"NotDetermined";
        case HKAuthorizationStatusSharingDenied:
            return @"SharingDenied";
        case HKAuthorizationStatusSharingAuthorized:
            return @"SharingAuthorized";
    }
}

@end
