//
//  OCLesson.m
//  Class
//
//  Created by Tony Wang on 12/31/16.
//  Copyright © 2016 TonyWang. All rights reserved.
//

#import "OCLesson.h"

@implementation OCLesson

- (void)setLessonInfoWith:(FIRDataSnapshot*)dataLesson
{
    self.lessonID = dataLesson.value[@"lessonID"];
    self.studentID = dataLesson.value[@"studentID"];
    self.teacherID = dataLesson.value[@"teacherID"];
    self.date = dataLesson.value[@"date"];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    self.timeAvailabilityDesc = [NSString stringWithFormat:@"%@ hours from %@", dataLesson.value[@"duration"], dataLesson.value[@"start_time"]];
    
    self.startTime = [dateFormatter dateFromString:[[dataLesson.value[@"date"] stringByAppendingString:@" "] stringByAppendingString:dataLesson.value[@"start_time"]]];
    self.flDurationHours = [dataLesson.value[@"duration"] floatValue];
    self.nLessonState = [dataLesson.value[@"lesson_state"] integerValue];    
}

- (void)fetchTeacherOfTheLessonWithDataReference:(FIRDatabaseReference*)ref dispatchGroup:(dispatch_group_t)group

{
    [[[ref child:@"user_info"] child:self.teacherID] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        _teacher = [[OCUser alloc] init];
        [_teacher setUserInfoWith:snapshot];
        dispatch_group_leave(group);
    }];
}

- (void)fetchStudentOfTheLessonWithDataReference:(FIRDatabaseReference*)ref dispatchGroup:(dispatch_group_t)group

{
    [[[ref child:@"user_info"] child:self.studentID] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        _student = [[OCUser alloc] init];
        [_student setUserInfoWith:snapshot];
        //dispatch_group_leave(group);
    }];
}

@end
