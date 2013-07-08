//
//  LeftViewController.m
//  MKDSlideViewController
//
//  Created by Ilya Tsarev on 20.05.13.
//
//

#import "LeftViewController.h"
#import "MKDSlideViewController.h"
#import "UIViewController+MKDSlideViewController.h"
#import "newMainViewController.h"


#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@implementation LeftViewController
@synthesize catalogueTableView;
@synthesize searchBar;
@synthesize navBar;
static bool OPENED_CITY = NO;
static bool OPENED_LANG = NO;
int EXPANDED_ON = 0;

#pragma mark - Table view delegate

- (void)viewDidLoad{
    
    self.array =         @[ [NSString stringWithFormat:@"  %@",AMLocalizedString(@"City", Nil)], [NSString stringWithFormat:@"  %@",AMLocalizedString(@"Language", Nil)],[NSString stringWithFormat:@"  %@",AMLocalizedString(@"Sort by name", Nil)],[NSString stringWithFormat:@"  %@",AMLocalizedString(@"Sort by distance", Nil)]];
    self.cityArray =[[NSMutableArray alloc] initWithArray:@[@"      Moscow", @"      Viena", @"      Ufa"]];
    self.languageArray = [[NSMutableArray alloc] initWithArray:@[@"      English", @"      Deutsch", @"      Русский", @"      Japanese"]];
    self.rowCountCity = 0;
    self.rowCountLang = 0;
    self.background.image = [UIImage imageNamed:@"640_1136 LaunchScreen-568h@2x.png"];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    navBar.topItem.title = AMLocalizedString(@"LikeLik Gourmet", Nil);
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return self.rowCountCity;
    if (section == 1)
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
    button.backgroundColor = [UIColor clearColor];
    if([NSUserDefaults standardUserDefaults]){
        NSLog(@"Loaded from userdefaults sort: %d (0 -- name, 1 -- distance)",[[NSUserDefaults standardUserDefaults] integerForKey:@"menuSortMethod"]);
        NSInteger sortMethod = [[NSUserDefaults standardUserDefaults] integerForKey:@"menuSortMethod"];
        if (!sortMethod && section == 2)
            button.backgroundColor = [UIColor grayColor];
        else if (sortMethod && section == 3)
            button.backgroundColor = [UIColor grayColor];
    }
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    button.frame = CGRectMake(10, 20, 200, 50); // position in the parent view and set the size of the button
    [button setTitle:[self.array objectAtIndex:section] forState:UIControlStateNormal];
    //[button titleLabel].textColor = [UIColor blackColor];
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
                      [NSIndexPath indexPathForRow:0 inSection:0],
                      [NSIndexPath indexPathForRow:1 inSection:0],
                      [NSIndexPath indexPathForRow:2 inSection:0],
                      nil];
    [self.catalogueTableView beginUpdates];
    [self.catalogueTableView deleteRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationMiddle];
    [self.catalogueTableView endUpdates];

}
-(void)openCityMenu{
    self.rowCountCity += 3;
    NSArray *paths = [[NSArray alloc] initWithObjects:
                      [NSIndexPath indexPathForRow:0 inSection:0],
                      [NSIndexPath indexPathForRow:1 inSection:0],
                      [NSIndexPath indexPathForRow:2 inSection:0],
                      nil];
    [self.catalogueTableView beginUpdates];
    [self.catalogueTableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationMiddle];
    [self.catalogueTableView endUpdates];

}

-(void)closeLangMenu{
    self.rowCountLang -= 3;
    NSArray *paths = [[NSArray alloc] initWithObjects:
                      [NSIndexPath indexPathForRow:0 inSection:1],
                      [NSIndexPath indexPathForRow:1 inSection:1],
                      [NSIndexPath indexPathForRow:2 inSection:1],
                      nil];
    [self.catalogueTableView beginUpdates];
    [self.catalogueTableView deleteRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationMiddle];
    [self.catalogueTableView endUpdates];
}

-(void)openLangMenu{
    self.rowCountLang += 3;
    NSArray *paths = [[NSArray alloc] initWithObjects:
                      [NSIndexPath indexPathForRow:0 inSection:1],
                      [NSIndexPath indexPathForRow:1 inSection:1],
                      [NSIndexPath indexPathForRow:2 inSection:1],
                      nil];
    [self.catalogueTableView beginUpdates];
    [self.catalogueTableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationMiddle];
    [self.catalogueTableView endUpdates];
}


