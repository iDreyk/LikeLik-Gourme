//
//  newMainViewController.m
//  MKDSlideViewController
//
//  Created by Ilya on 21.05.13.
//
//

#import "newMainViewController.h"

#import "MKDSlideViewController.h"
#import "UIViewController+MKDSlideViewController.h"
#import "thirdViewController.h"
#import "modalViewController.h"

@implementation newMainViewController
@synthesize placesTableView;
- (IBAction)showLeftMenu:(id)sender
{
    // Use the UIViewController (MKDSlideViewController) category as a helper
    [self.navigationController.slideViewController callLeftMenu];
}
- (IBAction)showRightMenu:(id)sender{
    [self.navigationController.slideViewController callRightMenu];
}

#pragma mark - Table view delegate

- (void)viewDidLoad{
    self.array =         [[NSArray alloc] initWithArray:@[@"1st place",@"2nd place",@"3rd place",@"4th place",@"5th place",@"6th place",@"7th place",@"8th place", @"9th place", @"10th place"]];
    self.rateArray = [[NSArray alloc] initWithArray:@[@"2", @"3", @"1", @"4", @"4", @"5", @"4", @"2", @"3", @"4"]];
    self.subwayArray = [[NSArray alloc] initWithArray:@[@"Arbatskaya", @"Tretyakovskaya", @"Puskinskaya", @"Aeroport", @"Komsomolskaya", @"Universitet", @"Dinamo", @"Arbatskaya", @"Akademicheskaya", @"Leninskiy prospekt"]];
    self.paycheckArray = [[NSArray alloc] initWithArray:@[@"1200", @"900", @"1700", @"1300", @"2000", @"1500", @"950", @"2100", @"3000", @"1900"]];
    self.workTimeArray = [[NSArray alloc] initWithArray:@[@"10:00 - 23:00", @"12:00 - 23:00", @"9:00 - 21:00", @"10:00 - 24:00", @"9:00 - 03:00", @"10:00 - 22:00", @"11:00 - 00:00", @"10:00 - 01:00", @"8:00 - 20:00", @"11:00 - 23:00"]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appToBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appReturnsActive) name:UIApplicationDidBecomeActiveNotification object:nil];
}

#pragma mark - Map handler

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidLoad];    
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self action:@selector(openMap:)];
    tgr.numberOfTapsRequired = 1;
    tgr.numberOfTouchesRequired = 1;
    [self._mapView addGestureRecognizer:tgr];
    [tgr release];
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
    NSLog(@"MAP LOG: update");
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.003;
    span.longitudeDelta = 0.003;
    CLLocationCoordinate2D location = self._mapView.userLocation.coordinate;
    NSLog(@"MAP LOG: coordinates: %f, %f", location.latitude, location.longitude);
    region.span = span;
    region.center = location;
    [self._mapView setRegion:region animated:YES];
    [self._mapView regionThatFits:region];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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
    
    
    //Here pict for rating
    
    UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(220, 15, 100, 20)];
    
    imv.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@star.png", [self.rateArray objectAtIndex:section]]];
    [button addSubview:imv];
    [imv release];


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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = indexPath.section;
    
    static NSString *SimpleTableIdentifier = @"placesTableView";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: SimpleTableIdentifier];
    if (cell == nil) { cell = [[[UITableViewCell alloc]
                                initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SimpleTableIdentifier] autorelease];
   
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCaptured:)];
        
        UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, 320, 250)];
        [imv addGestureRecognizer:singleTap];
        [imv setUserInteractionEnabled:YES];
        
        imv.image=[UIImage imageNamed:@"testRestPict.jpg"];
        
        //Here is line
        UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 320, 40)];
        line.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        [imv addSubview:line];
        [line release];

        
        //Here is subway station
        UILabel *subway = [[UILabel alloc] initWithFrame:CGRectMake(0, 220, 200, 20)];
        subway.textColor = [UIColor whiteColor];
        [subway setText:[self.subwayArray objectAtIndex:section]];
        [imv addSubview:subway];
        [subway release];
        
        //Here is avg paycheck
        UILabel *paycheck = [[UILabel alloc] initWithFrame:CGRectMake(200, 200, 120, 20)];
        paycheck.textColor = [UIColor whiteColor];
        [paycheck setText:[self.paycheckArray objectAtIndex:section]];
        [imv addSubview:paycheck];
        [paycheck release];
        
        //Here is work time
        UILabel *workTime = [[UILabel alloc] initWithFrame:CGRectMake(200, 220, 120, 20)];
        workTime.textColor = [UIColor whiteColor];
        [workTime setText:[self.workTimeArray objectAtIndex:section]];
        [imv addSubview:workTime];
        [workTime release];
        
        [cell.contentView addSubview:imv];
        [imv release];
    }
    
    
    return cell;
}

-(void)singleTapGestureCaptured:(UIButton *)Sender{
    UIViewController *go = [self.storyboard instantiateViewControllerWithIdentifier:@"ModalViewController"];
    [self presentModalViewController:go animated:YES];
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
    CGFloat yOffset   = self.placesTableView.contentOffset.y;
    CGFloat threshold = self.placesTableView.frame.size.height - self.placesTableView.frame.size.height;
    if (yOffset > -threshold && yOffset < 0) {
        //Everything OK!
    }
    else if (yOffset < 0) {
        //Paralax handling
        for (UIGestureRecognizer *recognizer in self._mapView.gestureRecognizers) {
            [self._mapView removeGestureRecognizer:recognizer];
        }
        self._mapView.frame = CGRectMake(0, -44.0, 320.0, 152.0 - yOffset + floorf(threshold / 2.0));
    }
    else {
        //To normal state
        UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self action:@selector(openMap:)];
        tgr.numberOfTapsRequired = 1;
        tgr.numberOfTouchesRequired = 1;
        [self._mapView addGestureRecognizer:tgr];
        [tgr release];
    }
    self._mapView.contentMode = UIViewContentModeScaleAspectFit;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self updateOffsets];
}

#pragma mark - Map's selectors (animation)

- (void)openMap:(UIGestureRecognizer *)gestureRecognizer
{
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
        
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor blackColor];
        button.frame = CGRectMake(00, 00, 320, 40); // position in the parent view and set the size of the button
        [button setTitle:@"Back" forState:UIControlStateNormal];
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
        theFrame.size.height = 140 + offset;
        theFrame.origin.y = -44.0;
        frame.origin.y = 96 - offset;
        frame.size.height = self.view.frame.size.height;
        self._mapView.frame = theFrame;
        self.placesTableView.frame = frame;
        [self._mapView setZoomEnabled:NO];
        [self._mapView setMultipleTouchEnabled:NO];
        [self._mapView setScrollEnabled:NO];
        
        //Resize and scroll map to current position
        MKCoordinateRegion region;
        MKCoordinateSpan span;
        span.latitudeDelta = 0.003;
        span.longitudeDelta = 0.003;
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
    [tgr release];
}

@end
