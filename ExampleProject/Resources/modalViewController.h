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
@property (nonatomic, strong) NSString *subway;
@property (nonatomic, strong) NSString *paycheck;
@property (nonatomic, strong) NSString *worktime;
@property (nonatomic, strong) NSString *rating;
@property (nonatomic, strong) NSString *image;
@property (nonatomic) BOOL FROM_SEARCHBAR;
//@property (nonatomic, strong) IBOutlet UITableView *placeTableView;
@property (nonatomic, strong) IBOutlet UIView *placeCard;
@property (nonatomic, strong) IBOutlet MKMapView *_mapView;
@property (nonatomic) CLLocationCoordinate2D placeCoordinates;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;

- (IBAction)close:(id)sender;
- (IBAction)Check:(id)sender;

@end
