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
@synthesize placeCard;
@synthesize _mapView;
@synthesize placeCoordinates;
@synthesize placeName;
@synthesize navBar;
@synthesize subway;
@synthesize paycheck;
@synthesize worktime;
@synthesize FROM_SEARCHBAR;
static BOOL MAP_PRESENTED = false;
static BOOL DELETE_FROM_FAVORITES;

NSInteger GLOBAL_OFFSET = 0;

#pragma mark - Table view delegate

- (void)viewDidLoad{
    [super viewDidLoad];
    
    if(self.view.bounds.size.height == 460.0 || self.view.bounds.size.height == 548.0){
        CGRect newNav = self.navBar.frame;
        newNav.origin.y = 0;
        newNav.size.height = 40;
        self.navBar.frame = newNav;
        GLOBAL_OFFSET = 30;
        CGRect newImgFrame = self.view.frame;
        newImgFrame.origin.y = 0;
        self.view.frame = newImgFrame;
        CGRect newTWFrame = self.placeCard.frame;
        newTWFrame.size.height = self.view.bounds.size.height - newTWFrame.origin.y;
        self.placeCard.frame = newTWFrame;
    }
    
#warning Надо заполнить инфу к месту
    if (!self.array){
        if([[NSUserDefaults standardUserDefaults] objectForKey:@"favoritePlaces"]){
            NSMutableDictionary *favorite = [[NSUserDefaults standardUserDefaults] objectForKey:@"favoritePlaces"];
            if([favorite objectForKey:placeName]){
                self.array = @[self.subway, @"Address", self.paycheck, self.worktime, @"Delete from favorites"];
                DELETE_FROM_FAVORITES = YES;
            }
            else{
                self.array = @[self.subway, @"Address", self.paycheck, self.worktime, @"Add to favorites"];
                DELETE_FROM_FAVORITES = NO;
            }
        }
        else{
            self.array = @[self.subway, @"Address", self.paycheck, self.worktime, @"Add to favorites"];
            DELETE_FROM_FAVORITES = NO;
        }
    }
#warning Надо заполнить координаты
    self.placeCoordinates = CLLocationCoordinate2DMake(55.751185,37.596921);
    //self.background.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://asset0.cbsistatic.com/cnwk.1d/i/bto/20061228/under_water_restaurant_525x378.jpg"]]];//[UIImage imageNamed:@"testRestPict.jpg"];
    //    NSString *path = [[NSUserDefaults standardUserDefaults] objectForKey:@"bckg"];
    //    NSLog(@"path: %@", path);
    //    self.background.image = [UIImage imageWithContentsOfFile:path];
    self.background.image = [UIImage imageNamed:@"640_1136 LaunchScreen-568h@2x.png"];
    //    UIImage *effectImage = nil;
    //effectImage = [self.background.image applyLightEffect];
    //self.background.image = effectImage;
#warning Надо заполнить имя места
    navBar.topItem.title = self.placeName;
    navBar.topItem.leftBarButtonItem.title =  AMLocalizedString(@"Back", nil);//       [navBar.topItem.leftBarButtonItem setTitle:AMLocalizedString(@"Back", nil) forState:UIControlStateNormal];

    //self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    
#warning Код для "новой" карточки места.
    UITextView *generalInfo = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
    generalInfo.backgroundColor = [UIColor lightGrayColor];
    generalInfo.scrollEnabled = NO;
    generalInfo.editable = NO;
    generalInfo.text = @"TestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestTextTestText";
    [self.placeCard addSubview:generalInfo];

    
}

