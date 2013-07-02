//
//  thirdViewController.m
//  MKDSlideViewController
//
//  Created by Ilya on 20.05.13.
//
//

#import "thirdViewController.h"
#import "MKDSlideViewController.h"
#import "UIViewController+MKDSlideViewController.h"


@implementation thirdViewController
@synthesize settingsTableView;
@synthesize storedData;
- (IBAction)showMenu:(id)sender
{
    // Use the UIViewController (MKDSlideViewController) category as a helper
    [self.navigationController.slideViewController callLeftMenu];
    //[self.navigationController.slideViewController showLeftViewControllerAnimated:YES];
}

#pragma mark - Table view delegate

- (void)viewDidLoad{
    self.array =         [[NSArray alloc] initWithArray:@[@"setting 1", @"setting 2", @"setting 3", @"setting 4"]];
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //button.backgroundColor = [UIColor blackColor];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    button.frame = CGRectMake(10, 20, 200, 50); // position in the parent view and set the size of the button
    [button setTitle:[self.array objectAtIndex:section] forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    // add targets and actions
    [button addTarget:self action:@selector(pusher:) forControlEvents:UIControlEventTouchUpInside];
    [button setTag:section];
    return button;
}

-(void)pusher:(UIButton *)Sender{
//    NSUInteger row = Sender.tag;
//    if(row == 0){
//        if (OPENED_CASH == YES){
//            self.rowCountCash -= 5;
//            NSArray *paths = [[NSArray alloc] initWithObjects:
//                              [NSIndexPath indexPathForRow:0 inSection:0],
//                              [NSIndexPath indexPathForRow:1 inSection:0],
//                              [NSIndexPath indexPathForRow:2 inSection:0],
//                              [NSIndexPath indexPathForRow:3 inSection:0],
//                              [NSIndexPath indexPathForRow:4 inSection:0],
//                              nil];
//            [self.tableView beginUpdates];
//            [self.tableView deleteRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationMiddle];
//            [self.tableView endUpdates];
//        }
//        else{
//            self.rowCountCash += 5;
//            NSArray *paths = [[NSArray alloc] initWithObjects:
//                              [NSIndexPath indexPathForRow:0 inSection:0],
//                              [NSIndexPath indexPathForRow:1 inSection:0],
//                              [NSIndexPath indexPathForRow:2 inSection:0],
//                              [NSIndexPath indexPathForRow:3 inSection:0],
//                              [NSIndexPath indexPathForRow:4 inSection:0],
//                              nil];
//            [self.tableView beginUpdates];
//            [self.tableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationMiddle];
//            [self.tableView endUpdates];
//        }
//        OPENED_CASH = !OPENED_CASH;
//        
//    }
//    else if( row == 1 )
//    {
//        if (OPENED_COUSINE == YES){
//            self.rowCountCousine -= 7;
//            NSArray *paths = [[NSArray alloc] initWithObjects:
//                              [NSIndexPath indexPathForRow:0 inSection:1],
//                              [NSIndexPath indexPathForRow:1 inSection:1],
//                              [NSIndexPath indexPathForRow:2 inSection:1],
//                              [NSIndexPath indexPathForRow:3 inSection:1],
//                              [NSIndexPath indexPathForRow:4 inSection:1],
//                              [NSIndexPath indexPathForRow:5 inSection:1],
//                              [NSIndexPath indexPathForRow:6 inSection:1],
//                              nil];
//            [self.tableView beginUpdates];
//            [self.tableView deleteRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationMiddle];
//            [self.tableView endUpdates];
//        }
//        else{
//            self.rowCountCousine += 7;
//            NSArray *paths = [[NSArray alloc] initWithObjects:
//                              [NSIndexPath indexPathForRow:0 inSection:1],
//                              [NSIndexPath indexPathForRow:1 inSection:1],
//                              [NSIndexPath indexPathForRow:2 inSection:1],
//                              [NSIndexPath indexPathForRow:3 inSection:1],
//                              [NSIndexPath indexPathForRow:4 inSection:1],
//                              [NSIndexPath indexPathForRow:5 inSection:1],
//                              [NSIndexPath indexPathForRow:6 inSection:1],
//                              nil];
//            [self.tableView beginUpdates];
//            [self.tableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationMiddle];
//            [self.tableView endUpdates];
//        }
//        OPENED_COUSINE = !OPENED_COUSINE;
//        
//    }
//    else if( row == 2 ){
//        if (OPENED_MENU == YES){
//            self.rowCountMenu -= 7;
//            NSArray *paths = [[NSArray alloc] initWithObjects:
//                              [NSIndexPath indexPathForRow:0 inSection:2],
//                              [NSIndexPath indexPathForRow:1 inSection:2],
//                              [NSIndexPath indexPathForRow:2 inSection:2],
//                              [NSIndexPath indexPathForRow:3 inSection:2],
//                              [NSIndexPath indexPathForRow:4 inSection:2],
//                              [NSIndexPath indexPathForRow:5 inSection:2],
//                              [NSIndexPath indexPathForRow:6 inSection:2],
//                              nil];
//            [self.tableView beginUpdates];
//            [self.tableView deleteRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationMiddle];
//            [self.tableView endUpdates];
//        }
//        else{
//            self.rowCountMenu += 7;
//            NSArray *paths = [[NSArray alloc] initWithObjects:
//                              [NSIndexPath indexPathForRow:0 inSection:2],
//                              [NSIndexPath indexPathForRow:1 inSection:2],
//                              [NSIndexPath indexPathForRow:2 inSection:2],
//                              [NSIndexPath indexPathForRow:3 inSection:2],
//                              [NSIndexPath indexPathForRow:4 inSection:2],
//                              [NSIndexPath indexPathForRow:5 inSection:2],
//                              [NSIndexPath indexPathForRow:6 inSection:2],
//                              nil];
//            [self.tableView beginUpdates];
//            [self.tableView insertRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationMiddle];
//            [self.tableView endUpdates];
//        }
//        OPENED_MENU = !OPENED_MENU;
//    }
//    
//    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.array count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = nil;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //    cell.backgroundView = [InterfaceFunctions CellBG];
    //    cell.selectedBackgroundView = [InterfaceFunctions SelectedCellBG];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = [self.array objectAtIndex:[indexPath row]];
//    cell.backgroundColor = [UIColor blackColor];
//    cell.textLabel.textColor = [UIColor whiteColor];
//    if(indexPath.section == 0)
//        cell.textLabel.text = [self.expandArrayCash objectAtIndex:[indexPath row]];
//    else if (indexPath.section == 1)
//        cell.textLabel.text = [self.expandArrayCousine objectAtIndex:[indexPath row]];
//    else if(indexPath.section == 2)
//        cell.textLabel.text = [self.expandArrayMenu objectAtIndex:[indexPath row]];
//    
    
    // Галочки для фильтров:
    if([self.storedData containsObject:indexPath])
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    else
        cell.accessoryType = UITableViewCellAccessoryNone;
    
    return cell;
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    self.tableView.allowsMultipleSelection = YES;
    
//    if([self.storedData containsObject:indexPath]){
//        [self.storedData removeObject:indexPath];      // убираем снятый фильтр
//    } else {
//        [self.storedData addObject:indexPath];         // добавляем выбранный фильтр
//    }
    
   // [tableView reloadData];
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end


