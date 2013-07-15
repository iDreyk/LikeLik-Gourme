//
//  RightViewController.m
//  MKDSlideViewController
//
//  Created by Ilya Tsarev on 20.05.13.
//
//

#import <QuartzCore/QuartzCore.h>
#import "RightViewController.h"
#import "MKDSlideViewController.h"
#import "UIViewController+MKDSlideViewController.h"
#import "newMainViewController.h"

@implementation RightViewController
@synthesize filtersTableView;
@synthesize navBar;

static bool OPENED_CASH = NO;
static bool OPENED_Cuisine = NO;
static bool OPENED_MENU = NO;

#warning Ф-ии фильтрации центрального списка по NSSet checkedData.

#pragma mark - Table view delegate

- (void)viewDidLoad{
    
    if(self.view.bounds.size.height == 460.0 || self.view.bounds.size.height == 548.0){
        CGRect newTWFrame = self.filtersTableView.frame;
        newTWFrame.size.height = self.view.bounds.size.height - newTWFrame.origin.y;
        self.filtersTableView.frame = newTWFrame;
    }
    
    self.checkedData = [[NSMutableSet alloc] init];
    self.array = @[[NSString stringWithFormat:@"            %@",AMLocalizedString(@"Reset filters", nil)], [NSString stringWithFormat:@"            %@",AMLocalizedString(@"Average bill", nil)], [NSString stringWithFormat:@"            %@",AMLocalizedString(@"Cuisine", nil)], [NSString stringWithFormat:@"            %@",AMLocalizedString(@"Menu", nil)]];
    self.expandArrayCash =[[NSMutableArray alloc] initWithArray:@[@"               300-500", @"               500-1000", @"               1000-1500", @"               1500-2500", @"               2500-4000"]];
    self.rowCountCash = 0;
    self.expandArrayCuisine = [[NSMutableArray alloc] initWithArray:@[@"               Fusion", @"               Austrian", @"               English", @"               BBQ", @"               Itallian", @"               Spanish", @"               Greek"]];
    self.rowCountCuisine = 0;
    self.expandArrayMenu = [[NSMutableArray alloc] initWithArray:@[@"               Vegeterian", @"               Lenten", @"               Fitnes", @"               Kosher", @"               Children's", @"               Diet", @"               Halal"]];
    self.rowCountMenu = 0;
    navBar.title = AMLocalizedString(@"Filters", Nil);
    [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(languageChanged) name:@"LanguageChanged" object:nil];
}

-(void)languageChanged{
    self.array = @[[NSString stringWithFormat:@"            %@",AMLocalizedString(@"Reset filters", nil)], [NSString stringWithFormat:@"            %@",AMLocalizedString(@"Average bill", nil)], [NSString stringWithFormat:@"            %@",AMLocalizedString(@"Cuisine", nil)], [NSString stringWithFormat:@"            %@",AMLocalizedString(@"Menu", nil)]];
    navBar.title = AMLocalizedString(@"Filters", Nil);
    [self.filtersTableView reloadData];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1)
        return self.rowCountCash;
    if (section == 2)
        return  self.rowCountCuisine;
    if (section == 3)
        return  self.rowCountMenu;
    
    //return self.rowCount;
    //return [self.array count];
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor blackColor];
    // [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    button.frame = CGRectMake(10, 20, 200, 50); // position in the parent view and set the size of the button
    [button setTitle:[self.array objectAtIndex:section] forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    // add targets and actions
    [button addTarget:self action:@selector(pusher:) forControlEvents:UIControlEventTouchUpInside];
    [button setTag:section];
    return button;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.array count];
}

#pragma mark - Menu functions

