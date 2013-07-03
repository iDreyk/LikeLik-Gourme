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
@synthesize searchBar;
static bool OPENED_CITY = NO;
static bool OPENED_LANG = NO;
int EXPANDED_ON = 0;

#pragma mark - Table view delegate

- (void)viewDidLoad{
    
    self.array =         [[NSArray alloc] initWithArray:@[@"  Restaurants", @"  City", @"  Language"/*, @"  Favourites",@"  Transportation",@"  Practical info",@"  Settings"*/]];
    self.cityArray =[[NSMutableArray alloc] initWithArray:@[@"      Moscow", @"      Viena", @"      Ufa"]];
    self.languageArray = [[NSMutableArray alloc] initWithArray:@[@"      English", @"      Germany", @"      Russian", @"      Japanese"]];
    self.rowCountCity = 0;
    self.rowCountLang = 0;
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1)
        return self.rowCountCity;
    if (section == 2)
        return self.rowCountLang;
    //return [self.array count];
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor blackColor];
   // [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    button.frame = CGRectMake(10, 20, 200, 50); // position in the parent view and set the size of the button
    [button setTitle:[self.array objectAtIndex:section] forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    // add targets and actions
    [button addTarget:self action:@selector(pusher:) forControlEvents:UIControlEventTouchUpInside];
    [button setTag:section];
    return button;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.array count];
}

#pragma mark - Add rows in sections of LeftMenu
-(void)closeCityMenu{
    self.rowCountCity -= 3;
    NSArray *paths = [[NSArray alloc] initWithObjects:
                      [NSIndexPath indexPathForRow:0 inSection:1],
                      [NSIndexPath indexPathForRow:1 inSection:1],
                      [NSIndexPath indexPathForRow:2 inSection:1],
                      nil];
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationMiddle];
    [self.tableView endUpdates];

}
-(void)openCityMenu{
    self.rowCountCity += 3;
    NSArray *paths = [[NSArray alloc] initWithObjects:
                      [NSIndexPath indexPathForRow:0 inSection:1],
                      [NSIndexPath indexPathForRow:1 inSection:1],
                      [NSIndexPath indexPathForRow:2 inSection:1],
                      nil];
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationMiddle];
    [self.tableView endUpdates];

}

-(void)closeLangMenu{
    self.rowCountLang -= 3;
    NSArray *paths = [[NSArray alloc] initWithObjects:
                      [NSIndexPath indexPathForRow:0 inSection:2],
                      [NSIndexPath indexPathForRow:1 inSection:2],
                      [NSIndexPath indexPathForRow:2 inSection:2],
                      nil];
    [self.tableView beginUpdates];
    [self.tableView deleteRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationMiddle];
    [self.tableView endUpdates];
}

-(void)openLangMenu{
    self.rowCountLang += 3;
    NSArray *paths = [[NSArray alloc] initWithObjects:
                      [NSIndexPath indexPathForRow:0 inSection:2],
                      [NSIndexPath indexPathForRow:1 inSection:2],
                      [NSIndexPath indexPathForRow:2 inSection:2],
                      nil];
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationMiddle];
    [self.tableView endUpdates];
}


-(void)pusher:(UIButton *)Sender{
    NSUInteger row = Sender.tag;
    
    UINavigationController * centerNavigationController = (UINavigationController *)self.navigationController.slideViewController.mainViewController;
    
    if(row == 0){
        NSLog(@"Call restaurants view");
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
        NSLog(@"Call change city view");
//        if( [centerNavigationController.topViewController isKindOfClass:[fourthViewController class]] )
//            [self.navigationController.slideViewController showMainViewControllerAnimated:YES];
//        else
//        {
//            UIViewController * settingsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FourthViewController"];
//            //[self.navigationController.slideViewController setMainViewController:newMainViewController];
//            [self.navigationController.slideViewController setMainViewController:settingsViewController animated:YES];
//        }
        if(OPENED_LANG == YES){
            [self closeLangMenu];
            OPENED_LANG = NO;
        }
        if (OPENED_CITY == YES)
            [self closeCityMenu];
        else
            [self openCityMenu];
        OPENED_CITY = !OPENED_CITY;
        
    }
    else if( row == 2 ){
        NSLog(@"Call settings view");
        if(OPENED_CITY == YES){
            [self closeCityMenu];
            OPENED_CITY = NO;
        }
        if (OPENED_LANG == YES)
            [self closeLangMenu];
        else
            [self openLangMenu];
        OPENED_LANG = !OPENED_LANG;
        
//        if( [centerNavigationController.topViewController isKindOfClass:[thirdViewController class]] )
//            [self.navigationController.slideViewController showMainViewControllerAnimated:YES];
//        else
//        {
//            UIViewController * selectCityViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ThirdViewController"];
//            //[self.navigationController.slideViewController setMainViewController:newMainViewController];
//            [self.navigationController.slideViewController setMainViewController:selectCityViewController animated:YES];
//        }

//        if (OPENED_CITY == YES){
//                    NSLog(@"pusher 3");
//           // EXPANDED_ON = 0;
//            self.rowCountCity -= 6;
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
//                    NSLog(@"pusher 4");
//            self.rowCountCity += 6;
//            NSArray *paths = [[NSArray alloc] initWithObjects:
//                                         [NSIndexPath indexPathForRow:0 inSection:2],
//                                         [NSIndexPath indexPathForRow:1 inSection:2],
//                                         [NSIndexPath indexPathForRow:2 inSection:2],
//                                         [NSIndexPath indexPathForRow:3 inSection:2],
//                                         [NSIndexPath indexPathForRow:4 inSection:2],
//                                         [NSIndexPath indexPathForRow:5 inSection:2],
//                                         nil];
//            [self.tableView beginUpdates];
//            [self.tableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationMiddle];
//            [self.tableView endUpdates];
//            //EXPANDED_ON = 7;
//        }
//        OPENED_CITY = !OPENED_CITY;
    }
//    if( row == 3 + EXPANDED_ON)
//    {
//                NSLog(@"pusher 5");
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
//                NSLog(@"pusher 6");
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


#pragma mark - Cell and sections settings


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = nil;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = [UIColor blackColor];
        cell.textLabel.textColor = [UIColor whiteColor];
        if(indexPath.section == 1)
            cell.textLabel.text = [self.cityArray objectAtIndex:[indexPath row]];
        if(indexPath.section == 2)
            cell.textLabel.text = [self.languageArray objectAtIndex:[indexPath row]];
    }
    
