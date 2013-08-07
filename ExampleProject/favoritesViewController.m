//
//  favoritesViewController.m
//  LikeLik Gourmet
//
//  Created by Ilya on 11.07.13.
//
//

#import "favoritesViewController.h"

#import "MKDSlideViewController.h"
#import "UIViewController+MKDSlideViewController.h"
#import "modalViewController.h"

@implementation favoritesViewController
@synthesize placesTableView;
@synthesize navBar;
static bool MAP_PRESENTED = false;
NSInteger PREVIOUS_SECTION = 0;
NSInteger PREV_NUM_OF_PLACES = 0;
NSInteger SELECTED_SECTION;
static bool REVERSE_ANIM = false;


- (IBAction)showLeftMenu:(id)sender
{
    // Use the UIViewController (MKDSlideViewController) category as a helper
    [self.navigationController.slideViewController callLeftMenu];
}
- (IBAction)showRightMenu:(id)sender{
    [self.navigationController.slideViewController callRightMenu];
}

#pragma mark - Table view delegate

#warning Ф-ия фильтрация списка!

- (void)viewDidLoad{
    if(self.view.bounds.size.height == 460.0 || self.view.bounds.size.height == 548.0){
        self._mapView.frame = CGRectMake(0, -44.0, 320.0, 170.0);
        CGRect newTWFrame = self.placesTableView.frame;
        newTWFrame.size.height = self.view.bounds.size.height - newTWFrame.origin.y;
        self.placesTableView.frame = newTWFrame;
    }
    
#warning Ф-ии загрузки данных с сервера во все массивы + куда-то грузить фотки
#warning все заполнять
    //    if(!self.array)
    //        self.array = @[[NSString stringWithFormat:@" %@",@"1st place"],[NSString stringWithFormat:@" %@",@" 2nd place"],[NSString stringWithFormat:@" %@",@"3rd place"],[NSString stringWithFormat:@" %@",@"4th place"],[NSString stringWithFormat:@" %@",@"5th place"],[NSString stringWithFormat:@" %@",@"6th place"],[NSString stringWithFormat:@" %@",@"7th place"],[NSString stringWithFormat:@" %@",@"8th place"], [NSString stringWithFormat:@" %@",@"9th place"], [NSString stringWithFormat:@" %@",@"10th place"]];
    //    if(!self.rateArray)
    //        self.rateArray = @[@"2", @"3", @"1", @"4", @"4", @"5", @"4", @"2", @"3", @"4"];
    //    if(!self.subwayArray)
    //        self.subwayArray = @[AMLocalizedString(@"Arbatskaya", Nil), @"Tretyakovskaya", @"Puskinskaya", @"Aeroport", @"Komsomolskaya", @"Universitet", @"Dinamo", AMLocalizedString(@"Arbatskaya", Nil), @"Akademicheskaya", @"Leninskiy prospekt"];
    //    if(!self.paycheckArray)
    //        self.paycheckArray = @[@"1200", @"900", @"1700", @"1300", @"2000", @"1500", @"950", @"2100", @"3000", @"1900"];
    //    if(!self.workTimeArray)
    //        self.workTimeArray = @[@"10:00 - 23:00", @"12:00 - 23:00", @"9:00 - 21:00", @"10:00 - 24:00", @"9:00 - 03:00", @"10:00 - 22:00", @"11:00 - 00:00", @"10:00 - 01:00", @"8:00 - 20:00", @"11:00 - 23:00"];
    //    if(!self.imageArray)
    //        self.imageArray = @[@"http://asset0.cbsistatic.com/cnwk.1d/i/bto/20061228/under_water_restaurant_525x378.jpg",
    //                            @"http://www.limousine-hire-perth.com.au/C_Restaurant.jpg",
    //                            @"http://pittsburghrestaurantdirectory.com/wp-content/uploads/2012/04/restaurant-sample-pic2.jpg",
    //                            @"http://media-cdn.tripadvisor.com/media/photo-s/01/9d/ab/6e/restaurant-hort-de-popaire.jpg",
    //                            @"http://www.edelweiss-gurgl.co.uk/image/medium/en/restaurant-hotel-obergurgl-2.jpg",
    //                            @"https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQYjI6IbxVh95C7C8CqxgkcxJpDwhmlKIsRGRq9niTPOXh8ewnw",
    //                            @"https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcS9MwAxrgm6u2tekq9tSInzHOoTkgSec42sCPKE4-dZhgkBi_04",
    //                            @"https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQn5Sm4-R-wBXANsm0boFE-If4vd5tKbaHXGy2-AJVntPjnweg",
    //                            @"https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcSpknvVGQig_9mk0bG_UhHQsgVXx_Pb1GCQXas48gsWpxP04rWw",
    //                            @"https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcT9NCxtouHbM5RfTzIRX1SdUcfXrjvWY4sLHQ-NDLYN-ank7ImZjg"
    //                            ];
    //    if(!self.allPlaces)
    //        self.allPlaces = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.array, @"name", self.rateArray, @"rating", self.subwayArray, @"subway", self.paycheckArray, @"paycheck", self.workTimeArray, @"worktime", self.imageArray, @"image", nil];
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"favoritePlaces"]){
        self.array = [[NSMutableArray alloc] init];
        self.rateArray = [[NSMutableArray alloc] init];
        self.subwayArray = [[NSMutableArray alloc] init];
        self.paycheckArray = [[NSMutableArray alloc] init];
        self.workTimeArray = [[NSMutableArray alloc] init];
        self.imageArray = [[NSMutableArray alloc] init];
        NSMutableDictionary *favorite = [[NSUserDefaults standardUserDefaults] objectForKey:@"favoritePlaces"];
        for(id key in favorite) {
            [self.array addObject:[NSString stringWithFormat:@"%@", [[favorite objectForKey:key] objectForKey:@"name"]]];
            [self.rateArray addObject:[NSString stringWithFormat:@"%@", [[favorite objectForKey:key] objectForKey:@"rating"]]];
            [self.subwayArray addObject:[NSString stringWithFormat:@"%@", [[favorite objectForKey:key] objectForKey:@"subway"]]];
            [self.paycheckArray addObject:[NSString stringWithFormat:@"%@", [[favorite objectForKey:key] objectForKey:@"paycheck"]]];
            [self.workTimeArray addObject:[NSString stringWithFormat:@"%@", [[favorite objectForKey:key] objectForKey:@"worktime"]]];
            [self.imageArray addObject:[NSString stringWithFormat:@"%@", [[favorite objectForKey:key] objectForKey:@"image"]]];
        }
        self.allPlaces = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.array, @"name", self.rateArray, @"rating", self.subwayArray, @"subway", self.paycheckArray, @"paycheck", self.workTimeArray, @"worktime", self.imageArray, @"image", nil];
       // NSLog(@"PLACES IN FAV: %@",self.allPlaces);
        PREV_NUM_OF_PLACES = self.array.count;
    }
    if(!self.imageCache)
        self.imageCache = [[NSMutableDictionary alloc] init];
    navBar.title = AMLocalizedString(@"Favorites", Nil);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appToBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appReturnsActive) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(languageChanged) name:@"LanguageChanged" object:nil];
}

