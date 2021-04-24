//
//  OCTProfileViewController.m
//  Class
//
//  Created by Tony Wang on 11/26/16.
//  Copyright © 2016 TonyWang. All rights reserved.
//

#import "OCTProfileViewController.h"
#import "OCValueCell.h"
#import "OCTProfileHeaderCell.h"

@interface OCTProfileViewController ()
{
    NSMutableArray* arrProperties;
}

@end

@implementation OCTProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dataKeeper = [DataKeeper sharedManager];
    arrProperties = [[NSMutableArray alloc] initWithObjects:
                     [NSDictionary dictionaryWithObjectsAndKeys:@"Member since November 2016", @"title", @"203 View(s)", @"value", nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"Hourly fee", @"title", @"3000", @"value", nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"Expertise", @"title", @"Professional teacher", @"value", nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"Lesson duration", @"title", @"1 to 4 hours", @"value", nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"Country of origin", @"title", @"English", @"value", nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"Mother tongue", @"title", @"English", @"value", nil],
                     [NSDictionary dictionaryWithObjectsAndKeys:@"Japanese proficiency", @"title", @"Novice", @"value", nil],
                     nil];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    if (dataKeeper.nSelectedRole == TEACHER_ROLE) {
        self.navigationController.navigationBar.tintColor = COLOR_CLASS_CYAN;
    }
    else {
        self.navigationController.navigationBar.tintColor = COLOR_CLASS_RED;
    }
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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

#pragma mark - UITableViewDataSource, UITableViewDelegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrProperties count] + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 580.0;
    }
    return 54.0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        OCTProfileHeaderCell *headerCell = (OCTProfileHeaderCell*)[tableView dequeueReusableCellWithIdentifier:@"OCTProfileHeaderCell"];
        if (headerCell == nil) {
            // Load the top-level objects from the custom cell XIB.
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"OCTProfileHeaderCell" owner:self options:nil];
            // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
            headerCell = [topLevelObjects objectAtIndex:0];
        }
        
        return headerCell;
    }
    else{
        OCValueCell *valueCell = (OCValueCell*)[tableView dequeueReusableCellWithIdentifier:@"OCValueCell"];
        if (valueCell == nil) {
            // Load the top-level objects from the custom cell XIB.
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"OCValueCell" owner:self options:nil];
            // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
            valueCell = [topLevelObjects objectAtIndex:0];
        }
        
        NSDictionary* dicValue = [arrProperties objectAtIndex:indexPath.row - 1];
        valueCell.lblTitle.text = [dicValue objectForKey:@"title"];
        valueCell.lblValue.text = [dicValue objectForKey:@"value"];
        
        return valueCell;
    }
}


@end
