//
//  thirdViewController.h
//  MKDSlideViewController
//
//  Created by Ilya on 20.05.13.
//
//

#import <UIKit/UIKit.h>

@interface thirdViewController : UITableViewController
@property (nonatomic, retain) NSArray *array;
@property (nonatomic, retain) IBOutlet UITableView *settingsTableView;
@property (nonatomic, retain) NSMutableSet *storedData;
- (IBAction)showMenu:(id)sender;




@end
