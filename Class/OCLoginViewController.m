//
//  OCLoginViewController.m
//  Class
//
//  Created by Tony Wang on 11/26/16.
//  Copyright © 2016 TonyWang. All rights reserved.
//

#import "OCLoginViewController.h"

#import "OCLessonsViewController.h"
#import "OCTStatesViewController.h"
#import "OCTProfileViewController.h"
#import "OCCalendarViewController.h"
#import "OCMessagesViewController.h"

#import "OCSSearchViewController.h"
#import "OCSFavoritesViewController.h"
#import "OCSLessonsViewController.h"
#import "OCSProfileViewController.h"

#import "OCSTabsViewController.h"
#import "OCTTabsViewController.h"

@interface OCLoginViewController ()

@end

@implementation OCLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataKeeper = [DataKeeper sharedManager];
    [dataKeeper.locationManager startUpdatingLocation];
    
    _viLoading.layer.masksToBounds = YES;
    _viLoading.layer.cornerRadius = 6.0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    // Do any additional setup after loading the view.

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [_viLoading setHidden:YES];
    [_activityIndicator stopAnimating];
    [_lblLoading setText:@""];
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

#pragma mark - API Methods
- (void)updateUserLocationWithUserId:(NSString*)strUserID location:(CLLocationCoordinate2D)myLocation{
    
    
    [[[[dataKeeper.refDB child:@"user_info"] child:strUserID] child:@"latitude"] setValue:[NSString stringWithFormat:@"%.8f", myLocation.latitude] withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
        
        if (!error) {
            NSLog(@"User latitude update sucess!");
            
            [[[[dataKeeper.refDB child:@"user_info"] child:strUserID] child:@"longitude"] setValue:[NSString stringWithFormat:@"%.8f", myLocation.longitude] withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
                
                if (!error) {
                    NSLog(@"User longitude update sucess!");
                    [self fetchUserWithUserId:strUserID];
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
        else {
            NSLog(@"%@", error.description);
            [_viLoading setHidden:YES];
            [_activityIndicator stopAnimating];
            [_lblLoading setText:@""];
            
            UIAlertView* alError = [[UIAlertView alloc] initWithTitle:@"Error" message:error.description delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alError show];
            
        }
        
    }];

    /*NSDictionary *dicUserInfo = @{@"user_id": strUserID,
                                  @"latitude": [NSString stringWithFormat:@"%.8f", myLocation.latitude],
                                  @"longitude": [NSString stringWithFormat:@"%.8f", myLocation.longitude]
                                  };
    
    NSDictionary *childUpdates = @{[@"/user_info/" stringByAppendingString:strUserID]: dicUserInfo};
    [dataKeeper.refDB updateChildValues:childUpdates withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
        if (!error) {
            NSLog(@"User location update sucess!");
            [self fetchUserWithUserId:strUserID];
        }
        else {
            NSLog(@"%@", error.description);
            [_viLoading setHidden:YES];
            [_activityIndicator stopAnimating];
            [_lblLoading setText:@""];
            
            UIAlertView* alError = [[UIAlertView alloc] initWithTitle:@"Error" message:error.description delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alError show];
            
        }
    }];*/
}

- (void)fetchUserWithUserId:(NSString*)strUserID
{
    [_lblLoading setText:@"Fetching user info"];
    
    [[[dataKeeper.refDB child:@"user_info"] child:strUserID] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        [_viLoading setHidden:YES];
        [_activityIndicator stopAnimating];
        [_lblLoading setText:@""];
        
        [dataKeeper.myUserInfo setUserInfoWith:snapshot];
        dataKeeper.nSelectedRole = dataKeeper.myUserInfo.role;
        
        if (dataKeeper.nSelectedRole == STUDENT_ROLE) {
            
            [[UINavigationBar appearance] setBackgroundImage:[[UIImage imageNamed:@"top_bar_bg.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch] forBarMetrics:UIBarMetricsDefault];
            
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            OCSTabsViewController *viCtrlTabs = [mainStoryboard instantiateViewControllerWithIdentifier:@"OCSTabsViewController"];
            [self.navigationController pushViewController:viCtrlTabs animated:YES];
        }
        else {
            
            [[UINavigationBar appearance] setBackgroundImage:[[UIImage imageNamed:@"top_bar_bg1.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeStretch] forBarMetrics:UIBarMetricsDefault];
            
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            OCTTabsViewController *viCtrlTabs = [mainStoryboard instantiateViewControllerWithIdentifier:@"OCTTabsViewController"];
            [self.navigationController pushViewController:viCtrlTabs animated:YES];
        }
        
    } withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
        
        [_viLoading setHidden:YES];
        [_activityIndicator stopAnimating];
        [_lblLoading setText:@""];
        
        UIAlertView* alError = [[UIAlertView alloc] initWithTitle:@"Error" message:error.description delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alError show];
    }];
}

- (void)perfromLogin
{
    [_tfEmail resignFirstResponder];
    [_tfPassword resignFirstResponder];
    
    [_viLoading setHidden:NO];
    [_activityIndicator startAnimating];
    [_lblLoading setText:@"Signing in"];
    
    [[FIRAuth auth] signInWithEmail:_tfEmail.text
                           password:_tfPassword.text
                         completion:^(FIRUser *user, NSError *error) {
                             
                             if (error) {
                                 [_viLoading setHidden:YES];
                                 [_activityIndicator stopAnimating];
                                 [_lblLoading setText:@""];
                                 
                                 UIAlertView* alError = [[UIAlertView alloc] initWithTitle:@"Error" message:error.description delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                 [alError show];
                             }
                             else {
                                 
                                 [_lblLoading setText:@"Updating your location"];
                                 [self updateUserLocationWithUserId:user.uid location:dataKeeper.myLocation];
                             }
                         }];

}


#pragma mark - Event Handlers

- (void)keyboardWillShow:(NSNotification*)notification
{
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    
    [UIView animateWithDuration:.3f animations:^{
        [_btnLogin setFrame:CGRectMake(0, SCREEN_HEIGHT - keyboardFrameBeginRect.size.height - _btnLogin.frame.size.height, SCREEN_WIDTH, _btnLogin.frame.size.height)];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)keyboardWillHide:(NSNotification*)notification
{
    
    [UIView animateWithDuration:.3f animations:^{
        [_btnLogin setFrame:CGRectMake(0, SCREEN_HEIGHT - _btnLogin.frame.size.height, SCREEN_WIDTH, _btnLogin.frame.size.height)];
    } completion:^(BOOL finished) {
        
    }];
}

- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onLogin:(id)sender {
    
    [self perfromLogin];
    
}

#pragma mark - UITextFieldDelegate Methods
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == _tfEmail) {
        [_tfPassword becomeFirstResponder];
    }
    else if(textField == _tfPassword) {
        [textField resignFirstResponder];
    }
    
    return YES;
}

#pragma mark - CLLocationManagerDelegate


@end
