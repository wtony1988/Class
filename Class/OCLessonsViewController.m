//
//  OCLessonsViewController.m
//  Class
//
//  Created by Tony Wang on 11/26/16.
//  Copyright © 2016 TonyWang. All rights reserved.
//

#import "OCLessonsViewController.h"
#import "GLCalendarDateRange.h"
#import "GLDateUtils.h"
#import "GLCalendarDayCell.h"
#import "OCLessonCell.h"
#import "RequestedLessonCell.h"
#import "OCCalendarCell.h"
#import "OCLesson.h"

typedef enum {
    LESSON_TAB_UPCOMING = 0,
    LESSON_TAB_REQUESTED,
    LESSON_TAB_PAST
} LESSON_TAB;


@interface OCLessonsViewController ()
{
    LESSON_TAB nSelectedTab;
}

@end

@implementation OCLessonsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dataKeeper = [DataKeeper sharedManager];
    
    _arrUpcomingLessons = [[NSMutableArray alloc] init];
    _arrRequestedLessons = [[NSMutableArray alloc] init];
    _arrPastLessons = [[NSMutableArray alloc] init];
    
    _lblUpcomingNumber.layer.masksToBounds = YES;
    _lblUpcomingNumber.layer.cornerRadius = _lblUpcomingNumber.frame.size.width/2.0;
    _lblUpcomingNumber.text = @"0";
    
    _lblRequestedNumber.layer.masksToBounds = YES;
    _lblRequestedNumber.layer.cornerRadius = _lblRequestedNumber.frame.size.width/2.0;
    _lblRequestedNumber.text = @"0";
    
    _lblPastNumber.layer.masksToBounds = YES;
    _lblPastNumber.layer.cornerRadius = _lblPastNumber.frame.size.width/2.0;
    _lblPastNumber.text = @"0";
    
    NSDate *today = [NSDate date];
    NSDate *beginDate = [GLDateUtils dateByAddingDays:-23 toDate:today];
    NSDate *endDate = [GLDateUtils dateByAddingDays:-18 toDate:today];
    GLCalendarDateRange *range = [GLCalendarDateRange rangeWithBeginDate:beginDate endDate:endDate];
    range.backgroundColor = [UIColor darkGrayColor];
    range.editable = YES;
    
    nSelectedTab = LESSON_TAB_UPCOMING;
    _viLoading.layer.masksToBounds = YES;
    _viLoading.layer.cornerRadius = 6.0;
    [_viLoading setHidden:YES];
    [_activityIndicator stopAnimating];
    [_viLoading setHidden:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    if (dataKeeper.nSelectedRole == TEACHER_ROLE) {
        [_viTabs setBackgroundColor:COLOR_CLASS_DARK_CYAN];
        [_markSelectedTab setBackgroundColor:COLOR_CLASS_CYAN_SELECTED];
        [_lblUpcomingNumber setBackgroundColor:COLOR_CLASS_LIGHT_CYAN];
        [_lblRequestedNumber setBackgroundColor:COLOR_CLASS_LIGHT_CYAN];
        [_lblPastNumber setBackgroundColor:COLOR_CLASS_LIGHT_CYAN];
    }
    else {
        [_viTabs setBackgroundColor:COLOR_CLASS_DARK_PURPLE];
        [_markSelectedTab setBackgroundColor:COLOR_CLASS_PURPLE_SELECTED];
        [_lblUpcomingNumber setBackgroundColor:COLOR_CLASS_LIGHT_PURPLE];
        [_lblRequestedNumber setBackgroundColor:COLOR_CLASS_LIGHT_PURPLE];
        [_lblPastNumber setBackgroundColor:COLOR_CLASS_LIGHT_PURPLE];
    }
    
    [self fetchMyLessons];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Own Methods

- (void)loadSelectedTab
{
    if (nSelectedTab == LESSON_TAB_UPCOMING) {
        [_btnTabUpcoming setAlpha:1.0];
        [_btnTabRequested setAlpha:0.7];
        [_btnTabPast setAlpha:0.7];
        
        [_lblUpcomingNumber setAlpha:1.0];
        [_lblRequestedNumber setAlpha:0.7];
        [_lblPastNumber setAlpha:0.7];
        
        [UIView animateWithDuration:.3 animations:^{
            [_markSelectedTab setFrame: CGRectMake(_btnTabUpcoming.frame.origin.x, _viTabs.frame.size.height - 3, _btnTabUpcoming.frame.size.width, 3)];
        } completion:^(BOOL finished) {
            [_tblLessons reloadData];
        }];
    }
    else if (nSelectedTab == LESSON_TAB_REQUESTED) {
        [_btnTabUpcoming setAlpha:0.7];
        [_btnTabRequested setAlpha:1.0];
        [_btnTabPast setAlpha:0.7];
        
        [_lblUpcomingNumber setAlpha:0.7];
        [_lblRequestedNumber setAlpha:1.0];
        [_lblPastNumber setAlpha:0.7];
        
        [UIView animateWithDuration:.3 animations:^{
            [_markSelectedTab setFrame: CGRectMake(_btnTabRequested.frame.origin.x,  _viTabs.frame.size.height - 3, _btnTabRequested.frame.size.width, 3)];
            
        } completion:^(BOOL finished) {
            [_tblLessons reloadData];

        }];
    }
    else if (nSelectedTab == LESSON_TAB_PAST)
    {
        [_btnTabUpcoming setAlpha:0.7];
        [_btnTabRequested setAlpha:0.7];
        [_btnTabPast setAlpha:1.0];
        
        [_lblUpcomingNumber setAlpha:0.7];
        [_lblRequestedNumber setAlpha:0.7];
        [_lblPastNumber setAlpha:1.0];
        
        [UIView animateWithDuration:.3 animations:^{
            [_markSelectedTab setFrame: CGRectMake(_btnTabPast.frame.origin.x,  _viTabs.frame.size.height - 3, _btnTabPast.frame.size.width, 3)];
            
        } completion:^(BOOL finished) {
            [_tblLessons reloadData];

        }];
    }
}

- (void)fetchMyLessons
{
    [_viLoading setHidden:NO];
    [_activityIndicator startAnimating];
    [_lblLoading setText:@"Fetching my lessons"];
    
    NSString* strSearchField = @"";
    if (dataKeeper.nSelectedRole == TEACHER_ROLE) {
        strSearchField = @"teacherID";
    }
    else {
        strSearchField = @"studentID";
    }
    
    [[[[dataKeeper.refDB child:@"lessons"] queryOrderedByChild:strSearchField] queryEqualToValue:dataKeeper.myUserInfo.userID]  observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        // Loop over children
        NSEnumerator *children = [snapshot children];
        FIRDataSnapshot *child;
        [dataKeeper.arrMyLessons removeAllObjects];
        
        while (child = [children nextObject]) {
            
            OCLesson* lesson = [[OCLesson alloc] init];
            [lesson setLessonInfoWith:child];
            [dataKeeper.arrMyLessons addObject:lesson];
        }
        
        [self fetchUpcomingLessons];
        [self fetchRequestedLessons];
        [self fetchPastLessons];
        
    } withCancelBlock:^(NSError * _Nonnull error) {
        
        NSLog(@"%@", error.localizedDescription);
        
        [_viLoading setHidden:YES];
        [_activityIndicator stopAnimating];
        [_lblLoading setText:@""];
        
        UIAlertView* alError = [[UIAlertView alloc] initWithTitle:@"Error" message:error.description delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alError show];
        
    }];
}

