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
@synthesize placeTableView;
@synthesize _mapView;
@synthesize placeCoordinates;
static BOOL MAP_PRESENTED = false;

#pragma mark - Table view delegate

- (void)viewDidLoad{
    [super viewDidLoad];
    if (!self.array)
        self.array = @[@"Метро", @"Адрес", @"Средний счет", @"Часы работы"];
    self.placeCoordinates = CLLocationCoordinate2DMake(55.751185,37.596921);
}

#pragma mark - Map handler

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self action:@selector(openMap:)];
    
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.001;
    span.longitudeDelta = 0.001;
    CLLocationCoordinate2D location = placeCoordinates;// CLLocationCoordinate2DMake(55.751185,37.596921);
    region.span = span;
    region.center = location;
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:location];
    [annotation setTitle:@"Place Name"]; //You can set the subtitle too
    [self._mapView addAnnotation:annotation];
    [self._mapView setRegion:region animated:YES];
    [self._mapView regionThatFits:region];
    
    tgr.numberOfTapsRequired = 1;
    tgr.numberOfTouchesRequired = 1;
    [self._mapView addGestureRecognizer:tgr];
}

- (void)appToBackground{
    NSLog(@"MW MAP LOG: app to background");
    [self._mapView setShowsUserLocation:NO];
}
- (void)appReturnsActive{
    NSLog(@"MW MAP LOG: app returns active");
    [self._mapView setShowsUserLocation:YES];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.array count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;//[self.array count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor darkGrayColor];
    // [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    button.frame = CGRectMake(10, 20, 200, 50); // position in the parent view and set the size of the button
    [button setTitle:@"placeName" forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    // add targets and actions
    [button addTarget:self action:@selector(pusher:) forControlEvents:UIControlEventTouchUpInside];
    [button setTag:section];
    return button;
}

-(void)pusher:(UIButton *)Sender{

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
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.text = [self.array objectAtIndex:[indexPath row]];
    }
    return cell;
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];    
}

- (IBAction)close:(id)sender{
    [self dismissViewControllerAnimated:YES completion:^{}];
}


#pragma mark - Map's parralax
- (void)updateOffsets{
    if(MAP_PRESENTED)
        return;
    
    CGFloat yOffset   = self.placeTableView.contentOffset.y;
    CGFloat threshold = self.placeTableView.frame.size.height - self.placeTableView.frame.size.height;
    if (yOffset > -threshold && yOffset < 0) {
        //Everything OK!
    }
    else if (yOffset < 0) {
        //Paralax handling
        for (UIGestureRecognizer *recognizer in self._mapView.gestureRecognizers) {
            [self._mapView removeGestureRecognizer:recognizer];
        }
        self._mapView.frame = CGRectMake(0, 36.0, 320.0, 166.0 - yOffset + floorf(threshold / 2.0));
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
        CGRect frame = self.placeTableView.frame;
        theFrame.origin.y = 66;
        theFrame.size.height = self.view.frame.size.height;
        frame.origin.y = self.view.frame.size.height;
        self._mapView.frame = theFrame;
        self.placeTableView.frame = frame;
        [self._mapView setZoomEnabled:YES];
        [self._mapView setMultipleTouchEnabled:YES];
        [self._mapView setScrollEnabled:YES];
        
#warning ПЛОХАЯ КНОПКА!
        //      MKUserTrackingBarButtonItem *buttonItem = [[MKUserTrackingBarButtonItem alloc] initWithMapView:self._mapView];
        //    self.navigationItem.rightBarButtonItem = buttonItem;
        //        [self._mapView setUserTrackingMode:MKUserTrackingModeFollowWithHeading];
        
        
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
        CGRect frame = self.placeTableView.frame;
        theFrame.size.height = 146.0;
        theFrame.origin.y = 36.0;
        frame.origin.y = 166 - offset;
        frame.size.height = self.view.frame.size.height;
        self._mapView.frame = theFrame;
        self.placeTableView.frame = frame;
        [self._mapView setZoomEnabled:NO];
        [self._mapView setMultipleTouchEnabled:NO];
        [self._mapView setScrollEnabled:NO];
        
        //Resize and scroll map to current position
        MKCoordinateRegion region;
        MKCoordinateSpan span;
        span.latitudeDelta = 0.001;
        span.longitudeDelta = 0.001;
        CLLocationCoordinate2D location = self.placeCoordinates;//self._mapView.userLocation.coordinate;
        region.span = span;
        region.center = location;
        [self._mapView setRegion:region animated:YES];
        [self._mapView regionThatFits:region];
        
    } completion:^(BOOL finished) {[UIView animateWithDuration:0.2 animations:^{
        CGRect frame = self.placeTableView.frame;
        frame.origin.y = 166;
        frame.size.height = self.view.frame.size.height - 166;
        self.placeTableView.frame = frame;
        
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
