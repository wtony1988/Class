//
//  OCUser.h
//  Class
//
//  Created by Tony Wang on 12/28/16.
//  Copyright © 2016 TonyWang. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Firebase;

@interface OCUser : NSObject

@property (nonatomic, strong) NSString* userID;
@property (nonatomic, strong) NSString* firstName;
@property (nonatomic, strong) NSString* lastName;
@property (nonatomic, strong) NSString* email;
@property (nonatomic, assign) NSInteger role;

@property (nonatomic, strong) NSString* birthday;
@property (nonatomic, strong) NSString* country;
@property (nonatomic, strong) NSString* motherTongue;
@property (nonatomic, strong) NSString* japaneseProficiency;

@property (nonatomic, assign) float teacherHourlyFee;
@property (nonatomic, assign) float teacherLessonDistance;
@property (nonatomic, assign) float teacherMinLessonDuration;
@property (nonatomic, assign) float teacherMaxLessonDuration;
@property (nonatomic, strong) NSString* teacherExpertise;

@property (nonatomic, assign) float latitude;
@property (nonatomic, assign) float longitude;

- (void)setUserInfoWith:(FIRDataSnapshot*)dataUser;

@end
