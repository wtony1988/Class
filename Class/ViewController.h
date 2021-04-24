//
//  ViewController.h
//  Class
//
//  Created by Tony Wang on 11/22/16.
//  Copyright © 2016 TonyWang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperViewController.h"
#import "DataKeeper.h"

@interface ViewController : SuperViewController
{
    DataKeeper* dataKeeper;
}

@property (weak, nonatomic) IBOutlet UIButton *btnFacebookSignUp;
@property (weak, nonatomic) IBOutlet UIButton *btnSignUp;
@property (weak, nonatomic) IBOutlet UIButton *btnEmailLogin;
@end

