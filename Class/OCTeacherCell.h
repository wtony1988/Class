//
//  OCTeacherCell.h
//  Class
//
//  Created by Tony Wang on 12/3/16.
//  Copyright © 2016 TonyWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AXRatingView.h"

@interface OCTeacherCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *viContainer;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblAge;
@property (weak, nonatomic) IBOutlet UILabel *lblCountry;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblDistance;
@property (weak, nonatomic) IBOutlet AXRatingView *viRate;
@property (weak, nonatomic) IBOutlet UIImageView *imgViAvatar;
@property (weak, nonatomic) IBOutlet UIButton *btnSchedule;
@property (weak, nonatomic) IBOutlet UIButton *btnFavorite;

@end
