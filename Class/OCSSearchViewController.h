//
//  OCSSearchViewController.h
//  Class
//
//  Created by Tony Wang on 11/26/16.
//  Copyright © 2016 TonyWang. All rights reserved.
//

#import "SuperViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "DataKeeper.h"

@interface OCSSearchViewController : SuperViewController<UITableViewDelegate, UITableViewDataSource>
{
    DataKeeper* dataKeeper;
}

@property (weak, nonatomic) IBOutlet UITableView *tblViSearch;
@property (weak, nonatomic) IBOutlet UIView *viFloat;
@property (weak, nonatomic) IBOutlet UIView *viTopBar;
@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *btnViewMode;

@property (weak, nonatomic) IBOutlet UIView *viLoading;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *lblLoading;

@property (weak, nonatomic) IBOutlet UIView *tabMarker;
@property (weak, nonatomic) IBOutlet UIButton *tab1Hour;
@property (weak, nonatomic) IBOutlet UIButton *tabAvailable;
@property (nonatomic, strong) NSMutableArray* arrTeachers;
@end
