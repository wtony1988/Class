//
//  OCSignUpViewController.m
//  Class
//
//  Created by Tony Wang on 11/23/16.
//  Copyright © 2016 TonyWang. All rights reserved.
//

#import "OCSignUpViewController.h"
#import "OCSTabsViewController.h"
#import "OCTTabsViewController.h"
#import "OCPickerCell.h"
#import "OCInputCell.h"
#import "OCRangeCell.h"
#import "OCMapLocationCell.h"
#import "VPRangeSlider.h"
#import "ActionSheetPicker.h"

@interface OCSignUpViewController ()<VPRangeSliderDelegate, UITextFieldDelegate>
{
    NSMutableArray* arrEmailSignUpFields;
    NSMutableArray* arrStudentOptionFields;
    NSMutableArray* arrTeacherOptionFields;
    UIView* viButtonsFooter;
    UIButton* btnCancel;
    UIButton* btnSave;
    
    NSString* strFirstName;
    NSString* strLastName;
    NSString* strEmail;
    NSString* strPassword;
    
    NSInteger nSelectedCountryIdx;
    NSInteger nSelectedLanguageIdx;
    NSInteger nSelectedProficiencyIdx;
    NSInteger nSelectedExpertiseIdx;
    NSInteger nSelectedPriceIdx;
    NSInteger nSelectedDistanceIdx;
    
    NSDate* selectedBirthday;
    NSDateFormatter *dateFormatter;
    
    CGFloat flMinLessonDuration;
    CGFloat flMaxLessonDuration;
}

@end