- (void)fetchUpcomingLessons
{
    [_arrUpcomingLessons removeAllObjects];
    for (int i = 0; i < [dataKeeper.arrMyLessons count]; i ++) {
        OCLesson* lesson = [dataKeeper.arrMyLessons objectAtIndex:i];
        
        if (lesson.nLessonState == LESSON_CONFIRMED && [lesson.startTime compare:[NSDate date]] == NSOrderedDescending) {
            [_arrUpcomingLessons addObject:lesson];
        }
    }
    _lblUpcomingNumber.text = [NSString stringWithFormat:@"%lu", (unsigned long)[_arrUpcomingLessons count]];
    
    [_viLoading setHidden:YES];
    [_activityIndicator stopAnimating];
    [_lblLoading setText:@""];
    
    dispatch_group_t group = dispatch_group_create();
    for(int i = 0; i < [_arrUpcomingLessons count]; i ++)
    {
        OCLesson* lesson = [_arrUpcomingLessons objectAtIndex:i];
        dispatch_group_enter(group);
        [lesson fetchTeacherOfTheLessonWithDataReference:dataKeeper.refDB dispatchGroup:group];
    }
    
    dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        [_tblLessons reloadData];
    });

}

- (void)fetchRequestedLessons
{
    [_arrRequestedLessons removeAllObjects];
    for (int i = 0; i < [dataKeeper.arrMyLessons count]; i ++) {
        OCLesson* lesson = [dataKeeper.arrMyLessons objectAtIndex:i];
        
        if (lesson.nLessonState == LESSON_REQUESTED && [lesson.startTime compare:[NSDate date]] == NSOrderedDescending) {
            [_arrRequestedLessons addObject:lesson];
        }
    }
    _lblRequestedNumber.text = [NSString stringWithFormat:@"%lu", (unsigned long)[_arrRequestedLessons count]];
    
    [_viLoading setHidden:YES];
    [_activityIndicator stopAnimating];
    [_lblLoading setText:@""];
    
    dispatch_group_t group = dispatch_group_create();
    for(int i = 0; i < [_arrRequestedLessons count]; i ++)
    {
        OCLesson* lesson = [_arrRequestedLessons objectAtIndex:i];
        dispatch_group_enter(group);
        [lesson fetchTeacherOfTheLessonWithDataReference:dataKeeper.refDB dispatchGroup:group];
    }
    
    dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        
        // All group blocks have now completed
        [_tblLessons reloadData];

    });
}

