//
//  LeftViewController.h
//  MKDSlideViewController
//
//  Created by Ilya Tsarev on 20.05.13.
//
//

#import <UIKit/UIKit.h>

@interface LeftViewController : UITableViewController
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSMutableArray *cityArray;
@property (nonatomic, strong) NSMutableArray *languageArray;
@property (nonatomic, strong) IBOutlet UITableView *catalogueTableView;
@property (nonatomic) NSInteger rowCountCity;
@property (nonatomic) NSInteger rowCountLang;
@property (nonatomic, strong) IBOutlet UISearchBar *searchBar;

-(void)openCityMenu;
-(void)closeCityMenu;

-(void)openLangMenu;
-(void)closeLangMenu;

@end
