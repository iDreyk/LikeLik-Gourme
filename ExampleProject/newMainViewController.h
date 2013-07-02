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
@property (nonatomic, retain) NSArray *array;
@property (nonatomic, retain) NSArray *distArray;
@property (nonatomic, retain) IBOutlet UITableView *placesTableView;
@property (nonatomic, retain) IBOutlet MKMapView *_mapView;
- (IBAction)showLeftMenu:(id)sender;
- (IBAction)showRightMenu:(id)sender;

@end
