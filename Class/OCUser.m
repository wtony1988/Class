//
//  OCUser.m
//  Class
//
//  Created by Tony Wang on 12/28/16.
//  Copyright © 2016 TonyWang. All rights reserved.
//

#import "OCUser.h"

@implementation OCUser

- (void)setUserInfoWith:(FIRDataSnapshot*)dataUserInfo
{
    self.userID = dataUserInfo.value[@"user_id"];
    self.firstName = dataUserInfo.value[@"first_name"];
    self.lastName = dataUserInfo.value[@"last_name"];
    self.email = dataUserInfo.value[@"email"];
    self.role = [dataUserInfo.value[@"user_role"] integerValue];
    self.birthday = dataUserInfo.value[@"birthday"];
    self.country = dataUserInfo.value[@"country"];
    self.motherTongue = dataUserInfo.value[@"mother_tongue"];
    self.japaneseProficiency = dataUserInfo.value[@"japanese_proficiency"];
    
    self.teacherHourlyFee = [dataUserInfo.value[@"hourly_fee"] floatValue];
    self.teacherExpertise = dataUserInfo.value[@"teacher_expertise"] ;
    
    NSString* strDistance = dataUserInfo.value[@"lesson_distance"];
    self.teacherLessonDistance = [[strDistance substringWithRange:NSMakeRange(1, [strDistance length] - 3)] floatValue];
    
    self.teacherMinLessonDuration = [dataUserInfo.value[@"min_lesson_duration"] floatValue];
    self.teacherMaxLessonDuration = [dataUserInfo.value[@"max_lesson_duration"] floatValue];
    
    self.latitude = [dataUserInfo.value[@"latitude"] floatValue];
    self.longitude = [dataUserInfo.value[@"longitude"] floatValue];

}

@end