-(void)pusher:(UIButton *)Sender{
    NSUInteger row = Sender.tag;
    
    UINavigationController * centerNavigationController = (UINavigationController *)self.navigationController.slideViewController.mainViewController;
    
//    if(row == 0){
//        NSLog(@"Call restaurants view");
//        if( [centerNavigationController.topViewController isKindOfClass:[newMainViewController class]] ){
//            [self.navigationController.slideViewController showMainViewControllerAnimated:YES];
//            NSLog(@"Here1");
//        }
//        else
//        {
//            NSLog(@"Here2");
//            UIViewController * newMainViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NewMainViewController"];
//            //[self.navigationController.slideViewController setMainViewController:newMainViewController];
//            [self.navigationController.slideViewController setMainViewController:newMainViewController animated:YES];
//        }
//
//    }
//    else
    if( row == 0 )
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
    else if( row == 1 ){
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
    }
    else if(row == 2){
        for (UIView *subView in self.catalogueTableView.subviews){
            if (subView.tag == 2)
                subView.backgroundColor = [UIColor grayColor];
            if (subView.tag == 3)
                subView.backgroundColor = [UIColor clearColor];
        }
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"menuSortMethod"];
        NSLog(@"Saved to userdefaults sort: %d (0 -- name, 1 -- distance)",[[NSUserDefaults standardUserDefaults] integerForKey:@"menuSortMethod"]);
        if( [centerNavigationController.topViewController isKindOfClass:[newMainViewController class]] )
            [self.navigationController.slideViewController showMainViewControllerAnimated:YES];
    }
    else if(row == 3){
        for (UIView *subView in self.catalogueTableView.subviews){
            if (subView.tag == 3)
                subView.backgroundColor = [UIColor grayColor];
            if (subView.tag == 2)
                subView.backgroundColor = [UIColor clearColor];
        }
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"menuSortMethod"];
        NSLog(@"Saved to userdefaults sort: %d (0 -- name, 1 -- distance)",[[NSUserDefaults standardUserDefaults] integerForKey:@"menuSortMethod"]);
        if( [centerNavigationController.topViewController isKindOfClass:[newMainViewController class]] )
            [self.navigationController.slideViewController showMainViewControllerAnimated:YES];
    }
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
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor blackColor];
        if(indexPath.section == 0)
            cell.textLabel.text = [self.cityArray objectAtIndex:[indexPath row]];
        if(indexPath.section == 1)
            cell.textLabel.text = [self.languageArray objectAtIndex:[indexPath row]];
    }
    
