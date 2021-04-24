//
//  OCTimeRangeCell.h
//  Class
//
//  Created by Tony Wang on 12/28/16.
//  Copyright © 2016 TonyWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VPRangeSlider.h"

@interface OCTimeRangeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet VPRangeSlider *timeSlider;
@property (weak, nonatomic) IBOutlet UILabel *lblStartTime;
@property (weak, nonatomic) IBOutlet UILabel *lblDuration;

@end