#pragma mark - Map handler

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self action:@selector(openMap:)];
    
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.003;
    span.longitudeDelta = 0.003;
    CLLocationCoordinate2D location = placeCoordinates;// CLLocationCoordinate2DMake(55.751185,37.596921);
    region.span = span;
    region.center = location;
    
    
    MapViewAnnotation *Annotation = [[MapViewAnnotation alloc] initWithTitle:self.placeName andCoordinate:location andUserinfo:nil andSubtitle:@"Restaurant" AndTag:0];
    [self._mapView addAnnotation:Annotation];
    [self._mapView setRegion:region animated:YES];
    [self._mapView regionThatFits:region];
    [self._mapView setUserTrackingMode:NO];
    
    CGRect theFrame = self._mapView.frame;
    theFrame.size.height = 96.0;
    theFrame.origin.y = 66.0;
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
    [button setTitle:self.placeName forState:UIControlStateNormal];
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
        cell.textLabel.text = AMLocalizedString([self.array objectAtIndex:[indexPath row]], nil);
    }
    return cell;
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 4){
        if(!DELETE_FROM_FAVORITES){
//            NSString *docsDir;
//            NSArray *dirPaths;
//            
//            dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//            docsDir = [dirPaths objectAtIndex:0];
//            NSString *databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent:@"foo.jpg"]];
//            
//            if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
//                UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, NO, [UIScreen mainScreen].scale);
//            else
//                UIGraphicsBeginImageContext(self.view.bounds.size);
//            [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
//            UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//            UIGraphicsEndImageContext();
//            NSData * data = UIImageJPEGRepresentation(image, 0.8);
//            BOOL saved = [data writeToFile:databasePath atomically:YES];
//
//            NSString *path = [[NSUserDefaults standardUserDefaults] objectForKey:@"bckg"];
//            //    NSLog(@"path: %@", path);
//            //    self.background.image = [UIImage imageWithContentsOfFile:path];
//            
//            [[NSUserDefaults standardUserDefaults] setObject:databasePath forKey:@"bckg"];

            UIGraphicsBeginImageContext(self.view.bounds.size);
            [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
            UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            UIImageView *starView = [[UIImageView alloc] initWithImage:image];
            
            [self.view addSubview:starView];

            
           // CGRect rect = starView.frame;
            // begin ---- apply position animation
            CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
            pathAnimation.calculationMode = kCAAnimationPaced;
            pathAnimation.fillMode = kCAFillModeForwards;
            pathAnimation.removedOnCompletion = NO;
            pathAnimation.duration=0.6;
            pathAnimation.delegate=self;
            
            // tab-bar right side item frame-point = end point
          //  CGPoint endPoint = CGPointMake(210+rect.size.width/2, 390+rect.size.height/2);
            CGPoint endPoint = CGPointMake(-40, 40);

            CGMutablePathRef curvedPath = CGPathCreateMutable();
            CGPathMoveToPoint(curvedPath, NULL, self.view.frame.size.width / 2, self.view.frame.size.height / 2);
            CGPathAddCurveToPoint(curvedPath, NULL, endPoint.x, starView.frame.origin.y, endPoint.x, starView.frame.origin.y, endPoint.x, endPoint.y);
            pathAnimation.path = curvedPath;
            CGPathRelease(curvedPath);
            // end ---- apply position animation
            
            // apply transform animation
            CABasicAnimation *basic=[CABasicAnimation animationWithKeyPath:@"transform"];
            [basic setToValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01, 0.01, 0.01)]];
            [basic setAutoreverses:NO];
            [basic setDuration:0.6];
            [starView.layer addAnimation:pathAnimation forKey:@"curveAnimation"];
            [starView.layer addAnimation:basic forKey:@"transform"];
            [starView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.55];
//            [UIView animateWithDuration:0.5 animations:^{
//                CGRect frame = starView.frame;
//                frame.size.height /= 8;
//                frame.size.width /= 8;
//                frame.origin.x = self.view.frame.size.width / 2;
//                frame.origin.y = self.view.frame.size.height / 2;
//                starView.frame = frame;
//            } completion:^(BOOL finished) {
//                [UIView animateWithDuration:0.5 animations:^{
//                    CGRect rect = starView.frame;
//                    CGPoint endPoint = CGPointMake(210+rect.size.width/2, 390+rect.size.height/2);
//                    CGMutablePathRef curvedPath = CGPathCreateMutable();
//                    CGPathMoveToPoint(curvedPath, NULL, starView.frame.origin.x, starView.frame.origin.y);
//                    CGPathAddCurveToPoint(curvedPath, NULL, endPoint.x, starView.frame.origin.y, endPoint.x, starView.frame.origin.y, endPoint.x, endPoint.y);
//                    CGPathRelease(curvedPath);
//
//                } completion:^(BOOL finished) {
//                    
//                }];
//            }];
            
            if([[NSUserDefaults standardUserDefaults] objectForKey:@"favoritePlaces" ]){
                //NSLog(@"favourite exists!");
                NSMutableDictionary *favorite = [[NSUserDefaults standardUserDefaults] objectForKey:@"favoritePlaces"];
                NSMutableDictionary *newDict = [favorite mutableCopy];
                //NSLog(@"dict was: %@", newDict);
                NSMutableDictionary *placeToSave = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.placeName, @"name", self.rating, @"rating", self.subway, @"subway", self.paycheck, @"paycheck", self.worktime, @"worktime", self.image, @"image", nil];
                [newDict setObject:placeToSave forKey:self.placeName];
                //NSLog(@"dict is: %@", newDict);
                
                [[NSUserDefaults standardUserDefaults] setObject:newDict forKey:@"favoritePlaces"];
            }
            else{
                //NSLog(@"favourite creating!");
                NSMutableDictionary *placeToSave = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.placeName, @"name", self.rating, @"rating", self.subway, @"subway", self.paycheck, @"paycheck", self.worktime, @"worktime", self.image, @"image", nil];
                NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:placeToSave, self.placeName, nil];
                [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"favoritePlaces"];
            }
            self.array = @[self.subway, @"Address", self.paycheck, self.worktime, @"Delete from favorites"];