-(void)openCashMenu{
    self.rowCountCash += 5;
    NSArray *paths = [[NSArray alloc] initWithObjects:
                      [NSIndexPath indexPathForRow:0 inSection:1],
                      [NSIndexPath indexPathForRow:1 inSection:1],
                      [NSIndexPath indexPathForRow:2 inSection:1],
                      [NSIndexPath indexPathForRow:3 inSection:1],
                      [NSIndexPath indexPathForRow:4 inSection:1],
                      nil];
    [self.filtersTableView beginUpdates];
    [self.filtersTableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationMiddle];
    [self.filtersTableView endUpdates];
}
-(void)openCuisineMenu{
    self.rowCountCuisine += 7;
    NSArray *paths = [[NSArray alloc] initWithObjects:
                      [NSIndexPath indexPathForRow:0 inSection:2],
                      [NSIndexPath indexPathForRow:1 inSection:2],
                      [NSIndexPath indexPathForRow:2 inSection:2],
                      [NSIndexPath indexPathForRow:3 inSection:2],
                      [NSIndexPath indexPathForRow:4 inSection:2],
                      [NSIndexPath indexPathForRow:5 inSection:2],
                      [NSIndexPath indexPathForRow:6 inSection:2],
                      nil];
    [self.filtersTableView beginUpdates];
    [self.filtersTableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationMiddle];
    [self.filtersTableView endUpdates];
    
}
-(void)openMenuMenu{
    self.rowCountMenu += 7;
    NSArray *paths = [[NSArray alloc] initWithObjects:
                      [NSIndexPath indexPathForRow:0 inSection:3],
                      [NSIndexPath indexPathForRow:1 inSection:3],
                      [NSIndexPath indexPathForRow:2 inSection:3],
                      [NSIndexPath indexPathForRow:3 inSection:3],
                      [NSIndexPath indexPathForRow:4 inSection:3],
                      [NSIndexPath indexPathForRow:5 inSection:3],
                      [NSIndexPath indexPathForRow:6 inSection:3],
                      nil];
    [self.filtersTableView beginUpdates];
    [self.filtersTableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationMiddle];
    [self.filtersTableView endUpdates];
    
}

-(void)closeCashMenu{
    self.rowCountCash -= 5;
    NSArray *paths = [[NSArray alloc] initWithObjects:
                      [NSIndexPath indexPathForRow:0 inSection:1],
                      [NSIndexPath indexPathForRow:1 inSection:1],
                      [NSIndexPath indexPathForRow:2 inSection:1],
                      [NSIndexPath indexPathForRow:3 inSection:1],
                      [NSIndexPath indexPathForRow:4 inSection:1],
                      nil];
    [self.filtersTableView beginUpdates];
    [self.filtersTableView deleteRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationMiddle];
    [self.filtersTableView endUpdates];
    
}
-(void)closeCuisineMenu{
    self.rowCountCuisine -= 7;
    NSArray *paths = [[NSArray alloc] initWithObjects:
                      [NSIndexPath indexPathForRow:0 inSection:2],
                      [NSIndexPath indexPathForRow:1 inSection:2],
                      [NSIndexPath indexPathForRow:2 inSection:2],
                      [NSIndexPath indexPathForRow:3 inSection:2],
                      [NSIndexPath indexPathForRow:4 inSection:2],
                      [NSIndexPath indexPathForRow:5 inSection:2],
                      [NSIndexPath indexPathForRow:6 inSection:2],
                      nil];
    [self.filtersTableView beginUpdates];
    [self.filtersTableView deleteRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationMiddle];
    [self.filtersTableView endUpdates];
    
}
-(void)closeMenuMenu{
    self.rowCountMenu -= 7;
    NSArray *paths = [[NSArray alloc] initWithObjects:
                      [NSIndexPath indexPathForRow:0 inSection:3],
                      [NSIndexPath indexPathForRow:1 inSection:3],
                      [NSIndexPath indexPathForRow:2 inSection:3],
                      [NSIndexPath indexPathForRow:3 inSection:3],
                      [NSIndexPath indexPathForRow:4 inSection:3],
                      [NSIndexPath indexPathForRow:5 inSection:3],
                      [NSIndexPath indexPathForRow:6 inSection:3],
                      nil];
    [self.filtersTableView beginUpdates];
    [self.filtersTableView deleteRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationMiddle];
    [self.filtersTableView endUpdates];
    
}

