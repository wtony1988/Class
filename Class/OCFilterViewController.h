//
//  OCFilterViewController.h
//  Class
//
//  Created by Tony Wang on 12/8/16.
//  Copyright © 2016 TonyWang. All rights reserved.
//

#import "SuperViewController.h"
#import "DataKeeper.h"
#import "VPRangeSlider.h"

@interface OCFilterViewController : SuperViewController<VPRangeSliderDelegate>
{
    DataKeeper* dataKeeper;
}
@property (weak, nonatomic) IBOutlet VPRangeSlider *rangeSlider;
@property (weak, nonatomic) IBOutlet VPRangeSlider *ageRangeSlider;
@property (weak, nonatomic) IBOutlet UILabel *lblPriceMin;
@property (weak, nonatomic) IBOutlet UILabel *lblPriceMax;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segGender;
@property (weak, nonatomic) IBOutlet UILabel *lblAgeMin;
@property (weak, nonatomic) IBOutlet UILabel *lblAgeMax;
@end
