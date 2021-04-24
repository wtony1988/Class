//
//  RequestedLessonCell.h
//  Class
//
//  Created by Tony Wang on 11/30/16.
//  Copyright © 2016 TonyWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RequestedLessonCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgViAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblAge;
@property (weak, nonatomic) IBOutlet UILabel *lblCountry;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblAvailableHours;
@property (weak, nonatomic) IBOutlet UIButton *btnSetLocationAndConfirm;
@property (weak, nonatomic) IBOutlet UIButton *btnReject;
@property (weak, nonatomic) IBOutlet UIButton *btnAction;
@property (weak, nonatomic) IBOutlet UIView *viContainer;

@end