//            [self.placeCard reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
            DELETE_FROM_FAVORITES = YES;
        }
        else{
            NSMutableDictionary *favorite = [[NSUserDefaults standardUserDefaults] objectForKey:@"favoritePlaces"];
            NSMutableDictionary *newDict = [favorite mutableCopy];
            [newDict removeObjectForKey:self.placeName];
            [[NSUserDefaults standardUserDefaults] setObject:newDict forKey:@"favoritePlaces"];
            self.array = @[self.subway, @"Address", self.paycheck, self.worktime, @"Add to favorites"];
//            [self.placeCard reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
            DELETE_FROM_FAVORITES = NO;
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)close:(id)sender{
    //ios7beta5 всегда убирает клаву при открытии viewcontroller из поиска
    [self dismissViewControllerAnimated:YES completion:^{
        if(FROM_SEARCHBAR)
            [[NSNotificationCenter defaultCenter] postNotificationName:@"backToSearchBar" object:nil];
    }];
}

-(IBAction)Check:(id)sender{
    [self presentSemiViewController:VC withOptions:@{
                                                     KNSemiModalOptionKeys.pushParentBack    : @(YES),
                                                     KNSemiModalOptionKeys.animationDuration : @(0.5),
                                                     KNSemiModalOptionKeys.shadowOpacity     : @(0.3),
                                                     }];
    
    VC.view.backgroundColor = [UIColor clearColor];
#warning Это тоже нужно будет заполнять (чек)
    VC.PlaceName = self.placeName;
    VC.PlaceCategory = @"PlaceCategory";
    VC.PlaceCity = @"PlaceCity";
    VC.color = [UIColor colorWithRed:184.0/255.0 green:6.0/255.0 blue:6.0/255.0 alpha:1];
    //    _labelonPhoto.hidden = NO;
    //    _background.hidden = NO;
}

#pragma mark - Map's parralax
//- (void)updateOffsets{
//    if(MAP_PRESENTED)
//        return;
//    
//    CGFloat yOffset   = self.placeCard.contentOffset.y;
//    if (yOffset < 0 || yOffset > 0) {
//        //Paralax handling
//        for (UIGestureRecognizer *recognizer in self._mapView.gestureRecognizers) {
//            [self._mapView removeGestureRecognizer:recognizer];
//        }
//        self._mapView.frame = CGRectMake(0, 36.0, 320.0, 166.0 - yOffset);
//    }
//    else {
//        //To normal state
//        UITapGestureRecognizer *tgr = [[UITapGestureRecognizer alloc]
//                                       initWithTarget:self action:@selector(openMap:)];
//        tgr.numberOfTapsRequired = 1;
//        tgr.numberOfTouchesRequired = 1;
//        [self._mapView addGestureRecognizer:tgr];
//    }
//    self._mapView.contentMode = UIViewContentModeScaleAspectFit;
//}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    [self updateOffsets];
//}

#pragma mark - Map's selectors (animation)

- (void)openMap:(UIGestureRecognizer *)gestureRecognizer
{
    MAP_PRESENTED = true;
    if (gestureRecognizer.state != UIGestureRecognizerStateEnded)
        return;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect theFrame = self._mapView.frame;
        CGRect frame = self.placeCard.frame;
        theFrame.origin.y = 66 - GLOBAL_OFFSET;
        theFrame.size.height = self.view.frame.size.height;
        frame.origin.y = self.view.frame.size.height;
        self._mapView.frame = theFrame;
        self.placeCard.frame = frame;
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
        CGRect frame = self.placeCard.frame;
        theFrame.size.height = 96.0;// + offset;
        theFrame.origin.y = 54.0 - offset - GLOBAL_OFFSET;
        frame.origin.y = 158 - offset;
        frame.size.height = self.view.frame.size.height;
        self._mapView.frame = theFrame;
        self.placeCard.frame = frame;
        [self._mapView setZoomEnabled:NO];
        [self._mapView setMultipleTouchEnabled:NO];
        [self._mapView setScrollEnabled:NO];
        
        //Resize and scroll map to current position
        MKCoordinateRegion region;
        MKCoordinateSpan span;
        span.latitudeDelta = 0.003;
        span.longitudeDelta = 0.003;
        CLLocationCoordinate2D location = self.placeCoordinates;//self._mapView.userLocation.coordinate;
        region.span = span;
        region.center = location;
        [self._mapView setRegion:region animated:YES];
        [self._mapView regionThatFits:region];
        
    } completion:^(BOOL finished) {[UIView animateWithDuration:0.2 animations:^{
        CGRect theFrame = self._mapView.frame;
        theFrame.origin.y = 66;
        theFrame.size.height = 96.0;
        self._mapView.frame = theFrame;
        
        CGRect frame = self.placeCard.frame;
        frame.origin.y = 158;
        frame.size.height = self.view.frame.size.height - 158;
        self.placeCard.frame = frame;
        
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
