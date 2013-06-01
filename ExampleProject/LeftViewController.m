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
@synthesize catalogueTableView;
static bool OPENED = NO;
int EXPANDED_ON = 0;

#pragma mark - Table view delegate

- (void)viewDidLoad{
    self.array =         [[NSArray alloc] initWithArray:@[@"Around me", @"Featured places", @"Catalogue", @"Favourites",@"Transportation",@"Practical info",@"Settings"]];
    //self.expandArray =[[NSArray alloc] initWithArray:@[@"1", @"2", @"3",@"4"]];
}
#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (section == 2) {
//        return [self.expandArray count];
//    }
    //return [self.array count];
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 20, 200, 50); // position in the parent view and set the size of the button
    [button setTitle:[self.array objectAtIndex:section] forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    // add targets and actions
    [button addTarget:self action:@selector(pusher:) forControlEvents:UIControlEventTouchUpInside];
    [button setTag:section];
    return button;
}

-(void)pusher:(UIButton *)Sender{
    NSUInteger row = Sender.tag;
    
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
//        NSIndexSet *indSet = [[NSIndexSet alloc] initWithIndex:2];
        if (OPENED == YES){
            self.array = [[NSArray alloc] initWithArray:@[@"Around me", @"Featured places", @"Catalogue", @"Favourites",@"Transportation",@"Practical info",@"Settings"]];
            EXPANDED_ON = 0;
            //[tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]  withRowAnimation:UITableViewRowAnimationTop];
            //[catalogueTableView reloadSections:indSet withRowAnimation:UITableViewRowAnimationBottom];
        }
        else{
            self.array =  [[NSArray alloc] initWithArray:@[@"Around me", @"Featured places", @"Catalogue", @"      Restaurants", @"      Shopping", @"      Culture", @"      Leisure", @"      Beauty", @"      Hotels", @"      Restaurants", @"Favourites",@"Transportation",@"Practical info",@"Settings"]];
            EXPANDED_ON = 7;
            //[catalogueTableView reloadSections:indSet withRowAnimation:UITableViewRowAnimationBottom];
            //[tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]  withRowAnimation:UITableViewRowAnimationBottom];
            //[catalogueTableView reloadData];
        }
        [catalogueTableView reloadData];
        OPENED = !OPENED;
        //reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationBottom];
        //        if( [centerNavigationController.topViewController isKindOfClass:[SecondaryViewController class]] )
        //            [self.navigationController.slideViewController showMainViewControllerAnimated:YES];
        //        else
        //        {
        //            UIViewController * secondaryViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SecondaryViewController"];
        //            //[self.navigationController.slideViewController setMainViewController:secondaryViewController];
        //             [self.navigationController.slideViewController setMainViewController:secondaryViewController animated:YES];
        //        }
        // self.array = @[@"1",@"2",@"3",@"4",@"5"];
       // [catalogueTableView reloadData];
        
    }
    if (row < (EXPANDED_ON + 3) && row > 2) {
            if( [centerNavigationController.topViewController isKindOfClass:[fifthViewController class]] )
                [self.navigationController.slideViewController showMainViewControllerAnimated:YES];
            else
            {
                UIViewController * fifthViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FifthViewController"];
                //[self.navigationController.slideViewController setMainViewController:fifthViewController];
                [self.navigationController.slideViewController setMainViewController:fifthViewController animated:YES];
            }
    }
    
    else if( row == 3 + EXPANDED_ON)
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
    else if( row == 4 + EXPANDED_ON)
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

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.array count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = nil;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
//    cell.backgroundView = [InterfaceFunctions CellBG];
//    cell.selectedBackgroundView = [InterfaceFunctions SelectedCellBG];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = [self.array objectAtIndex:[indexPath row]];
    NSLog(@"123");
//    NSString *text = AMLocalizedString([self.CellArray objectAtIndex:[indexPath row]], nil);
//    if ([indexPath row]<8 && [indexPath row]!=0) {
//        [cell addSubview:[InterfaceFunctions mainTextLabelwithText:text AndColor:[InterfaceFunctions mainTextColor:[indexPath row]+1]]];
//        [cell addSubview:[InterfaceFunctions actbwithColor:[indexPath row]+1]];
//    }
//    else{
//        [cell addSubview:[InterfaceFunctions mainTextLabelwithText:text AndColor:[InterfaceFunctions corporateIdentity]]];
//        [cell addSubview:[InterfaceFunctions corporateIdentity_actb]];
//    }
    return cell;
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end


