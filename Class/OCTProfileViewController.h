//
//  OCTProfileViewController.h
//  Class
//
//  Created by Tony Wang on 11/26/16.
//  Copyright © 2016 TonyWang. All rights reserved.
//

#import "SuperViewController.h"
#import "DataKeeper.h"

@interface OCTProfileViewController : SuperViewController<UITableViewDataSource, UITableViewDelegate>
{
    DataKeeper* dataKeeper;
}
@property (weak, nonatomic) IBOutlet UITableView *tblViProfile;
@property (weak, nonatomic) IBOutlet UIView *viTHeader;

@end
