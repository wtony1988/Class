//
//  OCSFavoritesViewController.h
//  Class
//
//  Created by Tony Wang on 11/26/16.
//  Copyright © 2016 TonyWang. All rights reserved.
//

#import "SuperViewController.h"
#import "DataKeeper.h"

@interface OCSFavoritesViewController : SuperViewController<UITableViewDelegate, UITableViewDataSource>
{
    DataKeeper* dataKeeper;
}

@property (weak, nonatomic) IBOutlet UITableView *tblViFavorites;

@property (nonatomic, strong) NSMutableArray* arrTeachers;
@end
