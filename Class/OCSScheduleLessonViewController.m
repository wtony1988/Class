//
//  OCSScheduleLessonViewController.m
//  Class
//
//  Created by Tony Wang on 12/28/16.
//  Copyright © 2016 TonyWang. All rights reserved.
//

#import "OCSScheduleLessonViewController.h"
#import "OCCalendarCell.h"
#import "OCTimeRangeCell.h"
#import "OCAvailableTimeCell.h"

@interface OCSScheduleLessonViewController ()<VPRangeSliderDelegate, UIAlertViewDelegate>
{
    UIAlertView* alError;
    UIAlertView* alSuccess;
}
@end

@implementation OCSScheduleLessonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dataKeeper = [DataKeeper sharedManager];
    
    _viLoading.layer.masksToBounds = YES;
    _viLoading.layer.cornerRadius = 6.0;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setTitle:@"Schedule A Lesson"];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    [_viLoading setHidden:YES];
    [_activityIndicator stopAnimating];
    [_viLoading setHidden:YES];
    
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

#pragma mark - Event Handlers
- (IBAction)onSendRequest:(id)sender {
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    OCTimeRangeCell *timeRangeCell = (OCTimeRangeCell*)[_tblViRequest cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    NSString* strLessonStateKey = [NSString stringWithFormat:@"%d", LESSON_REQUESTED];
    
    NSString *key = [[dataKeeper.refDB child:@"lessons"] childByAutoId].key;
    NSDictionary *lesson = @{@"lessonID": key,
                             @"studentID": dataKeeper.myUserInfo.userID,
                             @"teacherID": dataKeeper.lastSelectedTeacher.userID,
                             @"date": [dateFormatter stringFromDate:[NSDate date]],
                             @"start_time": timeRangeCell.lblStartTime.text,
                             @"duration": [timeRangeCell.lblDuration.text substringToIndex:[timeRangeCell.lblDuration.text length] - 6],
                             @"lesson_state": strLessonStateKey};
    NSDictionary *childUpdates = @{[@"/lessons/" stringByAppendingString:key]: lesson};
    
    [_viLoading setHidden:NO];
    [_activityIndicator startAnimating];
    [_lblLoading setText:[NSString stringWithFormat:@"Sending a lesson request to %@ %@", dataKeeper.lastSelectedTeacher.firstName, dataKeeper.lastSelectedTeacher.lastName]];
    
    [dataKeeper.refDB updateChildValues:childUpdates withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
        if (!error) {
            NSLog(@"Request sent!");
            
            [_viLoading setHidden:YES];
            [_activityIndicator stopAnimating];
            [_lblLoading setText:@""];
            
            alSuccess = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Request sent successfully!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alSuccess show];
            
            
        }
        else {
            NSLog(@"%@", error.description);
            [_viLoading setHidden:YES];
            [_activityIndicator stopAnimating];
            [_lblLoading setText:@""];
            
            alError = [[UIAlertView alloc] initWithTitle:@"Error" message:error.description delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alError show];
            
        }
    }];
    
}


#pragma mark - UITableViewDelegate, UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 30.0;
    }
    return 0.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 360.0;
        case 2:
            return 120.0;
        default:
            return 76.0;
    }
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* viLabel = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30.0)];
    UILabel* lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, 200, 30)];
    [lblTitle setFont:[UIFont boldSystemFontOfSize:12.0]];
    [lblTitle setTextColor:COLOR_CLASS_GRAY];
    [lblTitle setText:@"TEACHER AVAILABLILITIES"];
    [viLabel addSubview:lblTitle];
    return viLabel;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    else if(indexPath.section == 1) {
        OCAvailableTimeCell *availableTimeCell = (OCAvailableTimeCell*)[tableView dequeueReusableCellWithIdentifier:@"OCAvailableTimeCell"];
        if (availableTimeCell == nil) {
            // Load the top-level objects from the custom cell XIB.
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"OCAvailableTimeCell" owner:self options:nil];
            // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
            availableTimeCell = [topLevelObjects objectAtIndex:0];
        }
        availableTimeCell.viProgressBg.layer.masksToBounds = YES;
        availableTimeCell.viProgressBg.layer.cornerRadius = 4.0;
        availableTimeCell.viProgress.layer.masksToBounds = YES;
        availableTimeCell.viProgress.layer.cornerRadius = 4.0;
        
        availableTimeCell.lblWeekday.transform= CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(270));
        
        return availableTimeCell;
    }
    else {
        OCTimeRangeCell *timeRangeCell = (OCTimeRangeCell*)[tableView dequeueReusableCellWithIdentifier:@"OCTimeRangeCell"];
        if (timeRangeCell == nil) {
            // Load the top-level objects from the custom cell XIB.
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"OCTimeRangeCell" owner:self options:nil];
            // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
            timeRangeCell = [topLevelObjects objectAtIndex:0];
        }
        
        timeRangeCell.timeSlider.requireSegments = NO;
        timeRangeCell.timeSlider.sliderSize = CGSizeMake(20, 20);
        timeRangeCell.timeSlider.segmentSize = CGSizeMake(10, 10);
        timeRangeCell.timeSlider.rangeSliderForegroundColor = COLOR_CLASS_DARK_PURPLE;
        [timeRangeCell.timeSlider setRangeDisplayLabelColor:COLOR_CLASS_DARK_PURPLE];
        
        timeRangeCell.lblStartTime.text = @"19:00";
        timeRangeCell.lblDuration.text = @"3.0 HOURS";

        [timeRangeCell.timeSlider setDelegate:self];
        
        return timeRangeCell;
    }
}

#pragma mark - VPRangeSliderDelegate
- (void)sliderScrolling:(VPRangeSlider *)slider withMinPercent:(CGFloat)minPercent andMaxPercent:(CGFloat)maxPercent
{
    float flStartTime = 19.0 + 3.0 * minPercent/100.0;
    float flEndTime = 19.0 + 3.0 * maxPercent/100.0;
    
    slider.minRangeText = [NSString stringWithFormat:@"%.1fh", flStartTime];
    slider.maxRangeText = [NSString stringWithFormat:@"%.1fh", flEndTime];
    
    OCTimeRangeCell *timeRangeCell = (OCTimeRangeCell*)[_tblViRequest cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    
    int nHour = 19 + ((int) 3.0 * minPercent/100.0 * 60.0)/60;
    int nMin = lroundf(3.0 * minPercent/100.0 * 60.0) % 60;

    timeRangeCell.lblStartTime.text = [NSString stringWithFormat:@"%02d:%02d", nHour, nMin];
    timeRangeCell.lblDuration.text = [NSString stringWithFormat:@"%.1f HOURS", flEndTime - flStartTime];
    
}

#pragma mark - UIAlertViewDelegate Methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];

    if (alertView == alSuccess) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

@end