@implementation OCSignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dataKeeper = [DataKeeper sharedManager];
    [dataKeeper.locationManager startUpdatingLocation];

    
    viButtonsFooter = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    
    _viLoading.layer.masksToBounds = YES;
    _viLoading.layer.cornerRadius = 6.0;
    
    btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2.0, 50)];
    [btnCancel setBackgroundColor:COLOR_CLASS_GRAY];
    [btnCancel setTitle:@"CANCEL" forState:UIControlStateNormal];
    [btnCancel.titleLabel setFont:[UIFont boldSystemFontOfSize:12.0]];
    [btnCancel addTarget:self action:@selector(onCancel:) forControlEvents:UIControlEventTouchUpInside];
    
    btnSave = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2.0, 0, SCREEN_WIDTH/2.0, 50)];
    [btnSave setTitle:@"SAVE" forState:UIControlStateNormal];
    [btnSave.titleLabel setFont:[UIFont boldSystemFontOfSize:12.0]];
    [btnSave addTarget:self action:@selector(onSave:) forControlEvents:UIControlEventTouchUpInside];
    
    [viButtonsFooter addSubview:btnCancel];
    [viButtonsFooter addSubview:btnSave];

    arrEmailSignUpFields = [[NSMutableArray alloc] initWithObjects:
                            [[NSDictionary alloc] initWithObjectsAndKeys:@"FIRST NAME", @"title", @"Enter your first name", @"place_holder", [NSNumber numberWithInt:INPUT_TYPE_STRING],@"input_type", nil],
                            [[NSDictionary alloc] initWithObjectsAndKeys:@"LAST NAME", @"title", @"Enter your last name", @"place_holder", [NSNumber numberWithInt:INPUT_TYPE_STRING],@"input_type", nil],
                            [[NSDictionary alloc] initWithObjectsAndKeys:@"EMAIL ADDRESS", @"title", @"Enter email address", @"place_holder", [NSNumber numberWithInt:INPUT_TYPE_EMAIL],@"input_type", nil],
                            [[NSDictionary alloc] initWithObjectsAndKeys:@"PASSWORD", @"title", @"Enter password", @"place_holder", [NSNumber numberWithInt:INPUT_TYPE_PASSWORD],@"input_type", nil],
                            [[NSDictionary alloc] initWithObjectsAndKeys:@"BIRTHDAY", @"title", @"Choose birthday", @"place_holder",
                                [NSNumber numberWithInt:INPUT_TYPE_DATE], @"input_type", nil],
                            nil];
    arrStudentOptionFields = [[NSMutableArray alloc] initWithObjects:
                              [[NSDictionary alloc] initWithObjectsAndKeys:@"COUNTRY OF ORIGIN", @"title", [NSNumber numberWithInt:INPUT_TYPE_COUNTRY],@"input_type", nil],
                              [[NSDictionary alloc] initWithObjectsAndKeys:@"MOTHER TONGUE", @"title", [NSNumber numberWithInt:INPUT_TYPE_LANGUAGE],@"input_type", nil],
                              [[NSDictionary alloc] initWithObjectsAndKeys:@"JAPANESE PROFICIENCY", @"title", [NSNumber numberWithInt:INPUT_TYPE_PROFICIENCY],@"input_type", nil],
                              nil];
    arrTeacherOptionFields = [[NSMutableArray alloc] initWithObjects:
                              [[NSDictionary alloc] initWithObjectsAndKeys:@"COUNTRY OF ORIGIN", @"title", [NSNumber numberWithInt:INPUT_TYPE_COUNTRY],@"input_type", nil],
                              [[NSDictionary alloc] initWithObjectsAndKeys:@"MOTHER TONGUE", @"title", [NSNumber numberWithInt:INPUT_TYPE_LANGUAGE],@"input_type", nil],
                              [[NSDictionary alloc] initWithObjectsAndKeys:@"JAPANESE PROFICIENCY", @"title", [NSNumber numberWithInt:INPUT_TYPE_PROFICIENCY],@"input_type", nil],
                              [[NSDictionary alloc] initWithObjectsAndKeys:@"HOURLY FEE", @"title", [NSNumber numberWithInt:INPUT_TYPE_PRICE],@"input_type", nil],
                              [[NSDictionary alloc] initWithObjectsAndKeys:@"EXPERTISE", @"title",
                                  [NSNumber numberWithInt:INPUT_TYPE_TEACHER_EXPERTISE],@"input_type", nil],
                              [[NSDictionary alloc] initWithObjectsAndKeys:@"PREFERRED LESSON DURATION(HOURS)", @"title", [NSNumber numberWithInt:INPUT_TYPE_DURATION],@"input_type", nil],
                              [[NSDictionary alloc] initWithObjectsAndKeys:@"PREFERRED LESSON AREA", @"title", [NSNumber numberWithInt:INPUT_TYPE_MAP_LOCATION],@"input_type", nil],
                              nil];
    strFirstName = @"";
    strLastName = @"";
    strEmail = @"";
    strPassword = @"";
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    nSelectedPriceIdx = 0;
    nSelectedCountryIdx = 0;
    nSelectedLanguageIdx = 0;
    nSelectedProficiencyIdx = 0;
    nSelectedExpertiseIdx = 0;
    nSelectedDistanceIdx = 0;
    
    flMinLessonDuration = MIN_HOURS;
    flMaxLessonDuration = MAX_HOURS;
    
    selectedBirthday = [NSDate date];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    [_viLoading setHidden:YES];
    [_activityIndicator stopAnimating];
    _lblLoading.text = @"";
    
    if (dataKeeper.nSelectedRole == STUDENT_ROLE) {
        [[UINavigationBar appearance] setBackgroundImage:[[UIImage imageNamed:@"top_bar_bg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch] forBarMetrics:UIBarMetricsDefault];
        
        //self.navigationController.navigationBar.tintColor = COLOR_CLASS_RED;
        [btnSave setBackgroundColor:COLOR_CLASS_DARK_PURPLE];
        [_viLoading setBackgroundColor:COLOR_CLASS_DARK_PURPLE];
    }
    else {
        
        [[UINavigationBar appearance] setBackgroundImage:[[UIImage imageNamed:@"top_bar_bg1.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch] forBarMetrics:UIBarMetricsDefault];
        
        //self.navigationController.navigationBar.tintColor = COLOR_CLASS_CYAN;
        [btnSave setBackgroundColor:COLOR_CLASS_DARK_CYAN];
        [_viLoading setBackgroundColor:COLOR_CLASS_DARK_CYAN];
    }
    
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    [self.navigationItem setTitle:@"Build Your Profile"];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [_tblViInput reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - API Methods
- (void)extendUserWithUserId:(NSString*)strUserID UserEmail:(NSString *)strUserEmail userRole:(NSInteger)nRole firstName:(NSString*)strUserFirstName lastName:(NSString*)strUserLastName birthday:(NSString*)strBirthday country:(NSString*)strCountry motherTongue:(NSString*)strMotherTongue japaneseProficiency:(NSString*)strJapaneseProficiency hourlyFee:(NSString*)strHourlyFee expertise:(NSString*)strTeacherExpertise minDuration:(NSString*)strMinDuration maxDuration:(NSString*)strMaxDuration lessonDistance:(NSString*)strLessonDistance location:(CLLocationCoordinate2D)myLocation{
    
    
    NSDictionary *dicUserInfo;
    if (nRole == TEACHER_ROLE) {
        dicUserInfo = @{@"user_id": strUserID,
                        @"email": strUserEmail,
                        @"user_role": [NSString stringWithFormat:@"%ld", (long)nRole],
                        @"first_name": strUserFirstName,
                        @"last_name": strUserLastName,
                        @"birthday": strBirthday,
                        @"country": strCountry,
                        @"mother_tongue": strMotherTongue,
                        @"japanese_proficiency": strJapaneseProficiency,
                        @"hourly_fee": strHourlyFee,
                        @"teacher_expertise": strTeacherExpertise,
                        @"min_lesson_duration": strMinDuration,
                        @"max_lesson_duration": strMaxDuration,
                        @"lesson_distance": strLessonDistance,
                        @"latitude": [NSString stringWithFormat:@"%.8f", myLocation.latitude],
                        @"longitude": [NSString stringWithFormat:@"%.8f", myLocation.longitude]
                        };
    }
    else {
        dicUserInfo = @{@"user_id": strUserID,
                        @"email": strUserEmail,
                        @"user_role": [NSString stringWithFormat:@"%ld", (long)nRole],
                        @"first_name": strUserFirstName,
                        @"last_name": strUserLastName,
                        @"birthday": strBirthday,
                        @"country": strCountry,
                        @"mother_tongue": strMotherTongue,
                        @"japanese_proficiency": strJapaneseProficiency,
                        @"latitude": [NSString stringWithFormat:@"%.8f", myLocation.latitude],
                        @"longitude": [NSString stringWithFormat:@"%.8f", myLocation.longitude]
                        };
    }
    
    NSDictionary *childUpdates = @{[@"/user_info/" stringByAppendingString:strUserID]: dicUserInfo};
    [dataKeeper.refDB updateChildValues:childUpdates withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
        if (!error) {
            NSLog(@"User signup sucess!");
            
            [_viLoading setHidden:YES];
            [_activityIndicator stopAnimating];
            [_lblLoading setText:@""];
            
            if (dataKeeper.nSelectedRole == STUDENT_ROLE) {
                UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                OCSTabsViewController *viCtrlTabs = [mainStoryboard instantiateViewControllerWithIdentifier:@"OCSTabsViewController"];
                [self.navigationController pushViewController:viCtrlTabs animated:YES];
                
            }
            else {
                UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                OCTTabsViewController *viCtrlTabs = [mainStoryboard instantiateViewControllerWithIdentifier:@"OCTTabsViewController"];
                [self.navigationController pushViewController:viCtrlTabs animated:YES];
                
            }
            
        }
        else {
            NSLog(@"%@", error.description);
            [_viLoading setHidden:YES];
            [_activityIndicator stopAnimating];
            [_lblLoading setText:@""];
            
            UIAlertView* alError = [[UIAlertView alloc] initWithTitle:@"Error" message:error.description delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alError show];
            
        }
    }];
}


#pragma mark - Event Handlers
- (void)onSave:(id)sender
{
    if (dataKeeper.isFacebookConnect) {
        
    }
    else {
        [_viLoading setHidden:NO];
        [_activityIndicator startAnimating];
        [_lblLoading setText:@"Creating your account"];

        [[FIRAuth auth]
         createUserWithEmail:strEmail
         password:strPassword
         completion:^(FIRUser *_Nullable user,
                      NSError *_Nullable error) {
             
             if (error) {
                 [_viLoading setHidden:YES];
                 [_activityIndicator stopAnimating];
                 [_lblLoading setText:@""];
                 
                 UIAlertView* alError = [[UIAlertView alloc] initWithTitle:@"Error" message:error.description delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 [alError show];
             }
             else {
                 
                 if (dataKeeper.nSelectedRole == TEACHER_ROLE) {
                     [_lblLoading setText:@"Saving your teacher profile"];

                     [self extendUserWithUserId:user.uid UserEmail:user.email userRole:dataKeeper.nSelectedRole firstName:strFirstName lastName:strLastName birthday:[dateFormatter stringFromDate:selectedBirthday] country:[dataKeeper.arrCountries objectAtIndex:nSelectedCountryIdx] motherTongue:[dataKeeper.arrLanguages objectAtIndex:nSelectedLanguageIdx] japaneseProficiency:[dataKeeper.arrProficiencies objectAtIndex:nSelectedProficiencyIdx] hourlyFee:[NSString stringWithFormat:@"%.1f",[[dataKeeper.arrPrices objectAtIndex:nSelectedPriceIdx] floatValue]] expertise:[dataKeeper.arrExpertises objectAtIndex:nSelectedExpertiseIdx] minDuration:[NSString stringWithFormat:@"%.1fh", flMinLessonDuration] maxDuration:[NSString stringWithFormat:@"%.1fh", flMaxLessonDuration] lessonDistance:[dataKeeper.arrDistances objectAtIndex:nSelectedDistanceIdx] location:dataKeeper.myLocation];
                 }
                 else {
                     [_lblLoading setText:@"Saving your student profile"];

                     [self extendUserWithUserId:user.uid UserEmail:user.email userRole:dataKeeper.nSelectedRole firstName:strFirstName lastName:strLastName birthday:[dateFormatter stringFromDate:selectedBirthday] country:[dataKeeper.arrCountries objectAtIndex:nSelectedCountryIdx] motherTongue:[dataKeeper.arrLanguages objectAtIndex:nSelectedLanguageIdx] japaneseProficiency:[dataKeeper.arrProficiencies objectAtIndex:nSelectedProficiencyIdx] hourlyFee:nil expertise:nil minDuration:nil maxDuration:nil lessonDistance:nil location:dataKeeper.myLocation];
                 }

                 
             }
         }];
        
    }
    
}

- (void)onCancel:(id)sender
{
    
}

- (void)onPicker:(id)sender
{
    NSInteger nInputType = [sender tag];
    
    // Create an array of strings you want to show in the picker:
    NSArray *arrDataSource;
    
    NSString* strPickerTitle = @"";
    if (nInputType == INPUT_TYPE_COUNTRY) {
        strPickerTitle = @"Select your country";
        arrDataSource = dataKeeper.arrCountries;
    }
    else if (nInputType == INPUT_TYPE_LANGUAGE)
    {
        strPickerTitle = @"Select your language";
        arrDataSource = dataKeeper.arrLanguages;
    }
    else if (nInputType == INPUT_TYPE_PROFICIENCY)
    {
        strPickerTitle = @"Select your proficiency";
        arrDataSource = dataKeeper.arrProficiencies;
    }
    else if (nInputType == INPUT_TYPE_TEACHER_EXPERTISE)
    {
        strPickerTitle = @"Select your expertise";
        arrDataSource = dataKeeper.arrExpertises;
    }
    else if (nInputType == INPUT_TYPE_PRICE)
    {
        strPickerTitle = @"Select your fee";
        arrDataSource = dataKeeper.arrPrices;
    }
    else if (nInputType == INPUT_TYPE_DATE)
    {
        strPickerTitle = @"Choose your birthday";
    }
    else if (nInputType == INPUT_TYPE_MAP_LOCATION)
    {
        strPickerTitle = @"Select distance";
        arrDataSource = dataKeeper.arrDistances;
    }
    
    if (nInputType == INPUT_TYPE_DATE) {
        [ActionSheetDatePicker showPickerWithTitle:strPickerTitle datePickerMode:UIDatePickerModeDate selectedDate:selectedBirthday doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
            selectedBirthday = selectedDate;
            [_tblViInput reloadData];
        } cancelBlock:^(ActionSheetDatePicker *picker) {
            NSLog(@"Block Picker Canceled");
        } origin:sender];
        
    }
    else {
        [ActionSheetStringPicker showPickerWithTitle:strPickerTitle
                                                rows:arrDataSource
                                    initialSelection:0
                                           doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                               
                                               if (nInputType == INPUT_TYPE_COUNTRY) {
                                                   nSelectedCountryIdx = selectedIndex;
                                               }
                                               else if (nInputType == INPUT_TYPE_LANGUAGE)
                                               {
                                                   nSelectedLanguageIdx = selectedIndex;
                                                   
                                               }
                                               else if (nInputType == INPUT_TYPE_PROFICIENCY)
                                               {
                                                   nSelectedProficiencyIdx = selectedIndex;
                                                   
                                               }
                                               else if (nInputType == INPUT_TYPE_TEACHER_EXPERTISE)
                                               {
                                                   nSelectedExpertiseIdx = selectedIndex;
                                                   
                                               }
                                               else if (nInputType == INPUT_TYPE_PRICE)
                                               {
                                                   nSelectedPriceIdx = selectedIndex;
                                                   
                                               }
                                               else if (nInputType == INPUT_TYPE_MAP_LOCATION)
                                               {
                                                   nSelectedDistanceIdx = selectedIndex;
                                                   
                                               }
                                               [_tblViInput reloadData];
                                           }
                                         cancelBlock:^(ActionSheetStringPicker *picker) {
                                             NSLog(@"Block Picker Canceled");
                                         }
                                              origin:sender];
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableViewDataSource, UITableViewDelegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (dataKeeper.isFacebookConnect) {
        return 1;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (dataKeeper.isFacebookConnect) {
        if (dataKeeper.nSelectedRole == STUDENT_ROLE) {
            return [arrStudentOptionFields count];
        }
        else {
            return [arrTeacherOptionFields count];
        }
    }
    else {
        if (section == 0) {
            return [arrEmailSignUpFields count];
        }
        else {
            if (dataKeeper.nSelectedRole == STUDENT_ROLE) {
                return [arrStudentOptionFields count];
            }
            else {
                return [arrTeacherOptionFields count];
            }
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* dicField;
    if (dataKeeper.isFacebookConnect) {
        if (dataKeeper.nSelectedRole == STUDENT_ROLE) {
            dicField = [arrStudentOptionFields objectAtIndex:indexPath.row];
        }
        else {
            dicField = [arrTeacherOptionFields objectAtIndex:indexPath.row];
        }
    }
    else {
        if (indexPath.section == 0) {
            dicField = [arrEmailSignUpFields objectAtIndex:indexPath.row];
        }
        else {
            if (dataKeeper.nSelectedRole == STUDENT_ROLE) {
                dicField = [arrStudentOptionFields objectAtIndex:indexPath.row];
            }
            else {
                dicField = [arrTeacherOptionFields objectAtIndex:indexPath.row];
            }
        }
    }
    
    NSInteger nInputType = [[dicField objectForKey:@"input_type"] integerValue];
    
    if (nInputType == INPUT_TYPE_DURATION) {
        return RANGE_CELL_HEIGHT;
    }
    else if (nInputType == INPUT_TYPE_MAP_LOCATION) {
        return MAP_LOCATION_CELL_HEIGHT;
    }
    else {
        return 80.0;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (dataKeeper.isFacebookConnect && section == 0) {
        return 50.0;
    }
    else if (!dataKeeper.isFacebookConnect && section == 1){
        return 50.0;
    }
    return 0.0;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return viButtonsFooter;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* dicField;
    if (dataKeeper.isFacebookConnect) {
        if (dataKeeper.nSelectedRole == STUDENT_ROLE) {
            dicField = [arrStudentOptionFields objectAtIndex:indexPath.row];
        }
        else {
            dicField = [arrTeacherOptionFields objectAtIndex:indexPath.row];
        }
    }
    else {
        if (indexPath.section == 0) {
            dicField = [arrEmailSignUpFields objectAtIndex:indexPath.row];
        }
        else {
            if (dataKeeper.nSelectedRole == STUDENT_ROLE) {
                dicField = [arrStudentOptionFields objectAtIndex:indexPath.row];
            }
            else {
                dicField = [arrTeacherOptionFields objectAtIndex:indexPath.row];
            }
        }
    }
    
    NSInteger nInputType = [[dicField objectForKey:@"input_type"] integerValue];
    
    if (nInputType == INPUT_TYPE_COUNTRY || nInputType == INPUT_TYPE_LANGUAGE || nInputType == INPUT_TYPE_PROFICIENCY || nInputType == INPUT_TYPE_PRICE || nInputType == INPUT_TYPE_TEACHER_EXPERTISE || nInputType == INPUT_TYPE_DATE) {
        
        OCPickerCell *pickerCell = (OCPickerCell*)[tableView dequeueReusableCellWithIdentifier:@"OCPickerCell"];
        if (pickerCell == nil) {
            // Load the top-level objects from the custom cell XIB.
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"OCPickerCell" owner:self options:nil];
            // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
            pickerCell = [topLevelObjects objectAtIndex:0];
        }
        pickerCell.lblTitle.text = [dicField objectForKey:@"title"];
        
        if (nInputType == INPUT_TYPE_PRICE || nInputType == INPUT_TYPE_TEACHER_EXPERTISE) {
            [pickerCell.btnInfo setHidden:NO];
        }
        else {
            [pickerCell.btnInfo setHidden:YES];
        }
        
        switch (nInputType) {
            case INPUT_TYPE_COUNTRY:
                pickerCell.lblPickValue.text = [dataKeeper.arrCountries objectAtIndex:nSelectedCountryIdx];
                break;
            case INPUT_TYPE_LANGUAGE:
                pickerCell.lblPickValue.text = [dataKeeper.arrLanguages objectAtIndex:nSelectedLanguageIdx];
                break;
            case INPUT_TYPE_PROFICIENCY:
                pickerCell.lblPickValue.text = [dataKeeper.arrProficiencies objectAtIndex:nSelectedProficiencyIdx];
                break;
            case INPUT_TYPE_TEACHER_EXPERTISE:
                pickerCell.lblPickValue.text = [dataKeeper.arrExpertises objectAtIndex:nSelectedExpertiseIdx];
                break;
            case INPUT_TYPE_PRICE:
                pickerCell.lblPickValue.text = [NSString stringWithFormat:@"%.1f",[[dataKeeper.arrPrices objectAtIndex:nSelectedPriceIdx] floatValue]];
                break;
            case INPUT_TYPE_DATE:
                pickerCell.lblPickValue.text = [dateFormatter stringFromDate:selectedBirthday];
                break;
            default:
                break;
        }
        
        if (indexPath.section == 0 && indexPath.row == [tableView numberOfRowsInSection:0] - 1) {
            [pickerCell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        }
        
        [pickerCell.btnPicker setTag:nInputType];
        [pickerCell.btnPicker addTarget:self action:@selector(onPicker:) forControlEvents:UIControlEventTouchUpInside];
        
        return pickerCell;
    }
    else if (nInputType == INPUT_TYPE_DURATION)
    {
        OCRangeCell *rangeCell = (OCRangeCell*)[tableView dequeueReusableCellWithIdentifier:@"OCRangeCell"];
        if (rangeCell == nil) {
            // Load the top-level objects from the custom cell XIB.
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"OCRangeCell" owner:self options:nil];
            // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
            rangeCell = [topLevelObjects objectAtIndex:0];
        }
        rangeCell.lblTitle.text = [dicField objectForKey:@"title"];
        
        rangeCell.rangeSlider.requireSegments = NO;
        rangeCell.rangeSlider.sliderSize = CGSizeMake(20, 20);
        rangeCell.rangeSlider.segmentSize = CGSizeMake(10, 10);
        
        if (dataKeeper.nSelectedRole == TEACHER_ROLE) {
            rangeCell.rangeSlider.rangeSliderForegroundColor = COLOR_CLASS_DARK_CYAN;
        }
        else {
            rangeCell.rangeSlider.rangeSliderForegroundColor = COLOR_CLASS_PURPLE;
        }
        
        //rangeCell.rangeSlider.rangeSliderButtonImage = [UIImage imageNamed:@"handle.png"];
        [rangeCell.rangeSlider setDelegate:self];

        return rangeCell;
    }
    else if (nInputType == INPUT_TYPE_MAP_LOCATION)
    {
        OCMapLocationCell *mapLocationCell = (OCMapLocationCell*)[tableView dequeueReusableCellWithIdentifier:@"OCMapLocationCell"];
        if (mapLocationCell == nil) {
            // Load the top-level objects from the custom cell XIB.
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"OCMapLocationCell" owner:self options:nil];
            // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
            mapLocationCell = [topLevelObjects objectAtIndex:0];
        }
        
        [mapLocationCell.btnPicker setTag:nInputType];

        mapLocationCell.lblTitle.text = [dicField objectForKey:@"title"];
        mapLocationCell.lblPickDistance.text = [NSString stringWithFormat:@"Near your current location (%@)", [dataKeeper.arrDistances objectAtIndex:nSelectedDistanceIdx]];
        
        [mapLocationCell.btnPicker addTarget:self action:@selector(onPicker:) forControlEvents:UIControlEventTouchUpInside];
        
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86 longitude:151.20 zoom:6];
        mapLocationCell.mapView.camera = camera;
        
        // Creates a marker in the center of the map.
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
        marker.title = @"Sydney";
        marker.snippet = @"Australia";
        marker.map = mapLocationCell.mapView;
        return mapLocationCell;
    }
    else {
        OCInputCell *inputCell = (OCInputCell*)[tableView dequeueReusableCellWithIdentifier:@"OCInputCell"];
        if (inputCell == nil) {
            // Load the top-level objects from the custom cell XIB.
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"OCInputCell" owner:self options:nil];
            // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
            inputCell = [topLevelObjects objectAtIndex:0];
        }
        
        [inputCell.tfInput setTag:indexPath.row];
        [inputCell.tfInput setDelegate:self];
        
        inputCell.lblTitle.text = [dicField objectForKey:@"title"];
        [inputCell.tfInput setPlaceholder:[dicField objectForKey:@"place_holder"]];
        
        if (nInputType == INPUT_TYPE_EMAIL) {
            [inputCell.tfInput setKeyboardType:UIKeyboardTypeEmailAddress];
        }
        else {
            [inputCell.tfInput setKeyboardType:UIKeyboardTypeDefault];
        }
        
        if (nInputType == INPUT_TYPE_PASSWORD) {
            [inputCell.tfInput setSecureTextEntry:YES];
        }
        else {
            [inputCell.tfInput setSecureTextEntry:NO];
        }
        
        if (indexPath.section == 0 && indexPath.row == [tableView numberOfRowsInSection:0] - 1) {
            [inputCell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        }
        
        switch (indexPath.row) {
            case 0:
                inputCell.tfInput.text = strFirstName;
            case 1:
                inputCell.tfInput.text = strLastName;
            case 2:
                inputCell.tfInput.text = strEmail;
            case 3:
                inputCell.tfInput.text = strPassword;
                break;
                
            default:
                break;
        }
        
        return inputCell;
    }

}

#pragma mark - VPRangeSliderDelegate
- (void)sliderScrolling:(VPRangeSlider *)slider withMinPercent:(CGFloat)minPercent andMaxPercent:(CGFloat)maxPercent
{
    flMinLessonDuration = MAX_HOURS * minPercent/100.0;
    flMaxLessonDuration = MAX_HOURS * maxPercent/100.0;
        
    slider.minRangeText = [NSString stringWithFormat:@"%.1fh", flMinLessonDuration];
    slider.maxRangeText = [NSString stringWithFormat:@"%.1fh", flMaxLessonDuration];
    
}

#pragma mark - UITextFieldDelegate Methods
- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason
{
    switch (textField.tag) {
        case 0:
            strFirstName = textField.text;
            break;
        case 1:
            strLastName = textField.text;
            break;
        case 2:
            strEmail = textField.text;
            break;
        case 3:
            strPassword = textField.text;
            break;
            
        default:
            break;
    }
}

#pragma mark - CLLocationManagerDelegate Methods


@end
