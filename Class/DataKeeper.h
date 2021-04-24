//
//  DataKeeper.h
//
//  Created by Michael on 10/1/16.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "OCUser.h"

#import "Global.h"
@import Firebase;

@interface DataKeeper : NSObject <CLLocationManagerDelegate> {
}

@property (nonatomic, assign) BOOL isFacebookConnect;
@property (nonatomic, assign) NSInteger nSelectedRole;
@property (nonatomic, assign) NSInteger nSelectedTeacherSearchMode;

@property (nonatomic, assign) IOS_VERSION gIOSVersion;
@property (nonatomic, assign) DEVICE_TYPE gDeviceType;

@property (nonatomic, strong) NSArray* arrCountries;
@property (nonatomic, strong) NSArray* arrLanguages;
@property (nonatomic, strong) NSArray* arrProficiencies;
@property (nonatomic, strong) NSArray* arrExpertises;
@property (nonatomic, strong) NSArray* arrPrices;
@property (nonatomic, strong) NSArray* arrDistances;

@property (nonatomic, strong) FIRDatabaseReference* refDB;
@property (nonatomic, strong) OCUser* myUserInfo;
@property (nonatomic, strong) OCUser* lastSelectedTeacher;
@property (nonatomic, strong) NSMutableArray* arrMyLessons;

@property (nonatomic, strong) CLLocationManager* locationManager;
@property (nonatomic, assign) CLLocationCoordinate2D myLocation;

+ (id)sharedManager;
- (NSInteger)ageFromBirthday:(NSDate*)birthday;
@end