#pragma mark - NSNotification handlers
-(void)languageChanged{
    //    self.subwayArray = @[AMLocalizedString(@"Arbatskaya", Nil), @"Tretyakovskaya", @"Puskinskaya", @"Aeroport", @"Komsomolskaya", @"Universitet", @"Dinamo", AMLocalizedString(@"Arbatskaya", Nil), @"Akademicheskaya", @"Leninskiy prospekt"];
    //    self.allPlaces = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.array, @"name", self.rateArray, @"rating", self.subwayArray, @"subway", self.paycheckArray, @"paycheck", self.workTimeArray, @"worktime", self.imageArray, @"image", nil];
    //    if([[NSUserDefaults standardUserDefaults] objectForKey:@"favoritePlaces"]){
    //        NSMutableDictionary *favorite = [[NSUserDefaults standardUserDefaults] objectForKey:@"favoritePlaces"];
    //        for(id key in favorite) {
    //            NSString *str = [[favorite objectForKey:key] objectForKey:@"subway"];
    //            [self.subwayArray addObject:AMLocalizedString(str, Nil)];
    //        }
    //        self.allPlaces = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.array, @"name", self.rateArray, @"rating", self.subwayArray, @"subway", self.paycheckArray, @"paycheck", self.workTimeArray, @"worktime", self.imageArray, @"image", nil];    [self.placesTableView reloadData];
    //    }
    navBar.title = AMLocalizedString(@"Favorites", Nil);
    [self.placesTableView reloadData];
}

