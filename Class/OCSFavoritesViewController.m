//
//  OCSFavoritesViewController.m
//  Class
//
//  Created by Tony Wang on 11/26/16.
//  Copyright © 2016 TonyWang. All rights reserved.
//

#import "OCSFavoritesViewController.h"
#import "OCTeacherCell.h"
#import "OCSScheduleLessonViewController.h"

@interface OCSFavoritesViewController ()
{
    OCSScheduleLessonViewController* viCtrlScheduleLesson;
}

@end

@implementation OCSFavoritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dataKeeper = [DataKeeper sharedManager];
    _arrTeachers = [[NSMutableArray alloc] init];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
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
- (void)onScheduleLesson:(id)sender {
    
    //dataKeeper.lastSelectedTeacher = [_arrTeachers objectAtIndex:[sender tag]];
    
    if( viCtrlScheduleLesson == nil)
    {
        viCtrlScheduleLesson = (OCSScheduleLessonViewController*)[[OCSScheduleLessonViewController alloc] viewFromStoryboard];
    }
    [self.navigationController pushViewController:viCtrlScheduleLesson animated:YES];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
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
    
    [teacherCell.btnSchedule setTag:indexPath.row];
    [teacherCell.btnSchedule addTarget:self action:@selector(onScheduleLesson:) forControlEvents:UIControlEventTouchUpInside];
    
    return teacherCell;
}

@end
