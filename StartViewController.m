//
//  StartViewController.m
//  Registration
//
//  Created by Vladimir Malov on 08.07.13.
//  Copyright (c) 2013 LikeLik. All rights reserved.
//

#import "StartViewController.h"
#import "RegistrationViewController.h"
@interface StartViewController ()

@end

@implementation StartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:150.0/255.0 green:100.0/255.0 blue:170.0/255.0 alpha:1]];
    //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbar.png"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationItem.titleView = [InterfaceFunctions NavLabelwithTitle:[[NSString alloc] initWithFormat:@"Вход"] AndColor:[InterfaceFunctions corporateIdentity]];

	// Do any additional setup after loading the view.
}

- (IBAction)close:(id)sender{
    [self dismissViewControllerAnimated:YES completion:^{}];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
        RegistrationViewController *destination = [segue destinationViewController];
    if ([[segue identifier] isEqualToString:@"RegistrationSegue"]) {
        destination.LorR = @"Registration";
    }
    if ([[segue identifier] isEqualToString:@"LoginSegue"]) {
        destination.LorR = @"Login";
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