//    cell.backgroundView = [InterfaceFunctions CellBG];
//    cell.selectedBackgroundView = [InterfaceFunctions SelectedCellBG];
   

    
    if([NSUserDefaults standardUserDefaults]){
        if(indexPath.section == 1){
            NSInteger section = [[NSUserDefaults standardUserDefaults] integerForKey:@"curentCitySection"];
            NSInteger row = [[NSUserDefaults standardUserDefaults] integerForKey:@"curentCityRow"];
            if (indexPath.section == section && indexPath.row == row){
                NSIndexPath *savedCity = [NSIndexPath indexPathForRow:row inSection:section];
                [self.tableView selectRowAtIndexPath:savedCity animated:YES scrollPosition:NO];
                NSLog(@"Loaded city from userdefaults! %d %d",section, row);
            }
        }
        else if(indexPath.section == 2){
            NSInteger section = [[NSUserDefaults standardUserDefaults] integerForKey:@"curentLangSection"];
            NSInteger row = [[NSUserDefaults standardUserDefaults] integerForKey:@"curentLangRow"];
            if (indexPath.section == section && indexPath.row == row){
                NSIndexPath *savedLang = [NSIndexPath indexPathForRow:row inSection:section];
                [self.tableView selectRowAtIndexPath:savedLang animated:YES scrollPosition:NO];
                NSLog(@"Loaded language from userdefaults! %d %d",section, row);
            }
        }
    }

    return cell;
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

//UINavigationController * centerNavigationController = (UINavigationController *)self.navigationController.slideViewController.mainViewController;
//    if( [centerNavigationController.topViewController isKindOfClass:[fifthViewController class]] )
//        [self.navigationController.slideViewController showMainViewControllerAnimated:YES];
//    else
//    {
//        UIViewController * fifthViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FifthViewController"];
//        //[self.navigationController.slideViewController setMainViewController:fifthViewController];
//        [self.navigationController.slideViewController setMainViewController:fifthViewController animated:YES];
//    }
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.section == 1){
        NSInteger indPthSect = [indexPath section];
        NSInteger indPthRow = [indexPath row];
        [[NSUserDefaults standardUserDefaults] setInteger:indPthSect forKey:@"curentCitySection"];
        [[NSUserDefaults standardUserDefaults] setInteger:indPthRow forKey:@"curentCityRow"];
        NSLog(@"Saved city to userdefaults! %d %d",indPthSect, indPthRow);
    }
    else if(indexPath.section == 2){
        NSInteger indPthSect = [indexPath section];
        NSInteger indPthRow = [indexPath row];
        [[NSUserDefaults standardUserDefaults] setInteger:indPthSect forKey:@"curentLangSection"];
        [[NSUserDefaults standardUserDefaults] setInteger:indPthRow forKey:@"curentLangRow"];
        NSLog(@"Saved language to userdefaults! %d %d",indPthSect, indPthRow);

    }
}

//- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
//    [self handleSearch:searchBar];
//}
//
//- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
//    [self handleSearch:searchBar];
//}

//- (void)handleSearch:(UISearchBar *)searchBar {
//    NSLog(@"User searched for %@", searchBar.text);
//    [searchBar resignFirstResponder]; // if you want the keyboard to go away
//}
//
//- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar {
//    NSLog(@"User canceled search");
//    [searchBar resignFirstResponder]; // if you want the keyboard to go away
//}

@end


