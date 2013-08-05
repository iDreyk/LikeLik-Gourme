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
#import "modalViewController.h"
#import "favoritesViewController.h"


#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@implementation LeftViewController
@synthesize catalogueTableView;
@synthesize searchBar;
@synthesize navBar;
@synthesize displayItems;
static bool OPENED_CITY = NO;
static bool OPENED_LANG = NO;
static bool SEARCHING = NO;
static bool KEYBOARD_SHOWN = NO;
int EXPANDED_ON = 0;
CGRect tableViewFrame;

#pragma mark - Table view delegate

- (void)viewDidLoad{
#warning placesArray -- это все наши места. Заполянем массивы также, как и в newMainViewController
    if(!self.subwayArray)
        self.placesArray = @[@"1st place",@"2nd place",@"3rd place",@"4th place",@"5th place",@"6th place",@"7th place",@"8th place", @"9th place", @"10th place"];
    if(!self.subwayArray)
        self.subwayArray = @[AMLocalizedString(@"Arbatskaya", Nil), @"Tretyakovskaya", @"Puskinskaya", @"Aeroport", @"Komsomolskaya", @"Universitet", @"Dinamo", AMLocalizedString(@"Arbatskaya", Nil), @"Akademicheskaya", @"Leninskiy prospekt"];
    if(!self.paycheckArray)
        self.paycheckArray = @[@"1200", @"900", @"1700", @"1300", @"2000", @"1500", @"950", @"2100", @"3000", @"1900"];
    if(!self.workTimeArray)
        self.workTimeArray = @[@"10:00 - 23:00", @"12:00 - 23:00", @"9:00 - 21:00", @"10:00 - 24:00", @"9:00 - 03:00", @"10:00 - 22:00", @"11:00 - 00:00", @"10:00 - 01:00", @"8:00 - 20:00", @"11:00 - 23:00"];
    if(!self.rateArray)
        self.rateArray = @[@"2", @"3", @"1", @"4", @"4", @"5", @"4", @"2", @"3", @"4"];
    if(!self.imageArray)
        self.imageArray = @[@"http://asset0.cbsistatic.com/cnwk.1d/i/bto/20061228/under_water_restaurant_525x378.jpg",
                            @"http://www.limousine-hire-perth.com.au/C_Restaurant.jpg",
                            @"http://pittsburghrestaurantdirectory.com/wp-content/uploads/2012/04/restaurant-sample-pic2.jpg",
                            @"http://media-cdn.tripadvisor.com/media/photo-s/01/9d/ab/6e/restaurant-hort-de-popaire.jpg",
                            @"http://www.edelweiss-gurgl.co.uk/image/medium/en/restaurant-hotel-obergurgl-2.jpg",
                            @"https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQYjI6IbxVh95C7C8CqxgkcxJpDwhmlKIsRGRq9niTPOXh8ewnw",
                            @"https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcS9MwAxrgm6u2tekq9tSInzHOoTkgSec42sCPKE4-dZhgkBi_04",
                            @"https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQn5Sm4-R-wBXANsm0boFE-If4vd5tKbaHXGy2-AJVntPjnweg",
                            @"https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcSpknvVGQig_9mk0bG_UhHQsgVXx_Pb1GCQXas48gsWpxP04rWw",
                            @"https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcT9NCxtouHbM5RfTzIRX1SdUcfXrjvWY4sLHQ-NDLYN-ank7ImZjg"
                            ];

    if(!self.allPlaces)
        self.allPlaces = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.array, @"name", self.rateArray, @"rating", self.subwayArray, @"subway", self.paycheckArray, @"paycheck", self.workTimeArray, @"worktime", self.imageArray, @"image", nil];
    
    self.array =         @[[NSString stringWithFormat:@"   %@",AMLocalizedString(@"All places", Nil)],[NSString stringWithFormat:@"   %@",AMLocalizedString(@"Favorites", Nil)],[NSString stringWithFormat:@"   %@",AMLocalizedString(@"City", Nil)], [NSString stringWithFormat:@"   %@",AMLocalizedString(@"Language", Nil)],[NSString stringWithFormat:@"   %@",AMLocalizedString(@"Sort by name", Nil)],[NSString stringWithFormat:@"   %@",AMLocalizedString(@"Sort by distance", Nil)]];
    self.cityArray =[[NSMutableArray alloc] initWithArray:@[@"      Moscow", @"      Viena", @"      Ufa"]];
    self.languageArray = [[NSMutableArray alloc] initWithArray:@[@"      English", @"      Deutsch", @"      Русский", @"      Japanese"]];
    self.rowCountCity = 0;
    self.rowCountLang = 0;
    self.background.image = [UIImage imageNamed:@"640_1136 LaunchScreen-568h@2x.png"];
    
    CGRect picSize = self.view.frame;
    picSize.origin.y = 44;
    picSize.size.height = 460;
    picSize.size.width -= 52.0;
    self.background.frame = picSize;
    
    
    self.displayItems = [[NSMutableArray alloc] initWithArray:self.array];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideKeyboard:) name:@"callingMainView" object:nil];
    
    if(self.view.bounds.size.height == 460.0 || self.view.bounds.size.height == 548.0){
        CGRect newTWFrame = self.catalogueTableView.frame;
       // NSLog(@"%f %f %f %f",newTWFrame.origin.x, newTWFrame.origin.y, newTWFrame.size.height,newTWFrame.size.width);
        newTWFrame.origin.y = 40;
        self.catalogueTableView.frame = newTWFrame;
        
        newTWFrame = self.background.frame;
        //        NSLog(@"%f %f %f %f",newTWFrame.origin.x, newTWFrame.origin.y, newTWFrame.size.height,newTWFrame.size.width);
        newTWFrame.origin.y = 40;
        newTWFrame.size.height = self.view.bounds.size.height - 80;
        self.background.frame = newTWFrame;
        //self.background.frame = newTWFrame;
        newTWFrame = self.searchBar.frame;
        newTWFrame.size.height = 40;
        self.searchBar.frame = newTWFrame;
    }
    tableViewFrame = self.catalogueTableView.frame;
}

