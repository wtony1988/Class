//
//  OCCalendarCell.h
//  Class
//
//  Created by Tony Wang on 12/29/16.
//  Copyright © 2016 TonyWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GLCalendarView.h"

@interface OCCalendarCell : UITableViewCell
@property (weak, nonatomic) IBOutlet GLCalendarView *calendarView;

@end
