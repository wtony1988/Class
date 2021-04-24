//
//  OCLessonsViewController.h
//  Class
//
//  Created by Tony Wang on 11/26/16.
//  Copyright © 2016 TonyWang. All rights reserved.
//

#import "SuperViewController.h"
#import "GLCalendarView.h"
#import "DataKeeper.h"

@interface OCLessonsViewController : SuperViewController<UITableViewDelegate, UITableViewDataSource>
{
    DataKeeper* dataKeeper;
}

@property (nonatomic, strong) NSMutableArray* arrUpcomingLessons;
@property (nonatomic, strong) NSMutableArray* arrRequestedLessons;
@property (nonatomic, strong) NSMutableArray* arrPastLessons;

@property (weak, nonatomic) IBOutlet UIButton *btnTabUpcoming;
@property (weak, nonatomic) IBOutlet UIButton *btnTabRequested;
@property (weak, nonatomic) IBOutlet UIButton *btnTabPast;
@property (weak, nonatomic) IBOutlet UILabel *markSelectedTab;
@property (weak, nonatomic) IBOutlet UITableView *tblLessons;
@property (weak, nonatomic) IBOutlet UIView *viTabs;

@property (weak, nonatomic) IBOutlet UILabel *lblUpcomingNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblRequestedNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblPastNumber;

@property (weak, nonatomic) IBOutlet UIView *viLoading;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *lblLoading;

@end
