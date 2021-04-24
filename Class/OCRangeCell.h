//
//  OCRangeCell.h
//  Class
//
//  Created by Tony Wang on 12/20/16.
//  Copyright © 2016 TonyWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VPRangeSlider.h"

@interface OCRangeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet VPRangeSlider *rangeSlider;
@end
