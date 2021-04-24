//
//  OCRoleViewController.m
//  Class
//
//  Created by Tony Wang on 11/22/16.
//  Copyright © 2016 TonyWang. All rights reserved.
//

#import "OCRoleViewController.h"
#import "OCSignUpViewController.h"

@interface OCRoleViewController ()
{
    OCSignUpViewController* viCtrlSignUp;
}

@end

@implementation OCRoleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dataKeeper = [DataKeeper sharedManager];
    
    _btnStudent.layer.masksToBounds = YES;
    _btnStudent.layer.cornerRadius = 4.0;
    _btnStudent.layer.borderWidth = 1.0;

    
    _btnTeacher.layer.masksToBounds = YES;
    _btnTeacher.layer.cornerRadius = 4.0;
    _btnTeacher.layer.borderWidth = 1.0;

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self loadRoleButtons];
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
- (void)loadRoleButtons
{
    if (dataKeeper.nSelectedRole == STUDENT_ROLE) {
        [_btnStudent setBackgroundColor:[UIColor whiteColor]];
        [_logoStudent setImage:[UIImage imageNamed:@"student_active.png"]];
        [_lblStudent setText:@"STUDENT"];
        [_lblStudent setTextColor:COLOR_CLASS_BLACK];
        _btnStudent.layer.borderColor = [UIColor whiteColor].CGColor;
        
        [_btnTeacher setBackgroundColor:[UIColor clearColor]];
        [_logoTeacher setImage:[UIImage imageNamed:@"teacher_inactive.png"]];
        [_lblTeacher setText:@"TEACHER"];
        [_lblTeacher setTextColor:[UIColor whiteColor]];
        _btnTeacher.layer.borderColor = COLOR_CLASS_BORDER.CGColor;

    }
    else if(dataKeeper.nSelectedRole == TEACHER_ROLE) {
        [_btnTeacher setBackgroundColor:[UIColor whiteColor]];
        [_logoTeacher setImage:[UIImage imageNamed:@"teacher_active.png"]];
        [_lblTeacher setText:@"TEACHER"];
        [_lblTeacher setTextColor:COLOR_CLASS_BLACK];
        _btnTeacher.layer.borderColor = [UIColor whiteColor].CGColor;
        
        [_btnStudent setBackgroundColor:[UIColor clearColor]];
        [_logoStudent setImage:[UIImage imageNamed:@"student_inactive.png"]];
        [_lblStudent setText:@"STUDENT"];
        [_lblStudent setTextColor:[UIColor whiteColor]];
        _btnStudent.layer.borderColor = COLOR_CLASS_BORDER.CGColor;
    }
    
}

#pragma mark - Event Handlers
- (IBAction)onStudent:(id)sender {
    dataKeeper.nSelectedRole = STUDENT_ROLE;
    [self loadRoleButtons];
    
    if(viCtrlSignUp == nil)
    {
        viCtrlSignUp = (OCSignUpViewController*)[[OCSignUpViewController alloc] viewFromStoryboard];
    }
    [self.navigationController pushViewController:viCtrlSignUp animated:YES];
}

- (IBAction)onTeacher:(id)sender {
    dataKeeper.nSelectedRole = TEACHER_ROLE;
    [self loadRoleButtons];
    
    if(viCtrlSignUp == nil)
    {
        viCtrlSignUp = (OCSignUpViewController*)[[OCSignUpViewController alloc] viewFromStoryboard];
    }
    [self.navigationController pushViewController:viCtrlSignUp animated:YES];
}

- (IBAction)onBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
