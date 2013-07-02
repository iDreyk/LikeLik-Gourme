//
//  fourthViewController.h
//  MKDSlideViewController
//
//  Created by Ilya on 21.05.13.
//
//

#import <UIKit/UIKit.h>

@interface fourthViewController : UITableViewController
@property (nonatomic, retain) NSArray *array;
@property (nonatomic, retain) NSArray *austrianCities;
@property (nonatomic, retain) NSArray *russianCities;
@property (nonatomic, retain) IBOutlet UITableView *cityTableView;
@property (nonatomic, retain) NSIndexPath *storedData;
- (IBAction)showMenu:(id)sender;

@end