- (void)fetchPastLessons
{
    [_arrPastLessons removeAllObjects];
    for (int i = 0; i < [dataKeeper.arrMyLessons count]; i ++) {
        OCLesson* lesson = [dataKeeper.arrMyLessons objectAtIndex:i];
        
        if ([lesson.startTime compare:[NSDate date]] != NSOrderedDescending) {
            [_arrPastLessons addObject:lesson];
        }
    }
    _lblPastNumber.text = [NSString stringWithFormat:@"%lu", (unsigned long)[_arrPastLessons count]];
    
    [_viLoading setHidden:YES];
    [_activityIndicator stopAnimating];
    [_lblLoading setText:@""];
    
    dispatch_group_t group = dispatch_group_create();
    for(int i = 0; i < [_arrPastLessons count]; i ++)
    {
        OCLesson* lesson = [_arrPastLessons objectAtIndex:i];
        dispatch_group_enter(group);
        [lesson fetchTeacherOfTheLessonWithDataReference:dataKeeper.refDB dispatchGroup:group];
    }
    
    dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        
        // All group blocks have now completed
        [_tblLessons reloadData];

    });
}


#pragma mark - Event Handlers
- (IBAction)onTabUpcoming:(id)sender {
    nSelectedTab = LESSON_TAB_UPCOMING;
    [self loadSelectedTab];
}

- (IBAction)onTabRequested:(id)sender {
    nSelectedTab = LESSON_TAB_REQUESTED;
    [self loadSelectedTab];
}