//    cell.backgroundView = [InterfaceFunctions CellBG];
//    cell.selectedBackgroundView = [InterfaceFunctions SelectedCellBG];
   

    
    if([NSUserDefaults standardUserDefaults]){
        if(indexPath.section == 0){
            NSInteger section = [[NSUserDefaults standardUserDefaults] integerForKey:@"curentCitySection"];
            NSInteger row = [[NSUserDefaults standardUserDefaults] integerForKey:@"curentCityRow"];
            if (indexPath.section == section && indexPath.row == row){
                NSIndexPath *savedCity = [NSIndexPath indexPathForRow:row inSection:section];
                [self.catalogueTableView selectRowAtIndexPath:savedCity animated:YES scrollPosition:NO];
                NSLog(@"Loaded city from userdefaults! %d %d",section, row);
            }
        }
        else if(indexPath.section == 1){
            NSInteger section = [[NSUserDefaults standardUserDefaults] integerForKey:@"curentLangSection"];
            NSInteger row = [[NSUserDefaults standardUserDefaults] integerForKey:@"curentLangRow"];
            if (indexPath.section == section && indexPath.row == row){
                NSIndexPath *savedLang = [NSIndexPath indexPathForRow:row inSection:section];
                [self.catalogueTableView selectRowAtIndexPath:savedLang animated:YES scrollPosition:NO];
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
    if(indexPath.section == 0){
        NSInteger indPthSect = [indexPath section];
        NSInteger indPthRow = [indexPath row];
        [[NSUserDefaults standardUserDefaults] setInteger:indPthSect forKey:@"curentCitySection"];
        [[NSUserDefaults standardUserDefaults] setInteger:indPthRow forKey:@"curentCityRow"];
        NSLog(@"Saved city to userdefaults! %d %d",indPthSect, indPthRow);
    }
    else if(indexPath.section == 1){
        NSInteger indPthSect = [indexPath section];
        NSInteger indPthRow = [indexPath row];
        [[NSUserDefaults standardUserDefaults] setInteger:indPthSect forKey:@"curentLangSection"];
        [[NSUserDefaults standardUserDefaults] setInteger:indPthRow forKey:@"curentLangRow"];
        NSLog(@"Saved language to userdefaults! %d %d",indPthSect, indPthRow);
        NSString *curLang;
        if (indPthRow == 0){
            curLang = @"English";
            LocalizationSetLanguage(@"en");
            NSLog(@"EN");
        }
        if (indPthRow == 1){
            curLang = @"Deutsch";
            LocalizationSetLanguage(@"de");
            NSLog(@"DE");
        }
        if (indPthRow == 2){
            curLang = @"Русский";
            LocalizationSetLanguage(@"ru");
            NSLog(@"RU");
        }
        [[NSUserDefaults standardUserDefaults] setValue:curLang forKey:@"Language"];
        NSLog(@"Saved language to userdefaults: %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"Language"]);
        navBar.topItem.title = AMLocalizedString(@"LikeLik Gourmet", Nil);
        self.array =         @[[NSString stringWithFormat:@"  %@",AMLocalizedString(@"City", Nil)], [NSString stringWithFormat:@"  %@",AMLocalizedString(@"Language", Nil)],[NSString stringWithFormat:@"  %@",AMLocalizedString(@"Sort by name", Nil)],[NSString stringWithFormat:@"  %@",AMLocalizedString(@"Sort by distance", Nil)]];
        [self.catalogueTableView reloadData];
    }
}


#pragma mark - Searchbar handle


- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    return YES;
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
//    if (SYSTEM_VERSION_LESS_THAN(@"6.0"))
//        [self.SearchTable setFrame:CGRectMake(self.SearchTable.frame.origin.x, self.SearchTable.frame.origin.y-44.0, 320.0, self.SearchTable.frame.size.height+44.0)];
    [self.searchBar setShowsCancelButton:YES];
    self.searchBar.text = nil;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSLog(@"SEARCH LOG: searched for: %@", searchText);

#warning Поиск подстроки (каждая буква) параметр -- NSString *searchText, а искать надо по местам в newMainViewController 
//    NSArray *tmp;
//    if (self.searchBar.text.length > 0){//.text.length>0) {
//        NSString *strSearchText = self.searchBar.text;
//        NSLog(@"strSearchText = %@",strSearchText);
//        //#warning надо переделать под новый каталог
//        tmp = [ExternalFunctions getAllPlacesInCity:self.CityName];
//        //#warning backspace неправильно работает
//        NSMutableArray *ar = [NSMutableArray array];
//        for (int i=0;i<[tmp count];i++) {
//            NSString *strData = [[tmp objectAtIndex:i] objectForKey:@"Name"];
//            //          NSLog(@"strData = %@ strSearchText = %@",strData, strSearchText);
//            if ([[strData lowercaseString] rangeOfString:[strSearchText lowercaseString]].length>0)
//                [ar addObject:[tmp objectAtIndex:i]];
//        }
//        self.PlacesArray = ar;
//        [self.SearchTable reloadData];
//    }
//    else{
//        //    NSLog(@"Hello");
//        //#warning надо переделать под новый каталог
//        self.PlacesArray = [ExternalFunctions getAllPlacesInCity:self.CityName];
//        NSLog(@"tmp = %@", tmp);
//        [self.SearchTable reloadData];
//    }
}
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    //if (SYSTEM_VERSION_LESS_THAN(@"6.0"))
      // [self.SearchTable setFrame:CGRectMake(self.SearchTable.frame.origin.x, self.SearchTable.frame.origin.y+44.0, 320.0, self.SearchTable.frame.size.height-44.0)];
    
   // self.PlacesArray = Array;
    //[self.SearchTable reloadData];
    [self.searchBar setShowsCancelButton:NO];
    [self.searchBar resignFirstResponder];
    
}



- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    //    nslog(@"SearchClicked");
    [self.searchBar setShowsCancelButton:NO];
    [self.searchBar resignFirstResponder];
    
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


