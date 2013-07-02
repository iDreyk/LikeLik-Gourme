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
@property (nonatomic, retain) NSMutableArray *cityArray;
@property (nonatomic, retain) NSMutableArray *languageArray;
@property (nonatomic, retain) IBOutlet UITableView *catalogueTableView;
@property (nonatomic) NSInteger rowCountCity;
@property (nonatomic) NSInteger rowCountLang;
@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;

-(void)openCityMenu;
-(void)closeCityMenu;

-(void)openLangMenu;
-(void)closeLangMenu;

@end
