//
//  modalViewController.h
//  MKDSlideViewController
//
//  Created by Ilya on 31.05.13.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface modalViewController : UIViewController
@property (nonatomic, strong) IBOutlet UITextView * textView;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) IBOutlet UITableView *placeTableView;
@property (nonatomic, strong) IBOutlet MKMapView *_mapView;
@property (nonatomic) CLLocationCoordinate2D placeCoordinates;

- (IBAction)close:(id)sender;


@end
