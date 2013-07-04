//
//  newMainViewController.h
//  MKDSlideViewController
//
//  Created by Ilya on 21.05.13.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface newMainViewController : UIViewController
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSArray *rateArray;
@property (nonatomic, strong) NSArray *subwayArray;
@property (nonatomic, strong) NSArray *paycheckArray;
@property (nonatomic, strong) NSArray *workTimeArray;


@property (nonatomic, strong) IBOutlet UITableView *placesTableView;
@property (nonatomic, strong) IBOutlet MKMapView *_mapView;
- (IBAction)showLeftMenu:(id)sender;
- (IBAction)showRightMenu:(id)sender;

@end
