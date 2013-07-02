//
//  fifthViewController.m
//  MKDSlideViewController
//
//  Created by Ilya on 21.05.13.
//
//

#import "fifthViewController.h"

#import "MKDSlideViewController.h"
#import "UIViewController+MKDSlideViewController.h"

@implementation fifthViewController
@synthesize restourantsTableView;
- (IBAction)showMenu:(id)sender
{
    // Use the UIViewController (MKDSlideViewController) category as a helper
    [self.navigationController.slideViewController callLeftMenu];
    //[self.navigationController.slideViewController showLeftViewControllerAnimated:YES];
}


#pragma mark - Table view delegate

- (void)viewDidLoad{
    self.array =         [[NSArray alloc] initWithArray:@[@"1st place",@"2nd place",@"3rd place",@"4th place",@"5th place",@"6th place",@"7th place",@"1st place",@"2nd place",@"3rd place",@"4th place",@"5th place",@"6th place",@"7th place"]];
    //    self.rowCount = 6;
    
    
}
#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    if (section == 2)
    //        return self.rowCount;
    //return [self.array count];
    //return 0;
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor blackColor];
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
    
    //    UINavigationController * centerNavigationController = (UINavigationController *)self.navigationController.slideViewController.mainViewController;
    
    //    if( row == 0 )
    //    {
    //        NSLog(@"pusher 1");
    //        if( [centerNavigationController.topViewController isKindOfClass:[newMainViewController class]] )
    //            [self.navigationController.slideViewController showMainViewControllerAnimated:YES];
    //        else
    //        {
    //            UIViewController * newMainViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NewMainViewController"];
    //            //[self.navigationController.slideViewController setMainViewController:newMainViewController];
    //            [self.navigationController.slideViewController setMainViewController:newMainViewController animated:YES];
    //        }
    //    }
    //    else if( row == 1 )
    //    {
    //        NSLog(@"pusher 2");
    //        if( [centerNavigationController.topViewController isKindOfClass:[fifthViewController class]] )
    //            [self.navigationController.slideViewController showMainViewControllerAnimated:YES];
    //        else
    //        {
    //            UIViewController * fifthViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FifthViewController"];
    //            //[self.navigationController.slideViewController setMainViewController:fifthViewController];
    //            [self.navigationController.slideViewController setMainViewController:fifthViewController animated:YES];
    //        }
    //    }
    //
    //    else if( row == 2 ){
    //        if (OPENED == YES){
    //            NSLog(@"pusher 3");
    //            // EXPANDED_ON = 0;
    //            self.rowCount -= 6;
    //            NSArray *paths = [[NSArray alloc] initWithObjects:
    //                              [NSIndexPath indexPathForRow:0 inSection:2],
    //                              [NSIndexPath indexPathForRow:1 inSection:2],
    //                              [NSIndexPath indexPathForRow:2 inSection:2],
    //                              [NSIndexPath indexPathForRow:3 inSection:2],
    //                              [NSIndexPath indexPathForRow:4 inSection:2],
    //                              [NSIndexPath indexPathForRow:5 inSection:2],
    //                              nil];
    //            [self.tableView beginUpdates];
    //            [self.tableView deleteRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationMiddle];
    //            [self.tableView endUpdates];
    //        }
    //        else{
    //            NSLog(@"pusher 4");
    //            self.rowCount += 6;
    //            NSArray *paths = [[NSArray alloc] initWithObjects:
    //                              [NSIndexPath indexPathForRow:0 inSection:2],
    //                              [NSIndexPath indexPathForRow:1 inSection:2],
    //                              [NSIndexPath indexPathForRow:2 inSection:2],
    //                              [NSIndexPath indexPathForRow:3 inSection:2],
    //                              [NSIndexPath indexPathForRow:4 inSection:2],
    //                              [NSIndexPath indexPathForRow:5 inSection:2],
    //                              nil];
    //            [self.tableView beginUpdates];
    //            [self.tableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationMiddle];
    //            [self.tableView endUpdates];
    //            //EXPANDED_ON = 7;
    //        }
    //        OPENED = !OPENED;
    //    }
    //    if( row == 3 + EXPANDED_ON)
    //    {
    //        NSLog(@"pusher 5");
    //        if( [centerNavigationController.topViewController isKindOfClass:[thirdViewController class]] )
    //            [self.navigationController.slideViewController showMainViewControllerAnimated:YES];
    //        else
    //        {
    //            UIViewController * thirdViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ThirdViewController"];
    //            //[self.navigationController.slideViewController setMainViewController:thirdViewController];
    //            [self.navigationController.slideViewController setMainViewController:thirdViewController animated:YES];
    //        }
    //    }
    //    else if( row == 4 + EXPANDED_ON)
    //    {
    //        NSLog(@"pusher 6");
    //        if( [centerNavigationController.topViewController isKindOfClass:[fourthViewController class]] )
    //            [self.navigationController.slideViewController showMainViewControllerAnimated:YES];
    //        else
    //        {
    //            UIViewController * fourthViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FourthViewController"];
    //            //[self.navigationController.slideViewController setMainViewController:fourthViewController];
    //            [self.navigationController.slideViewController setMainViewController:fourthViewController animated:YES];
    //        }
    //    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.array count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 250;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *SimpleTableIdentifier = @"placesTableView";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: SimpleTableIdentifier];
    if (cell == nil) { cell = [[[UITableViewCell alloc]
                                initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleTableIdentifier] autorelease];
    }
    UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, 320, 250)];
    imv.image=[UIImage imageNamed:@"Icon.png"];
    [cell.contentView addSubview:imv];
    [imv release];
    
    return cell;
}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = nil;
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//
//    //    cell.backgroundView = [InterfaceFunctions CellBG];
//    //    cell.selectedBackgroundView = [InterfaceFunctions SelectedCellBG];
//    cell.textLabel.backgroundColor = [UIColor clearColor];
//    cell.textLabel.textColor = [UIColor whiteColor];
////    cell.textLabel.text = [self.expandArray objectAtIndex:[indexPath row]];
//    return cell;
//}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    UINavigationController * centerNavigationController = (UINavigationController *)self.navigationController.slideViewController.mainViewController;
    //    if( [centerNavigationController.topViewController isKindOfClass:[fifthViewController class]] )
    //        [self.navigationController.slideViewController showMainViewControllerAnimated:YES];
    //    else
    //    {
    //        UIViewController * fifthViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FifthViewController"];
    //        //[self.navigationController.slideViewController setMainViewController:fifthViewController];
    //        [self.navigationController.slideViewController setMainViewController:fifthViewController animated:YES];
    //    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



