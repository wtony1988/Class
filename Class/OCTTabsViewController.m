//
//  OCTTabsViewController.m
//  Class
//
//  Created by Tony Wang on 11/27/16.
//  Copyright © 2016 TonyWang. All rights reserved.
//

#import "OCTTabsViewController.h"

@interface OCTTabsViewController ()

@end

@implementation OCTTabsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[self.tabBar.items objectAtIndex:0] setTitle:@"HOME"];
    [[self.tabBar.items objectAtIndex:0] setImage:[UIImage imageNamed:@"tab_icon_home.png"]];
    [[self.tabBar.items objectAtIndex:0] setSelectedImage:[UIImage imageNamed:@"tab_icon_home.png"]];
    
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
