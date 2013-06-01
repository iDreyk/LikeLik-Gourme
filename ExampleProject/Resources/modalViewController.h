//
//  modalViewController.h
//  MKDSlideViewController
//
//  Created by Ilya on 31.05.13.
//
//

#import <UIKit/UIKit.h>

@interface modalViewController : UIViewController
@property (nonatomic, retain) IBOutlet UITextView * textView;

- (IBAction)showMenu:(id)sender;
- (IBAction)close:(id)sender;
- (void)setDetailText:(NSString *)detailText;

@end