/* To emulate infinite scrolling...
 
 The table data was doubled to join the head and tail.
 When the user scrolls backwards to 1/8th of the new table, user is at the 1/4th of actual data, so we scroll to 5/8th of the new table where the cells are exactly the same.
 
 Similarly, when user scrolls to 6/8th of the table, we will scroll back to 3/8th where the cells are same.
 
 In simple words, when user reaches 1/4th of the first part of table, we scroll to 1/4th of the second part, when he reaches 3/4th of the second part of table, we scroll to the 3/4 of first part. This is done simply by subtracting OR adding half the length of the new table.
 
 (C) Anup Kattel, you can copy this code, please leave these comments if you don't mind.
 */


-(void)scrollViewDidScroll:(UIScrollView *)scrollView_
{
    [scrollView_ setDecelerationRate:UIScrollViewDecelerationRateFast];
    [scrollView_ setShowsHorizontalScrollIndicator:NO];
    [scrollView_ setShowsVerticalScrollIndicator:NO];
    CGFloat currentOffsetX = scrollView_.contentOffset.x;
    CGFloat currentOffSetY = scrollView_.contentOffset.y;
    CGFloat contentHeight = scrollView_.contentSize.height;
    
    if (currentOffSetY < (contentHeight / 8.0)) {
        scrollView_.contentOffset = CGPointMake(currentOffsetX,(currentOffSetY + (contentHeight/2)));
    }
    if (currentOffSetY > ((contentHeight * 6)/ 8.0)) {
        scrollView_.contentOffset = CGPointMake(currentOffsetX,(currentOffSetY - (contentHeight/2)));
    } 
}


@end
