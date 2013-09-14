//
//  LeftViewController.h
//  MKDSlideViewController
//
//  Created by Ilya Tsarev on 20.05.13.
//
//

#import <UIKit/UIKit.h>
#import "GAI.h"

@interface LeftViewController : GAITrackedViewController <UISearchBarDelegate>
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSArray *placesArray;
@property (nonatomic, strong) NSArray *subwayArray;
@property (nonatomic, strong) NSArray *paycheckArray;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSArray *rateArray;
@property (nonatomic, strong) NSArray *workTimeArray;
@property (nonatomic, strong) NSMutableArray *cityArray;
@property (nonatomic, strong) NSMutableArray *languageArray;
@property (nonatomic, strong) NSMutableArray *filteredArray;
@property (nonatomic, strong) IBOutlet UITableView *catalogueTableView;
@property (nonatomic) NSInteger rowCountCity;
@property (nonatomic) NSInteger rowCountLang;
@property (nonatomic, strong) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;
@property (weak, nonatomic) IBOutlet UIImageView *background;
@property (nonatomic, strong) NSMutableArray *displayItems;
@property (nonatomic, strong) NSMutableDictionary *allPlaces;


-(void)openCityMenu;
-(void)closeCityMenu;

-(void)openLangMenu;
-(void)closeLangMenu;

@end
