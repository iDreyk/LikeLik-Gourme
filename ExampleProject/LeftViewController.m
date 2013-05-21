//
//  LeftViewController.m
//  MKDSlideViewController
//
//  Created by Marcel Dierkes on 18.04.13.
//
//

#import "LeftViewController.h"
#import "MKDSlideViewController.h"
#import "UIViewController+MKDSlideViewController.h"
#import "MainViewController.h"
#import "SecondaryViewController.h"
#import "thirdViewController.h"
#import "fourthViewController.h"
#import "fifthViewController.h"
#import "newMainViewController.h"

@implementation LeftViewController

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    
    UINavigationController * centerNavigationController = (UINavigationController *)self.navigationController.slideViewController.mainViewController;
    
    if( row == 0 )
    {
        if( [centerNavigationController.topViewController isKindOfClass:[newMainViewController class]] )
            [self.navigationController.slideViewController showMainViewControllerAnimated:YES];
        else
        {
            UIViewController * newMainViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NewMainViewController"];
            //[self.navigationController.slideViewController setMainViewController:newMainViewController];
            [self.navigationController.slideViewController setMainViewController:newMainViewController animated:YES];
        }
    }
    else if( row == 1 )
    {
        if( [centerNavigationController.topViewController isKindOfClass:[fifthViewController class]] )
            [self.navigationController.slideViewController showMainViewControllerAnimated:YES];
        else
        {
            UIViewController * fifthViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FifthViewController"];
            //[self.navigationController.slideViewController setMainViewController:fifthViewController];
            [self.navigationController.slideViewController setMainViewController:fifthViewController animated:YES];
        }
    }

    else if( row == 2 )
    {
        if( [centerNavigationController.topViewController isKindOfClass:[SecondaryViewController class]] )
            [self.navigationController.slideViewController showMainViewControllerAnimated:YES];
        else
        {
            UIViewController * secondaryViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SecondaryViewController"];
            //[self.navigationController.slideViewController setMainViewController:secondaryViewController];
             [self.navigationController.slideViewController setMainViewController:secondaryViewController animated:YES];
        }
    }
    else if( row == 3 )
    {
        if( [centerNavigationController.topViewController isKindOfClass:[thirdViewController class]] )
            [self.navigationController.slideViewController showMainViewControllerAnimated:YES];
        else
        {
            UIViewController * thirdViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ThirdViewController"];
            //[self.navigationController.slideViewController setMainViewController:thirdViewController];
            [self.navigationController.slideViewController setMainViewController:thirdViewController animated:YES];
        }
    }
    else if( row == 4 )
    {
        if( [centerNavigationController.topViewController isKindOfClass:[fourthViewController class]] )
            [self.navigationController.slideViewController showMainViewControllerAnimated:YES];
        else
        {
            UIViewController * fourthViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FourthViewController"];
            //[self.navigationController.slideViewController setMainViewController:fourthViewController];
            [self.navigationController.slideViewController setMainViewController:fourthViewController animated:YES];
        }
    }


    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