#pragma mark - Map handler

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidLoad];
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"favoritePlaces"]){
        [self.array removeAllObjects];
        [self.rateArray removeAllObjects];
        [self.subwayArray removeAllObjects];
        [self.paycheckArray removeAllObjects];
        [self.workTimeArray removeAllObjects];
        [self.imageArray removeAllObjects];
        NSMutableDictionary *favorite = [[NSUserDefaults standardUserDefaults] objectForKey:@"favoritePlaces"];
        for(id key in favorite) {
            [self.array addObject:[NSString stringWithFormat:@"%@", [[favorite objectForKey:key] objectForKey:@"name"]]];
            [self.rateArray addObject:[NSString stringWithFormat:@"%@", [[favorite objectForKey:key] objectForKey:@"rating"]]];
            [self.subwayArray addObject:[NSString stringWithFormat:@"%@", [[favorite objectForKey:key] objectForKey:@"subway"]]];
            [self.paycheckArray addObject:[NSString stringWithFormat:@"%@", [[favorite objectForKey:key] objectForKey:@"paycheck"]]];
            [self.workTimeArray addObject:[NSString stringWithFormat:@"%@", [[favorite objectForKey:key] objectForKey:@"worktime"]]];
            [self.imageArray addObject:[NSString stringWithFormat:@"%@", [[favorite objectForKey:key] objectForKey:@"image"]]];
        }
        self.allPlaces = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.array, @"name", self.rateArray, @"rating", self.subwayArray, @"subway", self.paycheckArray, @"paycheck", self.workTimeArray, @"worktime", self.imageArray, @"image", nil];
    }
    if(PREV_NUM_OF_PLACES > self.array.count){
        [self.placesTableView beginUpdates];
        [self.placesTableView deleteSections:[NSIndexSet indexSetWithIndex:SELECTED_SECTION] withRowAnimation:UITableViewRowAnimationFade];
        [self.placesTableView endUpdates];
        [self.placesTableView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.array.count)] withRowAnimation:UITableViewRowAnimationNone];
        PREV_NUM_OF_PLACES = self.array.count;
    }
    else if(PREV_NUM_OF_PLACES < self.array.count){
        [self.placesTableView beginUpdates];
        [self.placesTableView insertSections:[NSIndexSet indexSetWithIndex:PREV_NUM_OF_PLACES] withRowAnimation:UITableViewRowAnimationFade];
        [self.placesTableView endUpdates];
        [self.placesTableView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.array.count)] withRowAnimation:UITableViewRowAnimationNone];
        PREV_NUM_OF_PLACES = self.array.count;
    }

    
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self action:@selector(openMap:)];
    tgr.numberOfTapsRequired = 1;
    tgr.numberOfTouchesRequired = 1;
    [self._mapView addGestureRecognizer:tgr];
    self._mapView.frame = CGRectMake(0, -44.0, 320.0, 140.0);
    
}

