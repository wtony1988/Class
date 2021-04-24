//
//  OCSScheduleLessonViewController.h
//  Class
//
//  Created by Tony Wang on 12/28/16.
//  Copyright © 2016 TonyWang. All rights reserved.
//

#import "SuperViewController.h"
#import "DataKeeper.h"

@interface OCSScheduleLessonViewController : SuperViewController<UITableViewDelegate, UITableViewDataSource>
{
    DataKeeper* dataKeeper;
}
@property (weak, nonatomic) IBOutlet UITableView *tblViRequest;

@property (weak, nonatomic) IBOutlet UIView *viLoading;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *lblLoading;

@end
