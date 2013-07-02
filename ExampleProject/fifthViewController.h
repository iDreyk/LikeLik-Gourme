//
//  fifthViewController.h
//  MKDSlideViewController
//
//  Created by Ilya on 21.05.13.
//
//

#import <UIKit/UIKit.h>

@interface fifthViewController : UITableViewController
@property (nonatomic, retain) NSArray *array;
@property (nonatomic, retain) IBOutlet UITableView *restourantsTableView;
@property (nonatomic) NSInteger rowCount;
- (IBAction)showMenu:(id)sender;

@end