#pragma mark - Notifications
-(void)hideKeyboard:(NSNotification *)note{
    [self.searchBar setShowsCancelButton:NO];
    [self.searchBar resignFirstResponder];
    SEARCHING = NO;
    [self.catalogueTableView reloadData];
}

-(void)keyboardShown:(NSNotification *)note{
    if(!KEYBOARD_SHOWN){
        CGRect keyboardFrame;
        [[[note userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardFrame];
        CGRect ViewFrame = self.catalogueTableView.frame;
        ViewFrame.origin.y = 0;
        ViewFrame.size.height = self.view.frame.size.height;
        ViewFrame.size.height -= keyboardFrame.size.height;
        [UIView animateWithDuration:0.4 animations:^{
            CGRect frame = self.catalogueTableView.frame;
            frame.origin.y = -600;
            self.catalogueTableView.frame = frame;
        }completion:^(BOOL finished) {
            CGRect frame = self.catalogueTableView.frame;
            frame.origin.y = 600;
            self.catalogueTableView.frame = frame;
            [UIView animateWithDuration:0.3 animations:^{
                SEARCHING = YES;
                [self.displayItems removeAllObjects];
                [self.displayItems addObjectsFromArray:self.placesArray];
                [self.catalogueTableView reloadData];
                self.catalogueTableView.frame = ViewFrame;
            }];
        }];
        KEYBOARD_SHOWN = YES;
    }
}

-(void)keyboardHidden:(NSNotification *)note{
    [UIView animateWithDuration:0.4 animations:^{
        CGRect frame = self.catalogueTableView.frame;
        frame.origin.y = 600;
        self.catalogueTableView.frame = frame;
    }completion:^(BOOL finished) {
        CGRect frame = self.catalogueTableView.frame;
        frame.origin.y = -600;
        self.catalogueTableView.frame = frame;
        [UIView animateWithDuration:0.3 animations:^{
            SEARCHING = NO;
            [self.catalogueTableView reloadData];
            self.catalogueTableView.frame = tableViewFrame;
        }];
    }];
    KEYBOARD_SHOWN = NO;
//    CGRect frame = self.catalogueTableView.frame;
//    frame.origin.y = -600;
//    self.catalogueTableView.frame = frame;
//    [UIView animateWithDuration:0.4 animations:^{
//        self.catalogueTableView.frame = tableViewFrame;
//    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    navBar.title = AMLocalizedString(@"LikeLik Gourmet", Nil);
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(SEARCHING)
        return self.displayItems.count;
    if (section == 2)
        return self.rowCountCity;
    if (section == 3)
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
    if(!SEARCHING){
        if([NSUserDefaults standardUserDefaults]){
            NSLog(@"Loaded from userdefaults sort: %d (0 -- name, 1 -- distance)",[[NSUserDefaults standardUserDefaults] integerForKey:@"menuSortMethod"]);
            NSInteger sortMethod = [[NSUserDefaults standardUserDefaults] integerForKey:@"menuSortMethod"];
            if (!sortMethod && section == 4)
                button.backgroundColor = [UIColor grayColor];
            else if (sortMethod && section == 5)
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
    }
    return button;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(SEARCHING)
        return 1;
    return [self.array count];
}

#pragma mark - Add rows in sections of LeftMenu
-(void)closeCityMenu{
    self.rowCountCity -= 3;
    NSArray *paths = [[NSArray alloc] initWithObjects:
                      [NSIndexPath indexPathForRow:0 inSection:2],
                      [NSIndexPath indexPathForRow:1 inSection:2],
                      [NSIndexPath indexPathForRow:2 inSection:2],
                      nil];
    [self.catalogueTableView beginUpdates];
    [self.catalogueTableView deleteRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationMiddle];
    [self.catalogueTableView endUpdates];
    
}
-(void)openCityMenu{
    self.rowCountCity += 3;
    NSArray *paths = [[NSArray alloc] initWithObjects:
                      [NSIndexPath indexPathForRow:0 inSection:2],
                      [NSIndexPath indexPathForRow:1 inSection:2],
                      [NSIndexPath indexPathForRow:2 inSection:2],
                      nil];
    [self.catalogueTableView beginUpdates];
    [self.catalogueTableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationMiddle];
    [self.catalogueTableView endUpdates];
    
}

-(void)closeLangMenu{
    self.rowCountLang -= 3;
    NSArray *paths = [[NSArray alloc] initWithObjects:
                      [NSIndexPath indexPathForRow:0 inSection:3],
                      [NSIndexPath indexPathForRow:1 inSection:3],
                      [NSIndexPath indexPathForRow:2 inSection:3],
                      nil];
    [self.catalogueTableView beginUpdates];
    [self.catalogueTableView deleteRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationMiddle];
    [self.catalogueTableView endUpdates];
}

-(void)openLangMenu{
    self.rowCountLang += 3;
    NSArray *paths = [[NSArray alloc] initWithObjects:
                      [NSIndexPath indexPathForRow:0 inSection:3],
                      [NSIndexPath indexPathForRow:1 inSection:3],
                      [NSIndexPath indexPathForRow:2 inSection:3],
                      nil];
    [self.catalogueTableView beginUpdates];
    [self.catalogueTableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationMiddle];
    [self.catalogueTableView endUpdates];
}


-(void)pusher:(UIButton *)Sender{
    NSUInteger row = Sender.tag;
    
    UINavigationController * centerNavigationController = (UINavigationController *)self.navigationController.slideViewController.mainViewController;
    
        if(row == 0){
            NSLog(@"Call restaurants view");
            if( [centerNavigationController.topViewController isKindOfClass:[newMainViewController class]] ){
                [self.navigationController.slideViewController showMainViewControllerAnimated:YES];
            }
            else
            {
                UIViewController * newMainViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NewMainViewController"];
                //[self.navigationController.slideViewController setMainViewController:newMainViewController];
                [self.navigationController.slideViewController setMainViewController:newMainViewController animated:YES];
            }
    
        }
        else if ( row == 1){
            NSLog(@"Call favourites view");
            if( [centerNavigationController.topViewController isKindOfClass:[favoritesViewController class]] ){
                [self.navigationController.slideViewController showMainViewControllerAnimated:YES];
            }
            else
            {
                favoritesViewController * favoritesViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FavoritesViewController"];
                //[self.navigationController.slideViewController setMainViewController:newMainViewController];
                [self.navigationController.slideViewController setMainViewController:favoritesViewController animated:YES];
            }

        }
        else if( row == 2 ){
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
    else if( row == 3 ){
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
    else if(row == 4){
        for (UIView *subView in self.catalogueTableView.subviews){
            if (subView.tag == 4)
                subView.backgroundColor = [UIColor grayColor];
            if (subView.tag == 5)
                subView.backgroundColor = [UIColor clearColor];
        }
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"menuSortMethod"];
        NSLog(@"Saved to userdefaults sort: %d (0 -- name, 1 -- distance)",[[NSUserDefaults standardUserDefaults] integerForKey:@"menuSortMethod"]);
       // if( [centerNavigationController.topViewController isKindOfClass:[newMainViewController class]] )
            [self.navigationController.slideViewController showMainViewControllerAnimated:YES];
    }
    else if(row == 5){
        for (UIView *subView in self.catalogueTableView.subviews){
            if (subView.tag == 5)
                subView.backgroundColor = [UIColor grayColor];
            if (subView.tag == 4)
                subView.backgroundColor = [UIColor clearColor];
        }
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"menuSortMethod"];
        NSLog(@"Saved to userdefaults sort: %d (0 -- name, 1 -- distance)",[[NSUserDefaults standardUserDefaults] integerForKey:@"menuSortMethod"]);
       // if( [centerNavigationController.topViewController isKindOfClass:[newMainViewController class]] )
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
        if(SEARCHING)
            cell.textLabel.text = [self.displayItems objectAtIndex:[indexPath row]];
        else{
            if(indexPath.section == 2)
                cell.textLabel.text = [self.cityArray objectAtIndex:[indexPath row]];
            if(indexPath.section == 3)
                cell.textLabel.text = [self.languageArray objectAtIndex:[indexPath row]];
        }
        
        //    cell.backgroundView = [InterfaceFunctions CellBG];
        //    cell.selectedBackgroundView = [InterfaceFunctions SelectedCellBG];
        
        
        
        if([NSUserDefaults standardUserDefaults]){
            if(indexPath.section == 2){
                NSInteger section = [[NSUserDefaults standardUserDefaults] integerForKey:@"curentCitySection"];
                NSInteger row = [[NSUserDefaults standardUserDefaults] integerForKey:@"curentCityRow"];
                if (indexPath.section == section && indexPath.row == row){
                    NSIndexPath *savedCity = [NSIndexPath indexPathForRow:row inSection:section];
                    [self.catalogueTableView selectRowAtIndexPath:savedCity animated:YES scrollPosition:NO];
                    NSLog(@"Loaded city from userdefaults! %d %d",section, row);
                }
            }
            else if(indexPath.section == 3){
                NSInteger section = [[NSUserDefaults standardUserDefaults] integerForKey:@"curentLangSection"];
                NSInteger row = [[NSUserDefaults standardUserDefaults] integerForKey:@"curentLangRow"];
                if (indexPath.section == section && indexPath.row == row){
                    NSIndexPath *savedLang = [NSIndexPath indexPathForRow:row inSection:section];
                    [self.catalogueTableView selectRowAtIndexPath:savedLang animated:YES scrollPosition:NO];
                    NSLog(@"Loaded language from userdefaults! %d %d",section, row);
                }
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
    if(SEARCHING){
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        NSString *str = cell.textLabel.text;
        NSInteger ind = [self.placesArray indexOfObject:str];
        
        modalViewController *viewControllerToPresent = [self.storyboard instantiateViewControllerWithIdentifier:@"ModalViewController"];
        viewControllerToPresent.placeName = str;
        viewControllerToPresent.subway = [self.subwayArray objectAtIndex:ind];
        viewControllerToPresent.paycheck = [self.paycheckArray objectAtIndex:ind];
        viewControllerToPresent.worktime = [self.workTimeArray objectAtIndex:ind];
        viewControllerToPresent.rating = [self.rateArray objectAtIndex:ind];
        viewControllerToPresent.image = [self.imageArray objectAtIndex:ind];

        [self presentViewController:viewControllerToPresent animated:YES completion:^{}];
    }
    else{
        if(indexPath.section == 2){
            NSInteger indPthSect = [indexPath section];
            NSInteger indPthRow = [indexPath row];
            [[NSUserDefaults standardUserDefaults] setInteger:indPthSect forKey:@"curentCitySection"];
            [[NSUserDefaults standardUserDefaults] setInteger:indPthRow forKey:@"curentCityRow"];
            NSLog(@"Saved city to userdefaults! %d %d",indPthSect, indPthRow);
        }
        else if(indexPath.section == 3){
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
            navBar.title = AMLocalizedString(@"LikeLik Gourmet", Nil);
            self.array =         @[[NSString stringWithFormat:@"   %@",AMLocalizedString(@"All places", Nil)],[NSString stringWithFormat:@"   %@",AMLocalizedString(@"Favorites", Nil)],[NSString stringWithFormat:@"   %@",AMLocalizedString(@"City", Nil)], [NSString stringWithFormat:@"   %@",AMLocalizedString(@"Language", Nil)],[NSString stringWithFormat:@"   %@",AMLocalizedString(@"Sort by name", Nil)],[NSString stringWithFormat:@"   %@",AMLocalizedString(@"Sort by distance", Nil)]];
            [self.catalogueTableView  reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.array.count)] withRowAnimation:UITableViewRowAnimationFade];
            //[self.catalogueTableView reloadData];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LanguageChanged" object:nil];
        }
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
    if(!SEARCHING)
        SEARCHING = YES;
#warning Поиск подстроки (каждая буква) параметр -- NSString *searchText, а искать надо по местам в newMainViewController
    if(searchText.length == 0){
        [self.displayItems removeAllObjects];
        [self.displayItems addObjectsFromArray:self.placesArray];
    }
    else{
        [displayItems removeAllObjects];
        for(NSString *data in self.placesArray){
            NSRange r = [data rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if(r.location != NSNotFound){
                [self.displayItems addObject:data];
            }
        }
    }
    [self.catalogueTableView  reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    
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
    SEARCHING = NO;
//    [self.catalogueTableView reloadData];
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


