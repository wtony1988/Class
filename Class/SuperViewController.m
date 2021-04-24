//
//  SuperViewController.m
//  
//
//  Created by Tapha Media Ltd on 9/27/11.
//  Copyright (c) 2013 Tapha Media Ltd. All rights reserved.
//

#import "SuperViewController.h"


@implementation SuperViewController


- (SuperViewController *) viewFromStoryboard
{
    NSLog(@"%@", NSStringFromClass([self class]));
    
    return [SuperViewController viewFromStoryboard:NSStringFromClass([self class])];
}

+ (SuperViewController *) viewFromStoryboard:(NSString *)storyboardID
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SuperViewController * controller = [storyBoard instantiateViewControllerWithIdentifier:storyboardID];
    
    return controller;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
    
    _flDeviceW = [UIScreen mainScreen].bounds.size.width;
    _flDeviceH = [UIScreen mainScreen].bounds.size.height;
}


- (void) viewWillAppear:(BOOL)animated
{
    [self resize];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void) resize
{
    CGRect frm = self.view.frame;
    frm.origin.y = 0;
    [self.view setFrame:frm];
}

#pragma mark - Event Handlers

@end
