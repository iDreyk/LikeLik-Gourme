//
//  LeftViewController.h
//  MKDSlideViewController
//
//  Created by Ilya Tsarev on 20.05.13.
//
//

#import <UIKit/UIKit.h>

@interface LeftViewController : UIViewController <UISearchBarDelegate>
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSArray *placesArray;
@property (nonatomic, strong) NSArray *subwayArray;
@property (nonatomic, strong) NSArray *paycheckArray;
@property (nonatomic, strong) NSArray *workTimeArray;
@property (nonatomic, strong) NSMutableArray *cityArray;
@property (nonatomic, strong) NSMutableArray *languageArray;
@property (nonatomic, strong) NSMutableArray *filteredArray;
@property (nonatomic, strong) IBOutlet UITableView *catalogueTableView;
@property (nonatomic) NSInteger rowCountCity;
@property (nonatomic) NSInteger rowCountLang;
@property (nonatomic, strong) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UINavigationBar *navBar;
@property (weak, nonatomic) IBOutlet UIImageView *background;
@property (nonatomic, strong) NSMutableArray *displayItems;

-(void)openCityMenu;
-(void)closeCityMenu;

-(void)openLangMenu;
-(void)closeLangMenu;

@end
