//
//  OCSTabsViewController.m
//  Class
//
//  Created by Tony Wang on 11/27/16.
//  Copyright © 2016 TonyWang. All rights reserved.
//

#import "OCSTabsViewController.h"

@interface OCSTabsViewController ()

@end

@implementation OCSTabsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[self.tabBar.items objectAtIndex:2] setTitle:@"LESSONS"];
    [[self.tabBar.items objectAtIndex:2] setImage:[UIImage imageNamed:@"tab_icon_lessons.png"]];
    [[self.tabBar.items objectAtIndex:2] setSelectedImage:[UIImage imageNamed:@"tab_icon_lessons.png"]];

    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};

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

@end
