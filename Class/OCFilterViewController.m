//
//  OCFilterViewController.m
//  Class
//
//  Created by Tony Wang on 12/8/16.
//  Copyright © 2016 TonyWang. All rights reserved.
//

#import "OCFilterViewController.h"

@interface OCFilterViewController ()

@end

@implementation OCFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dataKeeper = [DataKeeper sharedManager];
    
    _rangeSlider.requireSegments = NO;
    _rangeSlider.sliderSize = CGSizeMake(20, 20);
    _rangeSlider.segmentSize = CGSizeMake(10, 10);
    
    _rangeSlider.rangeSliderForegroundColor = COLOR_CLASS_RED;
    //self.rangeSlider.rangeSliderButtonImage = [UIImage imageNamed:@"slider"];
    [self.rangeSlider setDelegate:self];
    
    _ageRangeSlider.requireSegments = NO;
    _ageRangeSlider.sliderSize = CGSizeMake(20, 20);
    _ageRangeSlider.segmentSize = CGSizeMake(10, 10);
    
    _ageRangeSlider.rangeSliderForegroundColor = COLOR_CLASS_RED;
    //_ageRangeSlider.rangeSliderButtonImage = [UIImage imageNamed:@"slider"];
    [_ageRangeSlider setDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setTitle:@"Teachers"];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - VPRangeSliderDelegate
- (void)sliderScrolling:(VPRangeSlider *)slider withMinPercent:(CGFloat)minPercent andMaxPercent:(CGFloat)maxPercent
{
    if (slider == _rangeSlider) {
        CGFloat flMinPrice = MAX_PRICE * minPercent/100.0;
        CGFloat flMaxPrice = MAX_PRICE * maxPercent/100.0;
        
        _rangeSlider.minRangeText = [NSString stringWithFormat:@"$%.2f", flMinPrice];
        _rangeSlider.maxRangeText = [NSString stringWithFormat:@"$%.2f", flMaxPrice];
        
        _lblPriceMin.text = _rangeSlider.minRangeText;
        _lblPriceMax.text = _rangeSlider.maxRangeText;
    }
    else if (slider == _ageRangeSlider)
    {
        int nMinAge = (int)(AGE_MIN + (AGE_MAX - AGE_MIN) * minPercent/100.0);
        int nMaxAge = (int)(AGE_MIN + (AGE_MAX - AGE_MIN) * maxPercent/100.0);
        
        _ageRangeSlider.minRangeText = [NSString stringWithFormat:@"%d", nMinAge];
        _ageRangeSlider.maxRangeText = [NSString stringWithFormat:@"%d", nMaxAge];
        
        _lblAgeMin.text = _ageRangeSlider.minRangeText;
        _lblAgeMax.text = _ageRangeSlider.maxRangeText;
    }
    
}

@end
