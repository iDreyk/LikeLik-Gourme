//
//  CheckViewController.h
//  TabBar
//
//  Created by Vladimir Malov on 22.03.13.
//  Copyright (c) 2013 LikeLik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarReaderViewController.h"
#import "ZBarReaderView.h"
#import "ZBarSDK.h"
#import "SubText.h"
@interface CheckViewController : UIViewController <ZBarReaderDelegate,UIGestureRecognizerDelegate,MBProgressHUDDelegate>{
    UIImageView *resultImage;
    UITextView *resultText;
    NSString *PlaceName;
    NSString *PlaceCategory;
    NSString *PlaceCity;
    NSString *QRString;
    NSInteger ribbon;
    UIColor *color;
    SubText *label1;
}
@property (weak, nonatomic) IBOutlet UIImageView *Check_bg;
@property (weak, nonatomic) IBOutlet UIButton *activate;
@property (weak, nonatomic) IBOutlet UIButton *cancel;
@property (nonatomic, strong) IBOutlet UITextView *resultText;
@property (nonatomic, strong) IBOutlet UIImageView *resultImage;
@property (nonatomic, strong)NSString *PlaceName;
@property (nonatomic, strong)NSString *PlaceCategory;
@property (nonatomic, strong)NSString *PlaceCity;
@property (nonatomic, strong)NSString *QRString;
@property (weak, nonatomic) IBOutlet UIView *CheckView;
@property (weak, nonatomic) IBOutlet UILabel *Label;
@property (weak, nonatomic) IBOutlet UILabel *ExclusiveOffer;
@property (weak, nonatomic) IBOutlet UILabel *forEnglish;
@property (weak, nonatomic) IBOutlet UIButton *foreignLanguage;
@property (weak, nonatomic) IBOutlet UIScrollView *Offer;
@property (weak, nonatomic) IBOutlet UIImageView *fistbackground;
@property (nonatomic, strong)SubText *label1;
@property (nonatomic, strong)UILabel *alreadyuse;
@property (weak, nonatomic) IBOutlet UIImageView *gradientunderbutton;
@property (weak, nonatomic) IBOutlet UIImageView *ribbonimage;
@property (weak, nonatomic) IBOutlet UIImageView *check_background;
@property (nonatomic,strong)UIColor *color;
-(IBAction)showQR:(id)sender;
-(IBAction)CloseCheck:(id)sender;
-(IBAction)foreignLanguage:(id)sender;
-(void)UnlockwithText:(NSString *)string;
//-(IBAction)showRegistrationMessage:(id)sender;
@end
