//
//  OCAccountViewController.m
//  Class
//
//  Created by Tony Wang on 12/1/16.
//  Copyright © 2016 TonyWang. All rights reserved.
//

#import "OCAccountViewController.h"
#import "OCMenuCell.h"

@interface OCAccountViewController ()

@end

@implementation OCAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dataKeeper = [DataKeeper sharedManager];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self loadProfile];
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
- (void)loadProfile
{
    _lblUsername.text = [NSString stringWithFormat:@"%@ %@", dataKeeper.myUserInfo.firstName, dataKeeper.myUserInfo.lastName];
}


#pragma mark - UITableViewDataSource, UITableViewDelegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 5;
    }
    else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OCMenuCell *menuCell = (OCMenuCell*)[tableView dequeueReusableCellWithIdentifier:@"OCMenuCell"];
    if (menuCell == nil) {
        // Load the top-level objects from the custom cell XIB.
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"OCMenuCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        menuCell = [topLevelObjects objectAtIndex:0];
    }
    
    switch (indexPath.row) {
        case 0:
            menuCell.lblTitle.text = @"Switch";
            break;
        case 1:
            menuCell.lblTitle.text = @"Settings";
            break;
        case 2:
            menuCell.lblTitle.text = @"Invite friends";
            break;
        case 3:
            menuCell.lblTitle.text = @"Help";
            break;
        case 4:
            menuCell.lblTitle.text = @"Log out";
            break;
        default:
            break;
    }
    
    return menuCell;
}

@end