- (IBAction)onTabPast:(id)sender {
    nSelectedTab = LESSON_TAB_PAST;
    [self loadSelectedTab];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (nSelectedTab == LESSON_TAB_UPCOMING) {
        return 2;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (nSelectedTab == LESSON_TAB_UPCOMING) {
        if (section == 0) {
            return 1;
        }
        return [_arrUpcomingLessons count];
    }
    else if (nSelectedTab == LESSON_TAB_REQUESTED)
    {
        return [_arrRequestedLessons count];
    }
    
    return [_arrPastLessons count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (nSelectedTab == LESSON_TAB_UPCOMING) {
        if (indexPath.section == 0) {
            return 360.0;
        }
        return 108.0;
    }
    return 148.0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (nSelectedTab == LESSON_TAB_UPCOMING) {
        if (indexPath.section == 0) {
            OCCalendarCell *calendarCell = (OCCalendarCell*)[tableView dequeueReusableCellWithIdentifier:@"OCCalendarCell"];
            if (calendarCell == nil) {
                // Load the top-level objects from the custom cell XIB.
                NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"OCCalendarCell" owner:self options:nil];
                // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
                calendarCell = [topLevelObjects objectAtIndex:0];
            }
            
            return calendarCell;
        }
        else {
            OCLessonCell *lessonCell = (OCLessonCell*)[tableView dequeueReusableCellWithIdentifier:@"OCLessonCell"];
            if (lessonCell == nil) {
                // Load the top-level objects from the custom cell XIB.
                NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"OCLessonCell" owner:self options:nil];
                // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
                lessonCell = [topLevelObjects objectAtIndex:0];
            }
            
            lessonCell.viContainer.layer.masksToBounds = YES;
            lessonCell.viContainer.layer.cornerRadius = 6.0;
            lessonCell.viContainer.layer.borderColor = COLOR_CLASS_GRAY_BORDER.CGColor;
            lessonCell.viContainer.layer.borderWidth = 0.8;
            
            lessonCell.imgViAvatar.layer.masksToBounds = YES;
            lessonCell.imgViAvatar.layer.cornerRadius = 30.0;
            
            lessonCell.btnCancel.layer.masksToBounds = YES;
            lessonCell.btnCancel.layer.cornerRadius = 6.0;
            lessonCell.btnCancel.layer.borderColor = COLOR_CLASS_GRAY_BORDER.CGColor;
            lessonCell.btnCancel.layer.borderWidth = 0.8;
            
            OCLesson* lesson = [_arrUpcomingLessons objectAtIndex:indexPath.row];
            lessonCell.lblTime.text = [NSString stringWithFormat:@"🕒 %@", lesson.timeAvailabilityDesc];
            
            if (dataKeeper.nSelectedRole == TEACHER_ROLE) {
            }
            else {
                lessonCell.lblName.text = [NSString stringWithFormat:@"%@ %@", lesson.teacher.firstName, lesson.teacher.lastName];
                
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"yyyy-MM-dd"];
                NSDate *dateBirthday = [dateFormat dateFromString:lesson.teacher.birthday];
                lessonCell.lblAge.text = [NSString stringWithFormat:@"%ld", (long)[dataKeeper ageFromBirthday:dateBirthday]];
                
                lessonCell.lblCountry.text = [NSString stringWithFormat:@", %@", lesson.teacher.country];
                lessonCell.lblPrice.text = [NSString stringWithFormat:@"￥%.1f", lesson.teacher.teacherHourlyFee];
            }
            
            return lessonCell;
        }
    }
    else
    {
        RequestedLessonCell *reqLessonCell = (RequestedLessonCell*)[tableView dequeueReusableCellWithIdentifier:@"RequestedLessonCell"];
        if (reqLessonCell == nil) {
            // Load the top-level objects from the custom cell XIB.
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"RequestedLessonCell" owner:self options:nil];
            // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
            reqLessonCell = [topLevelObjects objectAtIndex:0];
        }
        
        reqLessonCell.viContainer.layer.masksToBounds = YES;
        reqLessonCell.viContainer.layer.cornerRadius = 6.0;
        reqLessonCell.viContainer.layer.borderColor = COLOR_CLASS_GRAY_BORDER.CGColor;
        reqLessonCell.viContainer.layer.borderWidth = 0.8;
        
        reqLessonCell.imgViAvatar.layer.masksToBounds = YES;
        reqLessonCell.imgViAvatar.layer.cornerRadius = 30.0;
        
        OCLesson* lesson;
        if (nSelectedTab == LESSON_TAB_REQUESTED) {
            lesson = [_arrRequestedLessons objectAtIndex:indexPath.row];
        }
        else if (nSelectedTab == LESSON_TAB_PAST) {
            lesson = [_arrPastLessons objectAtIndex:indexPath.row];
        }
        
        reqLessonCell.lblDate.text = [NSString stringWithFormat:@"🗓 %@", lesson.date];
        reqLessonCell.lblAvailableHours.text = [NSString stringWithFormat:@"🕒 %@", lesson.timeAvailabilityDesc];
        
        if (dataKeeper.nSelectedRole == TEACHER_ROLE) {
            
        }
        else {
            reqLessonCell.lblName.text = [NSString stringWithFormat:@"%@ %@", lesson.teacher.firstName, lesson.teacher.lastName];
            
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd"];
            NSDate *dateBirthday = [dateFormat dateFromString:lesson.teacher.birthday];
            reqLessonCell.lblAge.text = [NSString stringWithFormat:@"%ld", (long)[dataKeeper ageFromBirthday:dateBirthday]];
            
            reqLessonCell.lblCountry.text = [NSString stringWithFormat:@", %@", lesson.teacher.country];
            reqLessonCell.lblPrice.text = [NSString stringWithFormat:@"￥%.1f", lesson.teacher.teacherHourlyFee];
            
            if (nSelectedTab == LESSON_TAB_REQUESTED) {
                [reqLessonCell.btnAction setTitle:@"CANCEL" forState:UIControlStateNormal];
                [reqLessonCell.btnAction setBackgroundColor:COLOR_CLASS_LIGHT_GRAY];
            }
            else if (nSelectedTab == LESSON_TAB_PAST) {
                [reqLessonCell.btnAction setTitle:@"REVIEW" forState:UIControlStateNormal];
                [reqLessonCell.btnAction setBackgroundColor:COLOR_CLASS_DARK_ORANGE];
            }
        }
        
        return reqLessonCell;
        
    }
    
}



@end
