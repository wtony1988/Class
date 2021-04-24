//
//  ViewController.m
//  Class
//
//  Created by Tony Wang on 11/22/16.
//  Copyright © 2016 TonyWang. All rights reserved.
//

#import "ViewController.h"
#import "OCRoleViewController.h"
#import "OCLoginViewController.h"

@interface ViewController ()
{
    OCRoleViewController* viCtrlRole;
    OCLoginViewController* viCtrlLogin;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    dataKeeper = [DataKeeper sharedManager];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    _btnSignUp.layer.masksToBounds = YES;
    _btnSignUp.layer.cornerRadius = _btnSignUp.frame.size.height / 2.0;
    
    _btnFacebookSignUp.layer.masksToBounds = YES;
    _btnFacebookSignUp.layer.cornerRadius = _btnFacebookSignUp.frame.size.height / 2.0;
    
    UIImageView* facebookMark = [[UIImageView alloc] initWithFrame:CGRectMake( 30, (_btnFacebookSignUp.frame.size.height - 16.0) / 2.0, 10, 16)];
    [facebookMark setImage:[UIImage imageNamed:@"facebook_icon.png"]];
    [_btnFacebookSignUp addSubview:facebookMark];
    
    /*UILabel* lblFacebookMark = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 40, 50)];
     lblFacebookMark.text = @"f";
     [lblFacebookMark setFont:[UIFont boldSystemFontOfSize:34.0]];
     [lblFacebookMark setTextColor:[UIColor whiteColor]];
     [lblFacebookMark setTextAlignment:NSTextAlignmentCenter];
     [_btnFacebookSignUp addSubview:lblFacebookMark];*/
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Event Handlers
- (IBAction)onFacebookSignUp:(id)sender {
    dataKeeper.isFacebookConnect = YES;
    if(viCtrlRole == nil)
    {
        viCtrlRole = (OCRoleViewController*)[[OCRoleViewController alloc] viewFromStoryboard];
    }
    [self.navigationController pushViewController:viCtrlRole animated:YES];
}

- (IBAction)onSignUp:(id)sender {
    dataKeeper.isFacebookConnect = NO;
    if(viCtrlRole == nil)
    {
        viCtrlRole = (OCRoleViewController*)[[OCRoleViewController alloc] viewFromStoryboard];
    }
    [self.navigationController pushViewController:viCtrlRole animated:YES];
}

- (IBAction)onEmailLogin:(id)sender {

    dataKeeper.nSelectedRole = STUDENT_ROLE;
    //dataKeeper.nSelectedRole = TEACHER_ROLE;
    
    if(viCtrlLogin == nil)
    {
        viCtrlLogin = (OCLoginViewController*)[[OCLoginViewController alloc] viewFromStoryboard];
    }
    [self.navigationController pushViewController:viCtrlLogin animated:YES];
}

@end
