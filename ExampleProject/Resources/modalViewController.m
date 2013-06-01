//
//  modalViewController.m
//  MKDSlideViewController
//
//  Created by Ilya on 31.05.13.
//
//

#import "modalViewController.h"
#import "MKDSlideViewController.h"
#import "UIViewController+MKDSlideViewController.h"
@interface modalViewController ()

@end

@implementation modalViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // You are now responsible for your own menu button
    UIBarButtonItem * menuItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ButtonMenu"]
                                                                  style:UIBarButtonItemStyleBordered
                                                                 target:self
                                                                 action:@selector(showMenu:)];
    self.navigationItem.leftBarButtonItem = menuItem;
    
    [menuItem release];
}

- (IBAction)showMenu:(id)sender
{
    // Use the UIViewController (MKDSlideViewController) category as a helper
    [self.navigationController.slideViewController showLeftViewControllerAnimated:YES];
}

- (IBAction)close:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if( [self.view window] == nil )
    {
        self.textView = nil;
    }
}

#pragma mark -

- (void)setDetailText:(NSString *)detailText
{
    self.textView.text = detailText;
}

@end