- (void)appToBackground{
    NSLog(@"MAP LOG: app to background");
    [self._mapView setShowsUserLocation:NO];
}
- (void)appReturnsActive{
    NSLog(@"MAP LOG: app returns active");
    [self._mapView setShowsUserLocation:YES];
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    if(!MAP_PRESENTED){
        //    NSLog(@"MAP LOG: update");
        MKCoordinateRegion region;
        MKCoordinateSpan span;
        span.latitudeDelta = 0.005;
        span.longitudeDelta = 0.005;
        CLLocationCoordinate2D location = self._mapView.userLocation.coordinate;
        //    NSLog(@"MAP LOG: coordinates: %f, %f", location.latitude, location.longitude);
        region.span = span;
        region.center = location;
        [self._mapView setRegion:region animated:YES];
        [self._mapView regionThatFits:region];
    }
    
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (void)reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation{
    UIView *myView = [[self.placesTableView subviews] objectAtIndex:0];
    CALayer *layer = myView.layer;
    
    CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
    rotationAndPerspectiveTransform.m34 = 1.0 / -500;
    rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, 90.0f * M_PI / 180.0f, 1.0f, 1.0f, 0.0f);
    layer.transform = rotationAndPerspectiveTransform;
    
    
    [UIView beginAnimations:NULL context:nil];
    [UIView setAnimationDuration:0.8];
    //[cell setFrame:CGRectMake(0, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height)];
    rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, -90.0f * M_PI / 180.0f, 1.0f, 1.0f, 0.0f);
    layer.transform = rotationAndPerspectiveTransform;
    [UIView commitAnimations];
    
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor whiteColor];
    button.frame = CGRectMake(10, 20, 200, 50); // position in the parent view and set the size of the button
    //[button setTitle:[self.array objectAtIndex:section] forState:UIControlStateNormal];
    //    [button setTitle:[[self.allPlaces objectForKey:@"name"] objectAtIndex:section] forState:UIControlStateNormal];
    [button setTitle:[NSString stringWithFormat:@" %@",[[self.allPlaces objectForKey:@"name"] objectAtIndex:section]] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    // add targets and actions
    [button addTarget:self action:@selector(pusher:) forControlEvents:UIControlEventTouchUpInside];
    [button setTag:section];
    
    
    //Here pict for rating
    UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(220, 15, 100, 20)];
   // NSLog(@"rate: '%@'", [[self.allPlaces objectForKey:@"rating"] objectAtIndex:section]);
    imv.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@star.png", [[self.allPlaces objectForKey:@"rating"] objectAtIndex:section]]];
    [button addSubview:imv];
    
    return button;
}

-(void)pusher:(UIButton *)Sender{
    //        UIViewController * fourthViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FourthViewController"];
    //      [self.navigationController.slideViewController setMainViewController:fourthViewController animated:YES];
    
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

- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    
    UIImage* theImage = [self.imageCache objectForKey:url];
    if ((nil != theImage) && [theImage isKindOfClass:[UIImage class]]) {
        NSLog(@"img loaded from cache!");
        completionBlock(YES, theImage);
    }
    else{
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                   if ( !error )
                                   {
                                       UIImage *image = [[UIImage alloc] initWithData:data];
                                       [self.imageCache setObject:image forKey:url];
                                       NSLog(@"img saved to cache! (%@)", [self.imageCache objectForKey:url]);
                                       NSLog(@"Images in cache: %d", [self.imageCache count]);
                                       completionBlock(YES,image);
                                   } else{
                                       completionBlock(NO, nil);
                                   }
                               }];
    }
}

