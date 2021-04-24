//
//  OCAvailableTimeCell.h
//  Class
//
//  Created by Tony Wang on 12/28/16.
//  Copyright © 2016 TonyWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OCAvailableTimeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblTimeStones;
@property (weak, nonatomic) IBOutlet UIView *viProgressBg;
@property (weak, nonatomic) IBOutlet UIImageView *viProgress;
@property (weak, nonatomic) IBOutlet UILabel *lblWeekday;

@end
