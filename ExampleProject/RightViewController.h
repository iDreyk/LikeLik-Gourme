//
//  RightViewController.h
//  MKDSlideViewController
//
//  Created by Ilya Tsarev on 20.05.13.
//
//

#import <UIKit/UIKit.h>

@interface RightViewController : UITableViewController
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSMutableArray *expandArrayCash;
@property (nonatomic, strong) NSMutableArray *expandArrayCousine;
@property (nonatomic, strong) NSMutableArray *expandArrayMenu;
@property (nonatomic, strong) NSMutableArray *expandArrayFun;
@property (nonatomic, strong) NSMutableArray *expandArrayMusic;
@property (nonatomic, strong) NSMutableArray *expandArrayOthers;
@property (nonatomic, strong) IBOutlet UITableView *filtersTableView;
@property (nonatomic, strong) NSMutableSet *checkedData;
@property (nonatomic) NSInteger rowCountCash;
@property (nonatomic) NSInteger rowCountCousine;
@property (nonatomic) NSInteger rowCountMenu;
@property (nonatomic) NSInteger rowCountFun;
@property (nonatomic) NSInteger rowCountMusic;
@property (nonatomic) NSInteger rowCountOthers;

-(void)openCashMenu;
-(void)openCousineMenu;
-(void)openMenuMenu;
-(void)openFunMenu;
-(void)openMusicMenu;
-(void)openOthersMenu;

-(void)closeCashMenu;
-(void)closeCousineMenu;
-(void)closeMenuMenu;
-(void)closeFunMenu;
-(void)closeMusicMenu;
-(void)closeOthersMenu;

@end
