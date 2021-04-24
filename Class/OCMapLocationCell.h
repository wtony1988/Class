//
//  OCMapLocationCell.h
//  Class
//
//  Created by Tony Wang on 12/20/16.
//  Copyright © 2016 TonyWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface OCMapLocationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblPickDistance;
@property (weak, nonatomic) IBOutlet UIButton *btnPicker;
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;


@end