/*
 ASYNC EXAMPLE
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 static NSString *cellIdentifier = @"venue";
 UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
 
 if (!cell) {
 cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
 }
 
 Venue *venue = ((Venue * )self.venues[indexPath.row]);
 if (venue.userImage) {
 cell.imageView.image = venue.image;
 } else {
 // set default user image while image is being downloaded
 cell.imageView.image = [UIImage imageNamed:@"batman.png"];
 
 // download the image asynchronously
 [self downloadImageWithURL:venue.url completionBlock:^(BOOL succeeded, UIImage *image) {
 if (succeeded) {
 // change the image in the cell
 cell.imageView.image = image;
 
 // cache the image for use later (when scrolling up)
 venue.image = image;
 }
 }];
 }
 }
 
 
 
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    static NSString *SimpleTableIdentifier = @"placesTableView";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: SimpleTableIdentifier];
    if (cell == nil) { cell = [[UITableViewCell alloc]
                               initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleTableIdentifier];
    }
    if([cell.contentView.subviews count] > 0)
        [[cell.contentView.subviews objectAtIndex:0] removeFromSuperview];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
#warning 320 на ios7 beta 3 не достает до конца экрана. Сделаем 321
    UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, 321, 250)];
    
    //while loading an image
    //        imv.image = [UIImage imageNamed:@"loading.png"];
    //        [cell.contentView addSubview:imv];
    imv.tag = section;
    [imv addGestureRecognizer:singleTap];
    [imv setUserInteractionEnabled:YES];
    //    imv.image = [UIImage imageNamed:@"icon.png"];
    [self downloadImageWithURL:[NSURL URLWithString:[[self.allPlaces objectForKey:@"image"] objectAtIndex:section]] completionBlock:^(BOOL succeeded, UIImage *image) {
        if (succeeded) {
            imv.image = image;
            //                       if([cell.contentView.subviews count] > 0)
            //                           [[cell.contentView.subviews objectAtIndex:0] removeFromSuperview];
            [cell.contentView addSubview:imv];
        }
    }];
    
    
    //Here is line
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 320, 40)];
    line.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [imv addSubview:line];
    
    //Here is subway station
    UILabel *subway = [[UILabel alloc] initWithFrame:CGRectMake(10, 220, 190, 20)];
    subway.textColor = [UIColor whiteColor];
    subway.backgroundColor = [UIColor clearColor];
    [subway setText:AMLocalizedString([[self.allPlaces objectForKey:@"subway"] objectAtIndex:section], nil)];
    [imv addSubview:subway];
    
    //Here is avg paycheck
    UILabel *paycheck = [[UILabel alloc] initWithFrame:CGRectMake(200, 200, 120, 20)];
    paycheck.textColor = [UIColor whiteColor];
    paycheck.backgroundColor = [UIColor clearColor];
    [paycheck setText:[[self.allPlaces objectForKey:@"paycheck"] objectAtIndex:section]];
    [imv addSubview:paycheck];
    
    //Here is work time
    UILabel *workTime = [[UILabel alloc] initWithFrame:CGRectMake(200, 220, 120, 20)];
    workTime.textColor = [UIColor whiteColor];
    workTime.backgroundColor = [UIColor clearColor];
    [workTime setText:[[self.allPlaces objectForKey:@"worktime"] objectAtIndex:section]];
    [imv addSubview:workTime];
    
    //        [cell.contentView addSubview:imv];
    cell.backgroundColor = [UIColor whiteColor];
    //        }
    //    int r = arc4random() % 2;
    //    if(r)
    //        [cell setFrame:CGRectMake(-320, 560, cell.frame.size.width, cell.frame.size.height)];
    //    else
    //        [cell setFrame:CGRectMake(320, 560, cell.frame.size.width, cell.frame.size.height)];
    //
    
    if(PREVIOUS_SECTION > section)
        REVERSE_ANIM = true;
    else
        REVERSE_ANIM = false;
    
    PREVIOUS_SECTION = section;
    UIView *myView = [[cell subviews] objectAtIndex:0];
    CALayer *layer = myView.layer;
    
    CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
    rotationAndPerspectiveTransform.m34 = 1.0 / -500;
    if(!REVERSE_ANIM){
        rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, -M_PI/2, 1, 0, 0);
        //rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, -1, 1, 1, 1);
        //rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, -M_PI, -M_PI, -M_PI, 0);
        //rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, -M_PI, 0, -M_PI, 0);
        //rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, 2 * M_PI / 2, 100, 1, 100);
        //rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, 90.0f * M_PI / 180.0f, -8.0f, 1.0f, 0.0f);
        //rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, 90.0f * M_PI / 180.0f, 0, 1.0f, 0.0f);
        //  rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, 90.0f * M_PI / 180.0f, -2.0f, 1.0f, 0.0f);
    }
    else{
        //rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, M_PI/2, 1, 0, 0);
        rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, 1, -1, -1, 1);
        //rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, -M_PI, M_PI, -M_PI, 0);
        //rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, -M_PI, 0, M_PI, 0);
        //rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, 2 * M_PI / 2, -100, 1, 100);
        //rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, -90.0f * M_PI / 180.0f, -8.0f, 1.0f, 0.0f);
        //rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, 90.0f * M_PI / 180.0f, 0, 1.0f, 0.0f);
        // rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, -90.0f * M_PI / 180.0f, -2.0f, 1.0f, 0.0f);
    }
    
    layer.transform = rotationAndPerspectiveTransform;
    
    
    [UIView beginAnimations:NULL context:nil];
    [UIView setAnimationDuration:0.75];
    //[cell setFrame:CGRectMake(0, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height)];
    if(!REVERSE_ANIM){
        rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, M_PI/2, 1, 0, 0);
        //rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, 1, 1, 1, 1);
        //rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, M_PI, -M_PI, -M_PI, 0);
        //rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, M_PI, 0, -M_PI, 0);
        //rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, -2 * M_PI / 2, 100, 1, 100);
        //rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, -90.0f * M_PI / 180.0f, -8.0f, 1.0f, 0.0f);
        //rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, -90.0f * M_PI / 180.0f, 0, 1.0f, 0.0f);
        // rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, -90.0f * M_PI / 180.0f, -2.0f, 1.0f, 0.0f);
    }
    else{
        //rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, -M_PI/2, 1, 0, 0);
        rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, -1, -1, -1, 1);
        //rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, M_PI, M_PI, -M_PI, 0);
        //rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, M_PI, 0, M_PI, 0);
        //rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, -2 * M_PI / 2, -100, 1, 100);
        //rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, 90.0f * M_PI / 180.0f, -8.0f, 1.0f, 0.0f);
        //rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, -90.0f * M_PI / 180.0f, 0, 1.0f, 0.0f);
        //rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, 90.0f * M_PI / 180.0f, -2.0f, 1.0f, 0.0f);
    }
    layer.transform = rotationAndPerspectiveTransform;
    [UIView commitAnimations];
    
    return cell;
}



//-(void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)animated completion:(void (^)(void))completion{
//    if(animated){
//        CATransition* transition = [CATransition animation];
//        transition.type = kCATransitionMoveIn;
//        transition.subtype = kCATransitionFromLeft;
//        // parent.view.window.layer is essential!
//        [self.view.window.layer addAnimation:transition forKey:nil ];
//        [self presentViewController:viewControllerToPresent animated:NO completion:^{}];
//    }
//}
- (void) presentTLModalViewController:(UIViewController *)pDestinationController animated:(BOOL)pAnimated completion:(void (^)(void))completion {
    if (pAnimated) {
        [CATransaction begin];
        
        CATransition *transition = [CATransition animation];
        transition.type = kCATransitionFade;
        transition.subtype = kCATransitionFromBottom;
        transition.duration = 0.25f;
        transition.fillMode = kCAFillModeForwards;
        transition.removedOnCompletion = YES;
        
        [[UIApplication sharedApplication].keyWindow.layer addAnimation:transition forKey:@"transition"];
        
        [self presentViewController:pDestinationController animated:NO completion:completion];
        
        [CATransaction commit];
    } else {
        [self presentViewController:pDestinationController animated:NO completion:completion];
    }
}
-(void)singleTapGestureCaptured:(UIButton *)Sender{
    //    NSString *docsDir;
    //    NSArray *dirPaths;
    //
    //    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //    docsDir = [dirPaths objectAtIndex:0];
    //    NSString *databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent:@"foo.jpg"]];
    //
    //    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
    //        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, [UIScreen mainScreen].scale);
    //    else
    //        UIGraphicsBeginImageContext(self.view.bounds.size);
    //    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    //    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //    UIGraphicsEndImageContext();
    //    NSData * data = UIImageJPEGRepresentation(image, 0.8);
    //    BOOL saved = [data writeToFile:databasePath atomically:YES];
    //    NSLog(@"saved: %d to %@", saved, databasePath);
    //    [[NSUserDefaults standardUserDefaults] setObject:databasePath forKey:@"bckg"];
    SELECTED_SECTION = [(UIGestureRecognizer *)Sender view].tag;
    modalViewController *viewControllerToPresent = [self.storyboard instantiateViewControllerWithIdentifier:@"ModalViewController"];
    //modalViewController *view = [[modalViewController alloc] initWithNibName:@"ModalViewController" bundle:nil];
    viewControllerToPresent.placeName = [[self.allPlaces objectForKey:@"name"] objectAtIndex:SELECTED_SECTION];
    viewControllerToPresent.rating = [[self.allPlaces objectForKey:@"rating"] objectAtIndex:SELECTED_SECTION];
    viewControllerToPresent.subway = [[self.allPlaces objectForKey:@"subway"] objectAtIndex:SELECTED_SECTION];
    viewControllerToPresent.paycheck = [[self.allPlaces objectForKey:@"paycheck"] objectAtIndex:SELECTED_SECTION];
    viewControllerToPresent.worktime = [[self.allPlaces objectForKey:@"worktime"] objectAtIndex:SELECTED_SECTION];
    viewControllerToPresent.image = [[self.allPlaces objectForKey:@"image"] objectAtIndex:SELECTED_SECTION];
    viewControllerToPresent.FROM_SEARCHBAR = NO;
    //[self presentTLModalViewController:viewControllerToPresent animated:YES completion:^{}];
    [self presentViewController:viewControllerToPresent animated:YES completion:^{}];
    //
    //    CATransition* transition = [CATransition animation];
    //    transition.type = kCATransitionMoveIn;
    //    transition.subtype = kCATransitionFromBottom;
    //
    //    [self.view.window.layer addAnimation:transition forKey:nil ];
    //   [self presentViewController:viewControllerToPresent animated:NO completion:^{}];
}

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


#pragma mark - Infinite scrolling
/* To emulate infinite scrolling...
 
 The table data was doubled to join the head and tail.
 When the user scrolls backwards to 1/8th of the new table, user is at the 1/4th of actual data, so we scroll to 5/8th of the new table where the cells are exactly the same.
 
 Similarly, when user scrolls to 6/8th of the table, we will scroll back to 3/8th where the cells are same.
 
 In simple words, when user reaches 1/4th of the first part of table, we scroll to 1/4th of the second part, when he reaches 3/4th of the second part of table, we scroll to the 3/4 of first part. This is done simply by subtracting OR adding half the length of the new table.
 
 (C) Anup Kattel, you can copy this code, please leave these comments if you don't mind.
 */


