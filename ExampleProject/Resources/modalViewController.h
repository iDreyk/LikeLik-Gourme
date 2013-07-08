//
//  modalViewController.h
//  MKDSlideViewController
//
//  Created by Ilya on 31.05.13.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CheckViewController.h"
@interface modalViewController : UIViewController{
    CheckViewController *VC;
}
@property (nonatomic, strong) IBOutlet UITextView * textView;
@property (nonatomic, strong) IBOutlet UIImageView *background;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSString *placeName;
@property (nonatomic, strong) IBOutlet UITableView *placeTableView;
@property (nonatomic, strong) IBOutlet MKMapView *_mapView;
@property (nonatomic) CLLocationCoordinate2D placeCoordinates;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;

- (IBAction)close:(id)sender;
- (IBAction)Check:(id)sender;

@end
