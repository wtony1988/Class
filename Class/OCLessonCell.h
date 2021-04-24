//
//  OCLessonCell.h
//  Class
//
//  Created by Tony Wang on 11/30/16.
//  Copyright © 2016 TonyWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OCLessonCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgViAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblAge;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (weak, nonatomic) IBOutlet UILabel *lblCountry;
@property (weak, nonatomic) IBOutlet UIButton *btnViewDetail;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIView *viContainer;
@end
