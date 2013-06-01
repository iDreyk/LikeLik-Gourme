//
//  LeftViewController.h
//  MKDSlideViewController
//
//  Created by Marcel Dierkes on 18.04.13.
//
//

#import <UIKit/UIKit.h>

@interface LeftViewController : UITableViewController
@property (nonatomic, retain) NSArray *array;
@property (nonatomic, retain) NSArray *expandArray;
@property (nonatomic, retain) IBOutlet UITableView *catalogueTableView;
@end
