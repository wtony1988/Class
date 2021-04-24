//
//  OCSignUpViewController.h
//  Class
//
//  Created by Tony Wang on 11/23/16.
//  Copyright © 2016 TonyWang. All rights reserved.
//

#import "SuperViewController.h"
#import "DataKeeper.h"

@interface OCSignUpViewController : SuperViewController<UITableViewDataSource, UITableViewDelegate>
{
    DataKeeper* dataKeeper;
}
@property (weak, nonatomic) IBOutlet UITableView *tblViInput;
@property (weak, nonatomic) IBOutlet UIView *viLoading;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *lblLoading;
@end