//-(void)scrollViewDidScroll:(UIScrollView *)scrollView_
//{
//    [scrollView_ setDecelerationRate:UIScrollViewDecelerationRateFast];
//    [scrollView_ setShowsHorizontalScrollIndicator:NO];
//    [scrollView_ setShowsVerticalScrollIndicator:NO];
//    CGFloat currentOffsetX = scrollView_.contentOffset.x;
//    CGFloat currentOffSetY = scrollView_.contentOffset.y;
//    CGFloat contentHeight = scrollView_.contentSize.height;
//
//    if (currentOffSetY < (contentHeight / 8.0)) {
//        scrollView_.contentOffset = CGPointMake(currentOffsetX,(currentOffSetY + (contentHeight/2)));
//    }
//    if (currentOffSetY > ((contentHeight * 6)/ 8.0)) {
//        scrollView_.contentOffset = CGPointMake(currentOffsetX,(currentOffSetY - (contentHeight/2)));
//    }
//
////    [UIView animateWithDuration:0.4
////                     animations:^{
////                         self.mainPanelView.frame = frame;
////                     }
////                     completion:^(BOOL finished) {
////                         // Replace the view controller and slide back in
////                         self.mainViewController = mainViewController;
////                         [self showMainViewControllerAnimated:animated];
////                     }
////     ];
//
//
////    [UIView beginAnimations:nil context:nil];
////    [UIView setAnimationDuration:0.4];
////    [scrollView_ setContentOffset:CGPointMake(0, 0) animated:YES];
////    [UIView commitAnimations];
//}

