//
//  OCAccountViewController.h
//  Class
//
//  Created by Tony Wang on 12/1/16.
//  Copyright © 2016 TonyWang. All rights reserved.
//

#import "SuperViewController.h"
#import "DataKeeper.h"

@interface OCAccountViewController : SuperViewController<UITableViewDataSource, UITableViewDelegate>
{
    DataKeeper* dataKeeper;
}

@property (weak, nonatomic) IBOutlet UITableView *tblViAccount;
@property (weak, nonatomic) IBOutlet UIImageView *imgViUserAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lblUsername;
@end
