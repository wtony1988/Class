//
//  OCCalendarViewController.m
//  Class
//
//  Created by Tony Wang on 11/26/16.
//  Copyright © 2016 TonyWang. All rights reserved.
//

#import "OCCalendarViewController.h"
#import "GLCalendarDateRange.h"
#import "GLDateUtils.h"
#import "GLCalendarDayCell.h"

@interface OCCalendarViewController ()

@end

@implementation OCCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSDate *today = [NSDate date];
    NSDate *beginDate = [GLDateUtils dateByAddingDays:-23 toDate:today];
    NSDate *endDate = [GLDateUtils dateByAddingDays:-18 toDate:today];
    GLCalendarDateRange *range = [GLCalendarDateRange rangeWithBeginDate:beginDate endDate:endDate];
    range.backgroundColor = [UIColor darkGrayColor];
    range.editable = YES;
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

@end