-(void)pusher:(UIButton *)Sender{
    NSUInteger section = Sender.tag;
    if(section == 0){
        [self.checkedData removeAllObjects];
        [self.filtersTableView  reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.array.count)] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if(section == 1){
        if (OPENED_CASH == YES)
            [self closeCashMenu];
        else
            [self openCashMenu];
        OPENED_CASH = !OPENED_CASH;
    }
    else if( section == 2 ){
        if (OPENED_Cuisine == YES)
            [self closeCuisineMenu];
        else
            [self openCuisineMenu];
        OPENED_Cuisine = !OPENED_Cuisine;
    }
    else if( section == 3 ){
        if (OPENED_MENU == YES)
            [self closeMenuMenu];
        else{
            [self openMenuMenu];
//Этот кусок в последнюю секцию. Чтобы при раскрытии последней секции было видно, что она раскрылась!
            [self.filtersTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:section]
                                         atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        }
        OPENED_MENU = !OPENED_MENU;
    }
}

#pragma mark - cell settings

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = nil;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor blackColor];
        cell.textLabel.textColor = [UIColor whiteColor];
        if(indexPath.section == 1)
            cell.textLabel.text = [self.expandArrayCash objectAtIndex:[indexPath row]];
        else if (indexPath.section == 2)
            cell.textLabel.text = [self.expandArrayCuisine objectAtIndex:[indexPath row]];
        else if(indexPath.section == 3)
            cell.textLabel.text = [self.expandArrayMenu objectAtIndex:[indexPath row]];
    }
    
    //    cell.backgroundView = [InterfaceFunctions CellBG];
    //    cell.selectedBackgroundView = [InterfaceFunctions SelectedCellBG];
    
    
    // Галочки для фильтров:
    if([self.checkedData containsObject:indexPath]){
        //    cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.contentView.backgroundColor = [UIColor purpleColor];
        //cell.highlighted = YES;
    }else{
        cell.contentView.backgroundColor = [UIColor blackColor];
        //cell.accessoryType = UITableViewCellAccessoryNone;
        // cell.selected = NO;
        //cell.highlighted = NO;
    }
    return cell;
}
#pragma mark - Table view delegate

-(void)customCellSelectionAnimation:(NSIndexPath *)indexPath{
    UITableViewCell *selectedCell = [self.filtersTableView cellForRowAtIndexPath:indexPath];
    CGRect frame = selectedCell.frame;
    
    frame.origin.x = 400;
    
    [UIView animateWithDuration:0.15 animations:^{
        selectedCell.frame = frame;
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            CGRect theFrame = selectedCell.frame;
            theFrame.origin.x = 0;
            selectedCell.frame = theFrame;
            if([self.checkedData containsObject:indexPath])
                selectedCell.contentView.backgroundColor = [UIColor purpleColor];
            else
                selectedCell.contentView.backgroundColor = [UIColor blackColor];
        }];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    self.filtersTableView.allowsMultipleSelection = YES;
    
    if([self.checkedData containsObject:indexPath]){
        [self.checkedData removeObject:indexPath];      // убираем снятый фильтр
    } else {
        [self.checkedData addObject:indexPath];         // добавляем выбранный фильтр
    }
//  Custom animation
    [self customCellSelectionAnimation:indexPath];
    
//  Cool but slow animation
    //NSArray* rowsToReload = [NSArray arrayWithObjects:indexPath, nil];
    //[tableView reloadRowsAtIndexPaths:rowsToReload withRowAnimation:UITableViewRowAnimationFade];
   
//  Without animation
    //[tableView reloadData];
}

@end
