//
//  DataKeeper.m
//
//  Created by Michael on 10/1/16.

#import <UIKit/UIKit.h>
#import "DataKeeper.h"

@implementation DataKeeper

#pragma mark Singleton Methods

+ (id)sharedManager {
    static DataKeeper *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        
        if ([UIScreen mainScreen].bounds.size.height == 568) {
            _gDeviceType = DEVICE_IPHONE_40INCH;
        }
        else if ([UIScreen mainScreen].bounds.size.height == 667) {
            _gDeviceType = DEVICE_IPHONE_47INCH;
        }
        else if ([UIScreen mainScreen].bounds.size.height == 736) {
            _gDeviceType = DEVICE_IPHONE_55INCH;
        }
        else if ([UIScreen mainScreen].bounds.size.height == 480) {
            _gDeviceType = DEVICE_IPHONE_35INCH;
        }
        _isFacebookConnect = NO;
        _nSelectedRole = STUDENT_ROLE;
        _nSelectedTeacherSearchMode = SEARCH_MODE_LIST;
        
        _arrCountries = [NSArray arrayWithObjects:@"United States of America", @"United Kindom", @"Janpan", @"Germany", @"France", @"Spain", @"Italy", @"China", nil];
        _arrLanguages = [NSArray arrayWithObjects:@"English", @"Japanese", @"German", @"French", @"Spainish", @"Italian", @"Chinese", nil];
        _arrProficiencies = [NSArray arrayWithObjects:@"Novice", @"Intermediate", @"Professional", @"Advanced", nil];
        _arrExpertises = [NSArray arrayWithObjects:@"Amatuer", @"Professional", @"Expert", nil];
        _arrPrices = [NSArray arrayWithObjects:[NSNumber numberWithFloat:100.0], [NSNumber numberWithFloat:200.0], [NSNumber numberWithFloat:300.0], [NSNumber numberWithFloat:400.0], [NSNumber numberWithFloat:500.0], [NSNumber numberWithFloat:600.0], [NSNumber numberWithFloat:700.0], [NSNumber numberWithFloat:800.0], [NSNumber numberWithFloat:900.0], [NSNumber numberWithFloat:1000.0], nil];
        _arrDistances = [NSArray arrayWithObjects:@"+5km", @"+10km", @"+50km", @"+100km", nil];
        
        _refDB = [[FIRDatabase database] reference];
        _myUserInfo = [[OCUser alloc] init];
        _lastSelectedTeacher = [[OCUser alloc] init];
        _arrMyLessons = [[NSMutableArray alloc] init];
        
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        if(IS_OS_8_OR_LATER){
            NSUInteger code = [CLLocationManager authorizationStatus];
            if (code == kCLAuthorizationStatusNotDetermined && ([_locationManager respondsToSelector:@selector(requestAlwaysAuthorization)] || [_locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])) {
                // choose one request according to your business.
                if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"]){
                    [_locationManager requestAlwaysAuthorization];
                } else if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
                    [_locationManager  requestWhenInUseAuthorization];
                } else {
                    NSLog(@"Info.plist does not contain NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription");
                }
            }
        }
         
        [_locationManager startUpdatingLocation];
    
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

#pragma mark - Own Methods
- (NSInteger)ageFromBirthday:(NSDate*)birthday
{
    NSDate* now = [NSDate date];
    NSDateComponents* ageComponents = [[NSCalendar currentCalendar]
                                       components:NSCalendarUnitYear
                                       fromDate:birthday
                                       toDate:now
                                       options:0];
    NSInteger age = [ageComponents year];
    
    return age;
}


#pragma mark - CLLocationManagerDelegate Methods

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    /*UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];*/
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    
    if (newLocation != nil) {
        _myLocation = newLocation.coordinate;
    }
}

@end