#pragma mark - Map's parralax
- (void)updateOffsets{
    if(MAP_PRESENTED)
        return;
    CGFloat yOffset   = self.placesTableView.contentOffset.y;
    if (yOffset < 0) {
        //Paralax handling
        for (UIGestureRecognizer *recognizer in self._mapView.gestureRecognizers) {
            [self._mapView removeGestureRecognizer:recognizer];
        }
        self._mapView.frame = CGRectMake(0, -44.0, 320.0, 140.0 - yOffset);
    }
    else {
        //To normal state
        UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self action:@selector(openMap:)];
        tgr.numberOfTapsRequired = 1;
        tgr.numberOfTouchesRequired = 1;
        [self._mapView addGestureRecognizer:tgr];
    }
    self._mapView.contentMode = UIViewContentModeScaleAspectFit;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self updateOffsets];
}

#pragma mark - Map's selectors (animation)

- (void)openMap:(UIGestureRecognizer *)gestureRecognizer
{
    MAP_PRESENTED = true;
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded)
        return;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect theFrame = self._mapView.frame;
        CGRect frame = self.placesTableView.frame;
        theFrame.origin.y = 0;
        theFrame.size.height = self.view.frame.size.height;
        frame.origin.y = self.view.frame.size.height;
        self._mapView.frame = theFrame;
        self.placesTableView.frame = frame;
        [self._mapView setZoomEnabled:YES];
        [self._mapView setMultipleTouchEnabled:YES];
        [self._mapView setScrollEnabled:YES];
        [self._mapView setUserTrackingMode:NO];
        
