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
#import "MapViewAnnotation.h"
#import "UIViewController+KNSemiModal.h"
#import "AppDelegate.h"
#import "UIImage+ImageEffects.h"

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
    //self.background.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://asset0.cbsistatic.com/cnwk.1d/i/bto/20061228/under_water_restaurant_525x378.jpg"]]];//[UIImage imageNamed:@"testRestPict.jpg"];
    
//    NSString *path = [[NSUserDefaults standardUserDefaults] objectForKey:@"bckg"];
//    NSLog(@"path: %@", path);
//    self.background.image = [UIImage imageWithContentsOfFile:path];
    self.background.image = [UIImage imageNamed:@"640_1136 LaunchScreen-568h@2x.png"];
    UIImage *effectImage = nil;
    //effectImage = [self.background.image applyLightEffect];
    //self.background.image = effectImage;
    
    //self.navigationController.interactivePopGestureRecognizer.enabled = YES;
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
    
    
    MapViewAnnotation *Annotation = [[MapViewAnnotation alloc] initWithTitle:@"PlaceName" andCoordinate:location andUserinfo:nil andSubtitle:@"Restraunt" AndTag:0];
    [self._mapView addAnnotation:Annotation];
    [self._mapView setRegion:region animated:YES];
    [self._mapView regionThatFits:region];
    
    CGRect theFrame = self._mapView.frame;
    theFrame.size.height = 146.0;
    theFrame.origin.y = 36.0;
    self._mapView.frame = theFrame;
    
    tgr.numberOfTapsRequired = 1;
    tgr.numberOfTouchesRequired = 1;
    [self._mapView addGestureRecognizer:tgr];
    
    if ([AppDelegate isiPhone5])
        VC = [[CheckViewController alloc] initWithNibName:@"CheckViewController" bundle:nil];
    else
        VC = [[CheckViewController alloc] initWithNibName:@"CheckViewController35" bundle:nil];
    
}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(MapViewAnnotation *)annotation {
    
    static NSString *identifier = @"MyLocation";
    if ([annotation isKindOfClass:[MapViewAnnotation class]]) {
        
        MKPinAnnotationView *annotationView =
        (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc]
                              initWithAnnotation:annotation
                              reuseIdentifier:identifier];
        } else {
            annotationView.annotation = annotation;
        }
        
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
      //  annotationView.image = [InterfaceFunctions MapPin:annotation.subtitle].image;
        
        
//        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//        rightButton.tag = [annotation.tag intValue];
//        [rightButton addTarget:self action:@selector(map_tu:) forControlEvents:UIControlEventTouchUpInside];
//        [rightButton setTitle:annotation.title forState:UIControlStateNormal];
//        [annotationView setRightCalloutAccessoryView:rightButton];
        
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
        leftButton.tag = [annotation.tag intValue];
        [leftButton addTarget:self action:@selector(showAppleMap:) forControlEvents:UIControlEventTouchUpInside];
        [leftButton setTitle:annotation.title forState:UIControlStateNormal];
        [annotationView setLeftCalloutAccessoryView:leftButton];
        
        return annotationView;
    }
    
    return nil;
}

-(void)showAppleMap:(UIButton *)sender{
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(self.placeCoordinates.latitude,self.placeCoordinates.longitude);
    
    //create MKMapItem out of coordinates
    MKPlacemark* placeMark = [[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil];
    MKMapItem* destination =  [[MKMapItem alloc] initWithPlacemark:placeMark];
    
    [destination openInMapsWithLaunchOptions:@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeWalking}];
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

-(IBAction)Check:(id)sender{    
    [self presentSemiViewController:VC withOptions:@{
     KNSemiModalOptionKeys.pushParentBack    : @(YES),
     KNSemiModalOptionKeys.animationDuration : @(0.5),
     KNSemiModalOptionKeys.shadowOpacity     : @(0.3),
     }];
    
    VC.view.backgroundColor = [UIColor clearColor];
    VC.PlaceName = @"PlaceName";
    VC.PlaceCategory = @"PlaceCategory";
    VC.PlaceCity = @"PlaceCity";
    VC.color = [UIColor colorWithRed:184.0/255.0 green:6.0/255.0 blue:6.0/255.0 alpha:1];
//    _labelonPhoto.hidden = NO;
//    _background.hidden = NO;
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
