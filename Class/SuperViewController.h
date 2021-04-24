//
//  SuperViewController.h
//  
//
//  Created by Tapha Media Ltd on 9/27/11.
//  Copyright (c) 2013 Tapha Media Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Global.h"


/*================================================================================
 *
 *	SuperViewController
 * ----------------------------------
 *
 *	All other view controllers throughout the app are inherited from this class.
 *
 ==================================================================================*/


@interface SuperViewController : UIViewController<UIAlertViewDelegate> {
    IBOutlet UIImageView * imgvwBG;
}

@property (nonatomic, assign) CGFloat flDeviceW;
@property (nonatomic, assign) CGFloat flDeviceH;

- (SuperViewController *) viewFromStoryboard;
+ (SuperViewController *) viewFromStoryboard:(NSString *)storyboardID;

- (void) resize;
- (void) showSettings;


@end