#warning ПЛОХАЯ КНОПКА!
        //      MKUserTrackingBarButtonItem *buttonItem = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self._mapView];
        //    self.navigationItem.rightBarButtonItem = buttonItem;
        //        [self._mapView setUserTrackingMode:MKUserTrackingModeFollowWithHeading];
        
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor blackColor];
        button.frame = CGRectMake(00, 00, 320, 40); // position in the parent view and set the size of the button
        [button setTitle:AMLocalizedString(@"Back", nil) forState:UIControlStateNormal];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [button addTarget:self action:@selector(closeMap:) forControlEvents:(UIControlEvents)UIControlEventTouchDown];
        button.tag = 99;
        [self._mapView addSubview:button];
        
    }];
}
-(void)closeMap:(id)sender{
    
    float offset = 30;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect theFrame = self._mapView.frame;
        CGRect frame = self.placesTableView.frame;
        theFrame.size.height = 140;// + offset;
        theFrame.origin.y = -44.0;
        frame.origin.y = 96 - offset;
        frame.size.height = self.view.frame.size.height;
        self._mapView.frame = theFrame;
        self.placesTableView.frame = frame;
        [self._mapView setZoomEnabled:NO];
        [self._mapView setMultipleTouchEnabled:NO];
        [self._mapView setScrollEnabled:NO];
        [self._mapView setUserTrackingMode:YES];
        
        //Resize and scroll map to current position
        MKCoordinateRegion region;
        MKCoordinateSpan span;
        span.latitudeDelta = 0.005;
        span.longitudeDelta = 0.005;
        CLLocationCoordinate2D location = self._mapView.userLocation.coordinate;
        region.span = span;
        region.center = location;
        [self._mapView setRegion:region animated:YES];
        [self._mapView regionThatFits:region];
        
    } completion:^(BOOL finished) {[UIView animateWithDuration:0.2 animations:^{
        CGRect frame = self.placesTableView.frame;
        frame.origin.y = 96;
        frame.size.height = self.view.frame.size.height - 96;
        self.placesTableView.frame = frame;
        
        //Remove button
        for (UIView *subView in self._mapView.subviews){
            if (subView.tag == 99)
                [subView removeFromSuperview];
        }
    }];
    }];
    
    //To avoid incorrect tap we need to delete gesture recognizer from map
    for (UIGestureRecognizer *recognizer in self._mapView.gestureRecognizers) {
        [self._mapView removeGestureRecognizer:recognizer];
    }
    //And create a new one
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self action:@selector(openMap:)];
    tgr.numberOfTapsRequired = 1;
    tgr.numberOfTouchesRequired = 1;
    [self._mapView addGestureRecognizer:tgr];
    MAP_PRESENTED = false;
}

@end

