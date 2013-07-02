//
//  fourthViewController.m
//  MKDSlideViewController
//
//  Created by Ilya on 21.05.13.
//
//

#import "fourthViewController.h"

#import "MKDSlideViewController.h"
#import "UIViewController+MKDSlideViewController.h"


@implementation fourthViewController
@synthesize cityTableView;
@synthesize storedData;
@synthesize austrianCities;
@synthesize russianCities;

- (IBAction)showMenu:(id)sender
{
    // Use the UIViewController (MKDSlideViewController) category as a helper
    [self.navigationController.slideViewController callLeftMenu];
    //[self.navigationController.slideViewController showLeftViewControllerAnimated:YES];
}

#pragma mark - Table view delegate

- (void)viewDidLoad{
    self.array =         [[NSArray alloc] initWithArray:@[@"Austria", @"Russia"]];
    self.austrianCities =[[NSArray alloc] initWithArray:@[@"Viena"]];
    self.russianCities = [[NSArray alloc] initWithArray:@[@"Moscow", @"Ufa"]];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return self.austrianCities.count;
    if (section == 1)
        return  self.russianCities.count;
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //button.backgroundColor = [UIColor blackColor];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    button.frame = CGRectMake(10, 20, 200, 50); // position in the parent view and set the size of the button
    [button setTitle:[self.array objectAtIndex:section] forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    // add targets and actions
    [button addTarget:self action:@selector(pusher:) forControlEvents:UIControlEventTouchUpInside];
    [button setTag:section];
    return button;
}

-(void)pusher:(UIButton *)Sender{
    //    NSUInteger row = Sender.tag;
    //    if(row == 0){
    //        if (OPENED_CASH == YES){
    //            self.rowCountCash -= 5;
    //            NSArray *paths = [[NSArray alloc] initWithObjects:
    //                              [NSIndexPath indexPathForRow:0 inSection:0],
    //                              [NSIndexPath indexPathForRow:1 inSection:0],
    //                              [NSIndexPath indexPathForRow:2 inSection:0],
    //                              [NSIndexPath indexPathForRow:3 inSection:0],
    //                              [NSIndexPath indexPathForRow:4 inSection:0],
    //                              nil];
    //            [self.tableView beginUpdates];
    //            [self.tableView deleteRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationMiddle];
    //            [self.tableView endUpdates];
    //        }
    //        else{
    //            self.rowCountCash += 5;
    //            NSArray *paths = [[NSArray alloc] initWithObjects:
    //                              [NSIndexPath indexPathForRow:0 inSection:0],
    //                              [NSIndexPath indexPathForRow:1 inSection:0],
    //                              [NSIndexPath indexPathForRow:2 inSection:0],
    //                              [NSIndexPath indexPathForRow:3 inSection:0],
    //                              [NSIndexPath indexPathForRow:4 inSection:0],
    //                              nil];
    //            [self.tableView beginUpdates];
    //            [self.tableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationMiddle];
    //            [self.tableView endUpdates];
    //        }
    //        OPENED_CASH = !OPENED_CASH;
    //
    //    }
    //    else if( row == 1 )
    //    {
    //        if (OPENED_COUSINE == YES){
    //            self.rowCountCousine -= 7;
    //            NSArray *paths = [[NSArray alloc] initWithObjects:
    //                              [NSIndexPath indexPathForRow:0 inSection:1],
    //                              [NSIndexPath indexPathForRow:1 inSection:1],
    //                              [NSIndexPath indexPathForRow:2 inSection:1],
    //                              [NSIndexPath indexPathForRow:3 inSection:1],
    //                              [NSIndexPath indexPathForRow:4 inSection:1],
    //                              [NSIndexPath indexPathForRow:5 inSection:1],
    //                              [NSIndexPath indexPathForRow:6 inSection:1],
    //                              nil];
    //            [self.tableView beginUpdates];
    //            [self.tableView deleteRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationMiddle];
    //            [self.tableView endUpdates];
    //        }
    //        else{
    //            self.rowCountCousine += 7;
    //            NSArray *paths = [[NSArray alloc] initWithObjects:
    //                              [NSIndexPath indexPathForRow:0 inSection:1],
    //                              [NSIndexPath indexPathForRow:1 inSection:1],
    //                              [NSIndexPath indexPathForRow:2 inSection:1],
    //                              [NSIndexPath indexPathForRow:3 inSection:1],
    //                              [NSIndexPath indexPathForRow:4 inSection:1],
    //                              [NSIndexPath indexPathForRow:5 inSection:1],
    //                              [NSIndexPath indexPathForRow:6 inSection:1],
    //                              nil];
    //            [self.tableView beginUpdates];
    //            [self.tableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationMiddle];
    //            [self.tableView endUpdates];
    //        }
    //        OPENED_COUSINE = !OPENED_COUSINE;
    //
    //    }
    //    else if( row == 2 ){
    //        if (OPENED_MENU == YES){
    //            self.rowCountMenu -= 7;
    //            NSArray *paths = [[NSArray alloc] initWithObjects:
    //                              [NSIndexPath indexPathForRow:0 inSection:2],
    //                              [NSIndexPath indexPathForRow:1 inSection:2],
    //                              [NSIndexPath indexPathForRow:2 inSection:2],
    //                              [NSIndexPath indexPathForRow:3 inSection:2],
    //                              [NSIndexPath indexPathForRow:4 inSection:2],
    //                              [NSIndexPath indexPathForRow:5 inSection:2],
    //                              [NSIndexPath indexPathForRow:6 inSection:2],
    //                              nil];
    //            [self.tableView beginUpdates];
    //            [self.tableView deleteRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationMiddle];
    //            [self.tableView endUpdates];
    //        }
    //        else{
    //            self.rowCountMenu += 7;
    //            NSArray *paths = [[NSArray alloc] initWithObjects:
    //                              [NSIndexPath indexPathForRow:0 inSection:2],
    //                              [NSIndexPath indexPathForRow:1 inSection:2],
    //                              [NSIndexPath indexPathForRow:2 inSection:2],
    //                              [NSIndexPath indexPathForRow:3 inSection:2],
    //                              [NSIndexPath indexPathForRow:4 inSection:2],
    //                              [NSIndexPath indexPathForRow:5 inSection:2],
    //                              [NSIndexPath indexPathForRow:6 inSection:2],
    //                              nil];
    //            [self.tableView beginUpdates];
    //            [self.tableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationMiddle];
    //            [self.tableView endUpdates];
    //        }
    //        OPENED_MENU = !OPENED_MENU;
    //    }
    //
    //
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
    //    cell.backgroundColor = [UIColor blackColor];
    //    cell.textLabel.textColor = [UIColor whiteColor];
        if(indexPath.section == 0)
            cell.textLabel.text = [self.austrianCities objectAtIndex:[indexPath row]];
        else if (indexPath.section == 1)
            cell.textLabel.text = [self.russianCities objectAtIndex:[indexPath row]];
    //    else if(indexPath.section == 2)
    //        cell.textLabel.text = [self.expandArrayMenu objectAtIndex:[indexPath row]];
    //

    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:[UIColor orangeColor]];
    [cell setSelectedBackgroundView:bgColorView];
    
    if([NSUserDefaults standardUserDefaults]){
        NSInteger section = [[NSUserDefaults standardUserDefaults] integerForKey:@"curentCitySection"];
        NSInteger row = [[NSUserDefaults standardUserDefaults] integerForKey:@"curentCityRow"];
        if (indexPath.section == section && indexPath.row == row){
            NSIndexPath *savedCity = [NSIndexPath indexPathForRow:row inSection:section];
            [self.tableView selectRowAtIndexPath:savedCity animated:YES scrollPosition:NO];
            NSLog(@"Loaded from userdefaults! %d %d",section, row);
        }
    }
    
    return cell;
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger indPthSect = [indexPath section];
    NSInteger indPthRow = [indexPath row];
    [[NSUserDefaults standardUserDefaults] setInteger:indPthSect forKey:@"curentCitySection"];
    [[NSUserDefaults standardUserDefaults] setInteger:indPthRow forKey:@"curentCityRow"];
    NSLog(@"Saved to userdefaults! %d %d",indPthSect, indPthRow);

}

@end


