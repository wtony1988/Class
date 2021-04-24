//
//  OCRoleViewController.h
//  Class
//
//  Created by Tony Wang on 11/22/16.
//  Copyright © 2016 TonyWang. All rights reserved.
//

#import "SuperViewController.h"
#import "DataKeeper.h"

@interface OCRoleViewController : SuperViewController
{
    DataKeeper* dataKeeper;
}
@property (weak, nonatomic) IBOutlet UIButton *btnStudent;
@property (weak, nonatomic) IBOutlet UIButton *btnTeacher;
@property (weak, nonatomic) IBOutlet UIImageView *logoStudent;
@property (weak, nonatomic) IBOutlet UILabel *lblStudent;
@property (weak, nonatomic) IBOutlet UIImageView *logoTeacher;
@property (weak, nonatomic) IBOutlet UILabel *lblTeacher;
@end
