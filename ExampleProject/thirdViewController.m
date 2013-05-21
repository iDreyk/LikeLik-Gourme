//
//  thirdViewController.m
//  MKDSlideViewController
//
//  Created by Ilya on 20.05.13.
//
//

#import "thirdViewController.h"
#import "MKDSlideViewController.h"
#import "UIViewController+MKDSlideViewController.h"


@implementation thirdViewController

- (IBAction)showMenu:(id)sender
{
    // Use the UIViewController (MKDSlideViewController) category as a helper
    [self.navigationController.slideViewController showLeftViewControllerAnimated:YES];
}

@end
