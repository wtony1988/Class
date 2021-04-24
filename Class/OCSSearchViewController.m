//
//  OCSSearchViewController.m
//  Class
//
//  Created by Tony Wang on 11/26/16.
//  Copyright © 2016 TonyWang. All rights reserved.
//

#import "OCSSearchViewController.h"
#import "OCTeacherCell.h"
#import "OCTProfileViewController.h"
#import "OCFilterViewController.h"
#import "OCSScheduleLessonViewController.h"

@interface OCSSearchViewController ()
{
    OCTProfileViewController* viCtrlTProfile;
    OCFilterViewController* viCtrlFilter;
    OCSScheduleLessonViewController* viCtrlScheduleLesson;
}

@end

@implementation OCSSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataKeeper = [DataKeeper sharedManager];
    _arrTeachers = [[NSMutableArray alloc] init];
    
    // Do any additional setup after loading the view.
    _viFloat.layer.masksToBounds = YES;
    _viFloat.layer.cornerRadius = _viFloat.frame.size.height/2.0;
    
    _viLoading.layer.masksToBounds = YES;
    _viLoading.layer.cornerRadius = 6.0;
    [_viLoading setHidden:YES];
    [_activityIndicator stopAnimating];
    [_viLoading setHidden:YES];
    
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86 longitude:151.20 zoom:6];
    _mapView.camera = camera;
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
    marker.title = @"Sydney";
    marker.snippet = @"Australia";
    marker.map = _mapView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view bringSubviewToFront:_tblViSearch];
    [self.view bringSubviewToFront:_viFloat];
    [self.view bringSubviewToFront:_viLoading];

    [self.navigationController setNavigationBarHidden:YES animated:NO];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self fetchTeachers];
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
- (void)fetchTeachers
{
    [_viLoading setHidden:NO];
    [_activityIndicator startAnimating];
    [_lblLoading setText:@"Searching for teachers"];
    
    [[[[dataKeeper.refDB child:@"user_info"] queryOrderedByChild:@"user_role"] queryEqualToValue:@"0"] observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        
        [_viLoading setHidden:YES];
        [_activityIndicator stopAnimating];
        [_lblLoading setText:@""];
        
        // Loop over children
        NSEnumerator *children = [snapshot children];
        FIRDataSnapshot *child;
        
        while (child = [children nextObject]) {
            NSLog(@"%@", child.value[@"first_name"]);
            
            OCUser* teacherInfo = [[OCUser alloc] init];
            [teacherInfo setUserInfoWith:child];
            
            [_arrTeachers addObject:teacherInfo];
            
        }
        [_tblViSearch reloadData];
        
    } withCancelBlock:^(NSError * _Nonnull error) {
        
        NSLog(@"%@", error.localizedDescription);
        
        [_viLoading setHidden:YES];
        [_activityIndicator stopAnimating];
        [_lblLoading setText:@""];
        
        UIAlertView* alError = [[UIAlertView alloc] initWithTitle:@"Error" message:error.description delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alError show];
        
    }];
    
}

#pragma mark - Event Handlers
- (IBAction)onSwitchViewMode:(id)sender {
    if (dataKeeper.nSelectedTeacherSearchMode == SEARCH_MODE_LIST) {
        dataKeeper.nSelectedTeacherSearchMode = SEARCH_MODE_MAP;
        [_btnViewMode setTitle:@"LIST" forState:UIControlStateNormal];
        [_mapView setHidden:NO];
        [_tblViSearch setHidden:YES];
    }
    else {
        dataKeeper.nSelectedTeacherSearchMode = SEARCH_MODE_LIST;
        [_btnViewMode setTitle:@"MAP" forState:UIControlStateNormal];
        [_mapView setHidden:YES];
        [_tblViSearch setHidden:NO];

    }
}
- (IBAction)onFilters:(id)sender {
    if( viCtrlFilter == nil)
    {
        viCtrlFilter = (OCFilterViewController*)[[OCFilterViewController alloc] viewFromStoryboard];
    }
    [self.navigationController pushViewController:viCtrlFilter animated:YES];
}

- (void)onScheduleLesson:(id)sender {
    
    dataKeeper.lastSelectedTeacher = [_arrTeachers objectAtIndex:[sender tag]];
    
    if( viCtrlScheduleLesson == nil)
    {
        viCtrlScheduleLesson = (OCSScheduleLessonViewController*)[[OCSScheduleLessonViewController alloc] viewFromStoryboard];
    }
    [self.navigationController pushViewController:viCtrlScheduleLesson animated:YES];
}

- (void)onFavorite:(id)sender
{
    
}

- (IBAction)onTabAvailable:(id)sender {
    [UIView animateWithDuration:.3f animations:^{
        [_tabMarker setFrame:CGRectMake( 0, 61, SCREEN_WIDTH / 2.0, 3)];
    } completion:^(BOOL finished) {
        
    }];
    
}

- (IBAction)onTab1Hour:(id)sender {
    [UIView animateWithDuration:.3f animations:^{
        [_tabMarker setFrame:CGRectMake( SCREEN_WIDTH / 2.0, 61, SCREEN_WIDTH / 2.0, 3)];
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_arrTeachers count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 164.0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OCTeacherCell *teacherCell = (OCTeacherCell*)[tableView dequeueReusableCellWithIdentifier:@"OCTeacherCell"];
    if (teacherCell == nil) {
        // Load the top-level objects from the custom cell XIB.
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"OCTeacherCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        teacherCell = [topLevelObjects objectAtIndex:0];
    }
    teacherCell.viContainer.layer.masksToBounds = YES;
    teacherCell.viContainer.layer.cornerRadius = 6.0;
    teacherCell.viContainer.layer.borderColor = COLOR_CLASS_GRAY_BORDER.CGColor;
    teacherCell.viContainer.layer.borderWidth = 0.8;
    
    teacherCell.imgViAvatar.layer.masksToBounds = YES;
    teacherCell.imgViAvatar.layer.cornerRadius = 30.0;
    
    OCUser* teacherInfo = [_arrTeachers objectAtIndex: indexPath.row];
    
    teacherCell.lblName.text = [NSString stringWithFormat:@"%@ %@", teacherInfo.firstName, teacherInfo.lastName];
    teacherCell.lblPrice.text = [NSString stringWithFormat:@"￥%.1f", teacherInfo.teacherHourlyFee];
    teacherCell.lblCountry.text = [@", " stringByAppendingString:teacherInfo.country];
    
    // Convert string to date object
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *dateBirthday = [dateFormat dateFromString:teacherInfo.birthday];
    teacherCell.lblAge.text = [NSString stringWithFormat:@"%ld", (long)[dataKeeper ageFromBirthday:dateBirthday]];
    
    teacherCell.lblDistance.text = [NSString stringWithFormat:@"%.1fKM AWAY", teacherInfo.teacherLessonDistance];
    
    [teacherCell.btnSchedule setTag:indexPath.row];
    [teacherCell.btnSchedule addTarget:self action:@selector(onScheduleLesson:) forControlEvents:UIControlEventTouchUpInside];
    
    // favorite button ★☆
    [teacherCell.btnFavorite addTarget:self action:@selector(onFavorite:) forControlEvents:UIControlEventTouchUpInside];
    
    return teacherCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(viCtrlTProfile == nil)
    {
        viCtrlTProfile = (OCTProfileViewController*)[[OCTProfileViewController alloc] viewFromStoryboard];
    }
    [self.navigationController pushViewController:viCtrlTProfile animated:YES];
}

@end
