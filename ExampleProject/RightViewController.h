//
//  RightViewController.h
//  MKDSlideViewController
//
//  Created by Marcel Dierkes on 18.04.13.
//
//

#import <UIKit/UIKit.h>

@interface RightViewController : UITableViewController
@property (nonatomic, retain) NSArray *array;
@property (nonatomic, retain) NSMutableArray *expandArrayCash;
@property (nonatomic, retain) NSMutableArray *expandArrayCousine;
@property (nonatomic, retain) NSMutableArray *expandArrayMenu;
@property (nonatomic, retain) NSMutableArray *expandArrayFun;
@property (nonatomic, retain) NSMutableArray *expandArrayMusic;
@property (nonatomic, retain) NSMutableArray *expandArrayOthers;
@property (nonatomic, retain) IBOutlet UITableView *TableView;
@property (nonatomic, retain) NSMutableSet *checkedData;
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
