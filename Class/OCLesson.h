//
//  OCLesson.h
//  Class
//
//  Created by Tony Wang on 12/31/16.
//  Copyright © 2016 TonyWang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCUser.h"
@import Firebase;

@interface OCLesson : NSObject

@property (nonatomic, strong) NSString* lessonID;
@property (nonatomic, strong) NSString* studentID;
@property (nonatomic, strong) NSString* teacherID;

@property (nonatomic, strong) NSString* date;
@property (nonatomic, strong) NSString* timeAvailabilityDesc;
@property (nonatomic, strong) NSDate* startTime;
@property (nonatomic, assign) float flDurationHours;
@property (nonatomic, assign) NSInteger nLessonState;
@property (nonatomic, strong) OCUser* teacher;
@property (nonatomic, strong) OCUser* student;

- (void)setLessonInfoWith:(FIRDataSnapshot*)dataLesson;
- (void)fetchTeacherOfTheLessonWithDataReference:(FIRDatabaseReference*)ref dispatchGroup:(dispatch_group_t)group;
- (void)fetchStudentOfTheLessonWithDataReference:(FIRDatabaseReference*)ref dispatchGroup:(dispatch_group_t)group;

@end
