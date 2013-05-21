//
//  newMainViewController.m
//  MKDSlideViewController
//
//  Created by Ilya on 21.05.13.
//
//

#import "newMainViewController.h"

#import "MKDSlideViewController.h"
#import "UIViewController+MKDSlideViewController.h"

@implementation newMainViewController

- (IBAction)showMenu:(id)sender
{
    // Use the UIViewController (MKDSlideViewController) category as a helper
    [self.navigationController.slideViewController showLeftViewControllerAnimated:YES];
}

@end
