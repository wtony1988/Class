//
//  OCPickerCell.h
//  Class
//
//  Created by Tony Wang on 12/19/16.
//  Copyright © 2016 TonyWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OCPickerCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblPickValue;
@property (weak, nonatomic) IBOutlet UIButton *btnPicker;
@property (weak, nonatomic) IBOutlet UIButton *btnInfo;

@end
