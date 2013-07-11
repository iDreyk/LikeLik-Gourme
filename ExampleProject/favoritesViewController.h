//
//  favoritesViewController.h
//  LikeLik Gourmet
//
//  Created by Ilya on 11.07.13.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface favoritesViewController : UIViewController
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, strong) NSMutableArray *rateArray;
@property (nonatomic, strong) NSMutableArray *subwayArray;
@property (nonatomic, strong) NSMutableArray *paycheckArray;
@property (nonatomic, strong) NSMutableArray *workTimeArray;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) NSMutableDictionary *imageCache;
@property (nonatomic, strong) NSMutableDictionary *allPlaces;

@property (nonatomic, strong) IBOutlet UITableView *placesTableView;
@property (nonatomic, strong) IBOutlet MKMapView *_mapView;
- (IBAction)showLeftMenu:(id)sender;
- (IBAction)showRightMenu:(id)sender;

@end
