//
//  RegistrationViewController.m
//  TabBar
//
//  Created by Vladimir Malov on 20.02.13.
//  Copyright (c) 2013 LikeLik. All rights reserved.
//

#import "Account.h"
//#import "SCFacebook.h"
#import <FacebookSDK/FacebookSDK.h>
#import "AppDelegate.h"
#import "AFHTTPClient.h"
//#import "SA_OAuthTwitterEngine.h"
#import "AFJSONRequestOperation.h"
#import "RegistrationViewController.h"

#define kOAuthConsumerKey				@"XGaxa31EoympFhxLZooQ"
#define kOAuthConsumerSecret			@"IbUE5lud22evmrtxjtU1vKvh6VDqRMSHHFJ73rtHI"
static BOOL getLocation = NO;

#define RemoveNull(field) ([[self.FacebookUserInfo objectForKey:field] isKindOfClass:[NSNull class]]) ? @"" : [self.FacebookUserInfo objectForKey:field];
@interface RegistrationViewController ()

@end

@implementation RegistrationViewController
@synthesize Login,Password,Email,Confirm,Switch,BirthDayPicker;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    if (!appDelegate.session.isOpen) {
        // create a fresh session object
        appDelegate.session = [[FBSession alloc] init];
        
        // if we don't have a cached token, a call to open here would cause UX for login to
        // occur; we don't want that to happen unless the user clicks the login button, and so
        // we check here to make sure we have a token before calling open
        if (appDelegate.session.state == FBSessionStateCreatedTokenLoaded) {
            // even though we had a cached token, we need to login to make the session usable
            [appDelegate.session openWithCompletionHandler:^(FBSession *session,
                                                             FBSessionState status,
                                                             NSError *error) {
            }];
        }
    }
    
    
    if ([self.LorR isEqualToString:@"Login"]){
        array = @[@"E-mail",@"Password"];
        self.Switch.hidden = YES;
        self.SurpriseText.hidden = YES;
    }
    else
        array = @[@"Name",@"E-Mail",@"Password",@"Password"];
  
    [self setlocale];
    
    self.navigationItem.titleView = [InterfaceFunctions NavLabelwithTitle:AMLocalizedString(@"Registration", nil) AndColor:[InterfaceFunctions corporateIdentity]];
    self.navigationItem.backBarButtonItem = [InterfaceFunctions back_button];
    [self.RegistrationTable setBackgroundColor:[UIColor clearColor]];
    self.view.backgroundColor = [InterfaceFunctions BackgroundColor];
    self.RegistrationTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    

    
    [self.SurpriseText setText: AMLocalizedString(@"I want to receive gifts on my birthday", nil)];
    
    NSLocale * locale;
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"Language"] isEqualToString:@"Русский"])
        locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ru_RU"];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"Language"] isEqualToString:@"English"])
        locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_EN"];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"Language"] isEqualToString:@"Deutsch"])
        locale = [[NSLocale alloc] initWithLocaleIdentifier:@"de_DE"];
    
    BirthDayPicker.locale = locale;
    BirthDayPicker.calendar = [locale objectForKey:NSLocaleCalendar];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateStyle = NSDateFormatterMediumStyle;
    [BirthDayPicker addTarget:self
                       action:@selector(getDate:)
             forControlEvents:UIControlEventValueChanged];
    
    day = @"1";
    month = @"1";
    year = @"1912";
    
//    _vkontakte = [Vkontakte sharedInstance];
//    _vkontakte.delegate = self;
//    
    
    
    [self HUDemailincorrect];
    [self HUDpassincorrect];
    [self HUDDone];
    [self HUDFade];
    [self HUDerror];
    
    locationManager = [[CLLocationManager alloc] init];
    [locationManager setDelegate:self];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locationManager startUpdatingLocation];
    
    
    float currSysVer = [[UIDevice currentDevice] systemVersion].floatValue;

    if (currSysVer >= 7.0) {
        NSLayoutConstraint * topMarginForTable  =[NSLayoutConstraint
                                                  constraintWithItem:self.RegistrationTable
                                                  attribute:NSLayoutAttributeTop
                                                  relatedBy:NSLayoutRelationEqual
                                                  toItem:self.view
                                                  attribute:NSLayoutAttributeTop
                                                  multiplier:1.0
                                                  constant:22];
        
        [self.view addConstraint:topMarginForTable];
        
        NSLayoutConstraint * topMarginForSurprise =[NSLayoutConstraint
                                                    constraintWithItem:self.SurpriseText
                                                    attribute:NSLayoutAttributeTop
                                                    relatedBy:NSLayoutRelationEqual
                                                    toItem:self.view
                                                    attribute:NSLayoutAttributeTop
                                                    multiplier:1.0
                                                    constant:240];
        
        [self.view addConstraint:topMarginForSurprise];
        NSLayoutConstraint * topMarginForSwitch =[NSLayoutConstraint
                                                  constraintWithItem:self.Switch
                                                  attribute:NSLayoutAttributeTop
                                                  relatedBy:NSLayoutRelationEqual
                                                  toItem:self.view
                                                  attribute:NSLayoutAttributeTop
                                                  multiplier:1.0
                                                  constant:248];
        
        [self.view addConstraint:topMarginForSwitch];
    }
    else {
        NSLayoutConstraint * topMarginForTable  =[NSLayoutConstraint
                                                  constraintWithItem:self.RegistrationTable
                                                  attribute:NSLayoutAttributeTop
                                                  relatedBy:NSLayoutRelationEqual
                                                  toItem:self.view
                                                  attribute:NSLayoutAttributeTop
                                                  multiplier:1.0
                                                  constant:0];
        
        [self.view addConstraint:topMarginForTable];
        
        NSLayoutConstraint * topMarginForSurprise =[NSLayoutConstraint
                                                    constraintWithItem:self.SurpriseText
                                                    attribute:NSLayoutAttributeTop
                                                    relatedBy:NSLayoutRelationEqual
                                                    toItem:self.view
                                                    attribute:NSLayoutAttributeTop
                                                    multiplier:1.0
                                                    constant:218];
        
        [self.view addConstraint:topMarginForSurprise];
        NSLayoutConstraint * topMarginForSwitch =[NSLayoutConstraint
                                                  constraintWithItem:self.Switch
                                                  attribute:NSLayoutAttributeTop
                                                  relatedBy:NSLayoutRelationEqual
                                                  toItem:self.view
                                                  attribute:NSLayoutAttributeTop
                                                  multiplier:1.0
                                                  constant:226];
        
        [self.view addConstraint:topMarginForSwitch];
  
    }
    self.Switch.tintColor = [UIColor whiteColor];
    if (currSysVer >= 7.0) {
            CGRect frame = self.BirthDayPicker.frame;
            frame.origin.y = 1136;
            frame.origin.x = 0;
            _switchfix = [[UIView alloc] init];
            _switchfix.frame = frame;
            _switchfix.backgroundColor = [InterfaceFunctions BackgroundColor];
            [self.view addSubview:_switchfix];
    }
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
}

-(void)setlocale{
    self.lang = [[NSString alloc] init];
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"Language"] isEqualToString:@"Русский"])
        self.lang = @"ru";
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"Language"] isEqualToString:@"English"])
        self.lang = @"en";
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"Language"] isEqualToString:@"Deutsch"])
        self.lang = @"de";
    
}


#pragma mark - work with xib
-(void)afterFacebook{
    self.navigationController.navigationBar.hidden= NO;
}

-(IBAction)switchtoPicker:(id)sender{
    if (Switch.on) {
        float currSysVer = [[UIDevice currentDevice] systemVersion].floatValue;
        if ((currSysVer == 7.0) || (currSysVer > 7.0)) {
            [UIView animateWithDuration:0.3 animations:^{
                CGRect frame = self.BirthDayPicker.frame;
                frame.origin.y += 20;
                _switchfix.frame = frame;
            }completion:^(BOOL finished){
                [self.view bringSubviewToFront:self.BirthDayPicker];
                self.BirthDayPicker.hidden = NO;
            }];
        }
        else {
            self.BirthDayPicker.hidden = NO;
        }
    }
    else{
        float currSysVer = [[UIDevice currentDevice] systemVersion].floatValue;
        if ((currSysVer == 7.0) || (currSysVer > 7.0)) {
            [UIView animateWithDuration:0.3 animations:^{
                CGRect frame = self.BirthDayPicker.frame;
                frame.origin.y = 1136;
                _switchfix.frame = frame;
                 self.BirthDayPicker.hidden = YES;
                day = @"1";
                month = @"1";
                year = @"1912";
            }];
        }
        else {
            
            self.BirthDayPicker.hidden = YES;
            day = @"1";
            month = @"1";
            year = @"1912";
        }
    }
    [self.Login resignFirstResponder];
    [self.Email resignFirstResponder];
    [self.Password resignFirstResponder];
    [self.Confirm resignFirstResponder];
    
}

-(void) dismissView:(id)Sender{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

-(IBAction)SocialClicked:(UIButton *)sender{
    [self.HUDfade show:YES];
    [self.HUDfade hide:YES afterDelay:2];
   // [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    if (sender.tag == 0) {
        // NSLog(@"Fb");
        loadingView.hidden = NO;
        
//        [SCFacebook loginCallBack:^(BOOL success, id result) {
//            loadingView.hidden = YES;
//            if (success)
//                [self getUserInfo];
//            else
//                [self HUDgoeswrong];
//        }];
        
        AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
        
        // this button's job is to flip-flop the session from open to closed
        if (appDelegate.session.isOpen) {
            // if a user logs out explicitly, we delete any cached token information, and next
            // time they run the applicaiton they will be presented with log in UX again; most
            // users will simply close the app or switch away, without logging out; this will
            // cause the implicit cached-token login to occur on next launch of the application
            [appDelegate.session closeAndClearTokenInformation];
            
        } else {
            if (appDelegate.session.state != FBSessionStateCreated) {
                // Create a new, logged out session.
                [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
                NSLog(@"1");
                appDelegate.session = [[FBSession alloc] init];
                                NSLog(@"2");
            }
            
            // if the session isn't open, let's open it now and present the login UX to the user
            [appDelegate.session openWithCompletionHandler:^(FBSession *session,
                                                             FBSessionState status,
                                                             NSError *error) {
                                NSLog(@"3");
                [FBSession setActiveSession: session];
                // and here we make sure to update our UX according to the new session state
                if(status == FBSessionStateClosedLoginFailed){
                    NSLog(@"FB LOG: status is %d", status);
                    NSLog(@"FBSessionStateClosedLoginFailed");
                }
                else{
                    NSLog(@"FB LOG: status is %d", status);
                    [self getUserInfo];
                    //NSLog(@"LOGGED IN WITH FB! ActiveSession: %@", [FBSession activeSession]);
                    [FBSession setActiveSession:session];
                    [self.HUDdone show:YES];
                    [self.HUDdone hide:YES afterDelay:1];
                    [self performSelector:@selector(dismissView:) withObject:nil afterDelay:1.0];
                }
                NSLog(@"4");
                [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            }];
        }

        
    }
//    if (sender.tag == 1) {
//        [self loginPressed:sender];
//    }
//    if (sender.tag == 2) {
//        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
//        self.Parent = @"Social";
//        if (_engine){
//            [[NSUserDefaults standardUserDefaults] setObject:[[[[[[NSUserDefaults standardUserDefaults] objectForKey: @"authData"] componentsSeparatedByString:@"screen_name="]objectAtIndex:1] componentsSeparatedByString:@"&"]objectAtIndex:0] forKey:@"tw_name"];
//            [[NSUserDefaults standardUserDefaults] setObject:[[[[[[NSUserDefaults standardUserDefaults] objectForKey: @"authData"] componentsSeparatedByString:@"user_id="]objectAtIndex:1] componentsSeparatedByString:@"&"]objectAtIndex:0] forKey:@"tw_id"];
//            [self SendRegistration:@"TW"];
//            return;
//            
//        }
//        
//        _engine = [[SA_OAuthTwitterEngine alloc] initOAuthWithDelegate: self];
//        _engine.consumerKey = kOAuthConsumerKey;
//        _engine.consumerSecret = kOAuthConsumerSecret;
//        UIViewController			*controller = [SA_OAuthTwitterController controllerToEnterCredentialsWithTwitterEngine: _engine delegate: self];
//        if (controller){
//        //    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
//            [self presentViewController:controller animated:YES completion:^{[[UIApplication sharedApplication] endIgnoringInteractionEvents];}];
//        }
//        else{
//            self.twitterName = [[[[[[NSUserDefaults standardUserDefaults] objectForKey: @"authData"] componentsSeparatedByString:@"screen_name="]objectAtIndex:1] componentsSeparatedByString:@"&"]objectAtIndex:0];
//            
//            self.twitterid =[[[[[[NSUserDefaults standardUserDefaults] objectForKey: @"authData"] componentsSeparatedByString:@"user_id="]objectAtIndex:1] componentsSeparatedByString:@"&"]objectAtIndex:0];
//            [self SendRegistration:@"TW"];
//        }
//    }
}




-(void)Done{
    [Password resignFirstResponder];
    [Login resignFirstResponder];
    [Email resignFirstResponder];
    [Confirm resignFirstResponder];
    if (![self.LorR isEqualToString:@"Login"]) {
        if ([Password.text isEqualToString:Confirm.text]) {
            if ([self validateMail:Email.text] == YES){
                [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
                [self SendRegistration:@"Self"];
            }
            else{
                [self.HUDemailcheck show:YES];
                [self.HUDemailcheck hide:YES afterDelay:2];
            }
        }
        else{
            [self.HUDpassword show:YES];
            [self.HUDpassword hide:YES afterDelay:2];
            
        }
    }
    else{
        [Email resignFirstResponder];
        [Password resignFirstResponder];
        if ([self validateMail:Email.text] == YES) {
            if ([self validateMail:Email.text] == YES)
                [self SendRegistration:@"Self"];
            
            else{
                [self.HUDemailcheck show:YES];
                [self.HUDemailcheck hide:YES afterDelay:2];
            }
        }
    }
}

-(void)buttononnav{
    UIButton *btn = [InterfaceFunctions done_button];
    [btn addTarget:self action:@selector(Done) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = nil;//@"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (![self.LorR isEqualToString:@"Login"]) {
        if ([indexPath row] == 0) {
            [self LoginTextField];
            [cell.contentView addSubview:Login];
        }
        if ([indexPath row] == 1) {
            [self EmailTextField];
            [cell.contentView addSubview:Email];
        }
        if ([indexPath row] == 2) {
            [self PasswordTextField];
            [cell.contentView addSubview:Password];
        }
        
        if ([indexPath row] == 3) {
            [self ConfirmTextField];
            [cell.contentView addSubview:Confirm];
        }
        
    }
    else{
        if ([indexPath row] == 0) {
            [self EmailTextField];
            [cell.contentView addSubview:Email];
        }
        if ([indexPath row] == 1) {
            [self PasswordTextField];
            [cell.contentView addSubview:Password];
        }
        
    }
        
    cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"table_grad.png"]];
    cell.textLabel.text = AMLocalizedString([array objectAtIndex:[indexPath row]], nil);
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0;
    
}

#pragma mark - Table view delegate

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



#pragma  mark - HUD's
-(void)HUDemailincorrect{
    self.HUDemailcheck = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:self.HUDemailcheck];
    self.HUDemailcheck.mode = MBProgressHUDModeCustomView;
    self.HUDemailcheck.customView = [InterfaceFunctions LabelHUDwithString:AMLocalizedString(@"сheck e-mail please", nil)];
    self.HUDemailcheck.delegate = self;
    
}

-(void)HUDpassincorrect{
    
    self.HUDpassword = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:self.HUDpassword];
    self.HUDpassword.userInteractionEnabled = NO;
    self.HUDpassword.mode = MBProgressHUDModeCustomView;
    self.HUDpassword.customView = [InterfaceFunctions LabelHUDwithString:AMLocalizedString(@"passwords do not match", nil)];
    self.HUDpassword.delegate = self;
    
}

-(void)HUDDone{
    
    self.HUDdone = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:self.HUDdone];
    self.HUDdone.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"74_74 Fist_for_HUD_colored"]];
    self.HUDdone.mode = MBProgressHUDModeCustomView;
    self.HUDdone.delegate = self;
    self.HUDdone.labelText = AMLocalizedString(@"Done", nil);

    
}

-(void)HUDFade{
    self.HUDfade = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:self.HUDfade];
    self.HUDfade.userInteractionEnabled = NO;
    self.HUDfade.mode = MBProgressHUDAnimationFade;
    self.HUDfade.delegate = self;
    
}

-(void)HUDError{
    self.HUDerror = [[MBProgressHUD alloc] initWithView:self.view];
    [self.navigationController.view addSubview:self.HUDerror];
    self.HUDerror.mode = MBProgressHUDModeCustomView;
    self.HUDerror.delegate = self;

    
}

-(void)HUDGoesWrong{
    self.HUDgoeswrong = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:self.HUDgoeswrong];
    self.HUDgoeswrong.mode = MBProgressHUDModeCustomView;
    self.HUDgoeswrong.removeFromSuperViewOnHide = YES;
    self.HUDgoeswrong.customView = [InterfaceFunctions LabelHUDwithString:AMLocalizedString(@"Something goes wrong", nil)];
    self.HUDgoeswrong.delegate = self;
    [self.HUDgoeswrong show:YES];
    [self.HUDgoeswrong hide:YES afterDelay:2];
}

-(NSString *)HUDStringLocalized:(id)JSON{

    if ([[[JSON objectForKey:@"Error"]objectForKey:@"message"] isEqual:[NSNull null]] || [[[JSON objectForKey:@"Error"]objectForKey:@"message"] length] == 0) {
        return AMLocalizedString(@"Something goes wrong", nil);
    }
    return [[JSON objectForKey:@"Error"]objectForKey:@"message"];
}


#pragma mark UITextField
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.text = @"";
    self.navigationItem.rightBarButtonItem.enabled = NO;
    self.BirthDayPicker.hidden = YES;
    float currSysVer = [[UIDevice currentDevice] systemVersion].floatValue;
    if ((currSysVer == 7.0) || (currSysVer > 7.0)) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = self.BirthDayPicker.frame;
            frame.origin.y = 1136;
            _switchfix.frame = frame;
        }];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if ([Login.text length]>0 && [Email.text length]>0 &&[Password.text length]>0 && [Confirm.text length]>0  ) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
    else{
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (![self.LorR isEqualToString:@"Login"]) {
        if ([textField isEqual:Login]) {
            [Login resignFirstResponder];
            [Email becomeFirstResponder];
        }
        if ([textField isEqual:Email]) {
            [Email resignFirstResponder];
            [Password becomeFirstResponder];
        }
        
        if ([textField isEqual:Password]) {
            [Password resignFirstResponder];
            [Confirm becomeFirstResponder];
        }
        
        if ([textField isEqual:Confirm]) {
            [Confirm resignFirstResponder];
            if ([Login.text length]>0 && [Email.text length]>0 &&[Password.text length]>0 && [Confirm.text length]>0  ) {
                self.navigationItem.rightBarButtonItem.enabled = YES;
                [self Done];
            }
            else{
                self.navigationItem.rightBarButtonItem.enabled = NO;
            }
        }
    }
    else{
        if ([textField isEqual:Email]) {
            [Email resignFirstResponder];
            [Password becomeFirstResponder];
        }
        
        if ([textField isEqual:Password]) {
            [Password resignFirstResponder];
            if ( [Email.text length]>0 &&[Password.text length]>0 ) {
                self.navigationItem.rightBarButtonItem.enabled = YES;
                [self Done];
            }
            else{
                self.navigationItem.rightBarButtonItem.enabled = NO;
            }
        }
    }
    
    return YES;
}


-(void)LoginTextField{
    
    float dist;
    if ([[UIDevice currentDevice] systemVersion].floatValue >= 7.0) {
        dist = 5;
    }
    else{
        dist = 10;
    }
    Login=[[UITextField alloc] initWithFrame:CGRectMake(100, dist, 200, 35)];
    [Login addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    Login.delegate = self;
    Login.autocorrectionType = UITextAutocorrectionTypeNo;
    Login.tag=0;
    Login.placeholder = AMLocalizedString(@"Name", nil);
    Login.returnKeyType = UIReturnKeyNext;
    Login.text = @"";
}


-(void)EmailTextField{
    float dist;
    if ([[UIDevice currentDevice] systemVersion].floatValue >= 7.0) {
        dist = 5;
    }
    else{
        dist = 10;
    }
    Email =[[UITextField alloc] initWithFrame:CGRectMake(100, dist, 200, 35)];
    [Email addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    Email.delegate = self;
    Email.autocorrectionType = UITextAutocorrectionTypeNo;
    Email.tag=1;
    Email.placeholder = AMLocalizedString(@"E-mail", nil);
    Email.keyboardType = UIKeyboardTypeEmailAddress;
    Email.returnKeyType = UIReturnKeyNext;
    Email.text = @"";
}


-(void)PasswordTextField{
    float dist;
    if ([[UIDevice currentDevice] systemVersion].floatValue >= 7.0) {
        dist = 5;
    }
    else{
        dist = 10;
    }
    Password = [[UITextField alloc] initWithFrame:CGRectMake(100, dist, 200, 35)];
    [Password addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    Password.delegate = self;
    Password.autocorrectionType = UITextAutocorrectionTypeNo;
    Password.tag=2;
    Password.placeholder = AMLocalizedString(@"Password", nil);
    Password.secureTextEntry = YES;
    Password.text = @"";
    Password.returnKeyType = UIReturnKeyNext;
}


-(void)ConfirmTextField{
    float dist;
    if ([[UIDevice currentDevice] systemVersion].floatValue >= 7.0) {
        dist = 5;
    }
    else{
        dist = 10;
    }
    Confirm = [[UITextField alloc] initWithFrame:CGRectMake(100, dist, 200, 35)];
    Confirm.delegate = self;
    [Confirm addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    Confirm.autocorrectionType = UITextAutocorrectionTypeNo;
    Confirm.tag=3;
    Confirm.placeholder = AMLocalizedString(@"Confirm", nil);
    Confirm.secureTextEntry = YES;
    Confirm.text = @"";
    Confirm.returnKeyType = UIReturnKeyDone;
}

- (void)getDate:(id)sender{
    
    NSDate *date = BirthDayPicker.date;
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd"];
    
    day = [df stringFromDate:date];
    [df setDateFormat:@"MM"];
    month = [df stringFromDate:date];
    [df setDateFormat:@"YYYY"];
    year = [df stringFromDate:date];
}

-(void)textFieldDidChange:(UITextField *)sender{
    if ([Login.text length]>0 && [Email.text length]>0 &&[Password.text length]>0 && [Confirm.text length]>0  ) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
    else{
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
}

- (BOOL)validateMail:(NSString *)string
{
    
    NSString *expression = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSError *error = NULL;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSTextCheckingResult *match = [regex firstMatchInString:string options:0 range:NSMakeRange(0, [string length])];
    
    if (match){
        return YES;
    }else{
        return NO;
    }
}


#pragma mark - Vkontakte
//- (void)refreshButtonState
//{
//    if (![_vkontakte isAuthorized])
//    {
//        [_loginB setTitle:@"Login"
//                 forState:UIControlStateNormal];
//        // [self hideControls:YES];
//    }
//    else
//    {
//        [_loginB setTitle:@"Logout"
//                 forState:UIControlStateNormal];
//        [_vkontakte getUserInfo];
//        
//    }
//}
//
//
//- (IBAction)loginPressed:(id)sender
//{
//    if (![_vkontakte isAuthorized])
//    {
//        [_vkontakte authenticate];
//    }
//    else
//    {
//        [_vkontakte logout];
//    }
//}
//

#pragma mark - VkontakteDelegate
//
//- (void)vkontakteDidFailedWithError:(NSError *)error
//{
//    [self dismissViewControllerAnimated:YES completion:^{}];
//}
//
//- (void)showVkontakteAuthController:(UIViewController *)controller
//{
//      //  [[UIApplication sharedApplication] endIgnoringInteractionEvents];
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//    {
//        controller.modalPresentationStyle = UIModalPresentationFormSheet;
//    }
//    self.Parent = @"social";
//    [self presentViewController:controller animated:YES completion:^{/*[[UIApplication sharedApplication] endIgnoringInteractionEvents];*/}];
//}
//
//- (void)vkontakteAuthControllerDidCancelled
//{
//    [self dismissViewControllerAnimated:YES completion:^{}];
//}
//
//- (void)vkontakteDidFinishLogin:(Vkontakte *)vkontakte
//{
//    [self dismissViewControllerAnimated:YES completion:^{[[UIApplication sharedApplication] beginIgnoringInteractionEvents];}];
//    [self refreshButtonState];
//}
//
//- (void)vkontakteDidFinishLogOut:(Vkontakte *)vkontakte
//{
//    [self refreshButtonState];
//}
//
//- (void)vkontakteDidFinishGettinUserInfo:(NSDictionary *)info
//{
////    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
//    self.VkontakteUserInfo = info;
//    NSLog(@"%@",self.VkontakteUserInfo);
//    NSArray *components = [[info objectForKey:@"bdate"] componentsSeparatedByString:@"."];
//    if ([components count] == 1)
//    day = [components objectAtIndex:0];
//    if ([components count] == 2)
//        month = [components objectAtIndex:1];
//    if ([components count] == 3)
//        year  = [components objectAtIndex:2];
//   [self SendRegistration:@"VK"];
//}
//
//#pragma mark SA_OAuthTwitterEngineDelegate
//- (void) storeCachedTwitterOAuthData: (NSString *) data forUsername: (NSString *) username {
//	NSUserDefaults			*defaults = [NSUserDefaults standardUserDefaults];
//    
//	[defaults setObject: data forKey: @"authData"];
//    [defaults setObject:[[[[[[NSUserDefaults standardUserDefaults] objectForKey: @"authData"] componentsSeparatedByString:@"user_id="]objectAtIndex:1] componentsSeparatedByString:@"&"]objectAtIndex:0] forKey:@"uid"];
//    
//	[defaults synchronize];
//}
//
//- (NSString *) cachedTwitterOAuthDataForUsername: (NSString *) username {
//	return [[NSUserDefaults standardUserDefaults] objectForKey: @"authData"];
//}
//
//#pragma mark SA_OAuthTwitterControllerDelegate
//- (void) OAuthTwitterController: (SA_OAuthTwitterController *) controller authenticatedWithUsername: (NSString *) username {
//    self.twitterName = username;
//    self.twitterid =[[[[[[NSUserDefaults standardUserDefaults] objectForKey: @"authData"] componentsSeparatedByString:@"user_id="]objectAtIndex:1] componentsSeparatedByString:@"&"]objectAtIndex:0];
//    [self SendRegistration:@"TW"];
//}
//
//- (void) OAuthTwitterControllerFailed: (SA_OAuthTwitterController *) controller {
//    NSLog(@"Authentication Failed!");
//}
//
//- (void) OAuthTwitterControllerCanceled: (SA_OAuthTwitterController *) controller {
//    NSLog(@"Authentication Canceled.");
//}
//
//#pragma mark TwitterEngineDelegate
//- (void) requestSucceeded: (NSString *) requestIdentifier {
//	// NSLog(@"Request %@ succeeded", requestIdentifier);
//    
//}
//
//- (void) requestFailed: (NSString *) requestIdentifier withError: (NSError *) error {
//	// NSLog(@"Request %@ failed with error: %@", requestIdentifier, error);
//}
//
//
#pragma mark - Facebook

- (void)getUserInfo
{
//    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    loadingView.hidden = NO;
    if (FBSession.activeSession.isOpen) {
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection,
           NSDictionary<FBGraphUser> *user,
           NSError *error) {
             if (!error) {
                 NSLog(@"FB LOG: userInfo:\n\tname: %@\n\t id: %@\n\t last name: %@",user.name, user.id, user.last_name);
                 [[NSUserDefaults standardUserDefaults] setValue:@"ok" forKey:@"Registration"];
             }
             else{
                 NSLog(@"FB LOG: getUserInfo error! %@", error);
             }
         }];
    }
//
//    [SCFacebook getUserFQL:FQL_USER_STANDARD callBack:^(BOOL success, id result) {
//        if (success) {
//            loadingView.hidden = YES;
//            self.FacebookUserInfo = result;
//            NSArray *components = [[result objectForKey:@"birthday_date"] componentsSeparatedByString:@"/"];
//            day = [components objectAtIndex:0];
//            month = [components objectAtIndex:1];
//            year = [components objectAtIndex:2];
//            
//            NSLog(@"%@ %@ %@",day,month,year);
//            [self SendRegistration:@"FB"];
//            
//        }
//        else{
//            loadingView.hidden = YES;
//            NSLog(@"123not success");
//            [self.HUDfade hide:YES afterDelay:0];
//           // [[UIApplication sharedApplication] endIgnoringInteractionEvents];
//        }
//        
//    }];
}



- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    getLocation = YES;
    if (getLocation)
        [locationManager stopUpdatingLocation];
    
}

#pragma mark - Send Data

-(NSDictionary * )POSTRequestRegistration:(NSString *)Way{
    CLLocation *Me = [locationManager location];
   
    NSString *lat = [NSString stringWithFormat:@"%f",Me.coordinate.latitude];
    NSString *lon = [NSString stringWithFormat:@"%f",Me.coordinate.longitude];
    if (![self.LorR isEqualToString:@"Login"]){
        if ([Way isEqualToString:@"Self"]){
            return [[[Account alloc] initwithEmail:Email.text Name:Login.text Password:Password.text day:day month:month Year:year Lat:lat Lon:lon] makeAccount];
        }
        if ([Way isEqualToString:@"TW"])
            return [[[Account alloc] initwithUID:self.twitterid Name:[NSString stringWithFormat:@"%@",self.twitterName] Password:self.twitterid day:day month:month Year:year Lat:lat Lon:lon] makeTWAccount];
        
        if ([Way isEqualToString:@"FB"])
            return [[[Account alloc] initwithUID:[self.FacebookUserInfo objectForKey:@"uid"] Name:[self.FacebookUserInfo objectForKey:@"name"] Password:[self.FacebookUserInfo objectForKey:@"uid"] day:day month:month Year:year Lat:lat Lon:lon] makeFBAccount];
        
        if ([Way isEqualToString:@"VK"])
            return [[[Account alloc] initwithUID:[self.VkontakteUserInfo objectForKey:@"uid"] Name:[self.VkontakteUserInfo objectForKey:@"first_name"] Password:[self.VkontakteUserInfo objectForKey:@"uid"] day:day month:month Year:year Lat:lat Lon:lon] makeVKAccount];
    }
    else{
        if ([Way isEqualToString:@"Self"])
            return [[[Account alloc] LogininitwithEmail:Email.text Password:Password.text Lat:lat Lon:lon] LoginmakeAccount];
        if ([Way isEqualToString:@"TW"])
            return [[[Account alloc] LogininitwithUID:self.twitterid Password:self.twitterid Lat:lat Lon:lon] LoginmakeTWAccount];
        if ([Way isEqualToString:@"FB"])
            return [[[Account alloc] LogininitwithUID:[self.FacebookUserInfo objectForKey:@"uid"] Password:[self.FacebookUserInfo objectForKey:@"uid"] Lat:lat Lon:lon] LoginmakeFBAccount];
        if ([Way isEqualToString:@"VK"])
            return [[[Account alloc] LogininitwithUID:[self.VkontakteUserInfo objectForKey:@"uid"] Password:[self.VkontakteUserInfo objectForKey:@"uid"] Lat:lat Lon:lon] LoginmakeVKAccount];
    }
    return nil;
}


-(NSMutableURLRequest *)address:(NSString *)RegistrationWay{
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://www.likelik.net"]];
    [httpClient defaultValueForHeader:@"Accept"];
    NSString *params;
    if ([self.LorR isEqualToString:@"Login"]){
        params = [NSString stringWithFormat:@"/api/v1/users/login?lang=%@",_lang];

    }
    else{
        params = [NSString stringWithFormat:@"/api/v1/users?lang=%@",_lang];
    }
        
    return [httpClient requestWithMethod:@"POST" path:params parameters:[self POSTRequestRegistration:RegistrationWay]];
    
}


-(void)SendRegistration:(NSString *)RegistrationWay{
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:[self address:RegistrationWay] success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"Registered"];
        [[NSUserDefaults standardUserDefaults] setObject:RegistrationWay forKey:@"RegistrationWay"];
        [self.HUDfade hide:YES];
        
        [self.HUDdone show:YES];
        [self.HUDdone hide:YES afterDelay:1];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];        
        [self.navigationController popViewControllerAnimated:YES];

        
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
       
        NSString *answer = [self HUDStringLocalized:JSON];
        [self.HUDfade hide:YES];
        [self HUDError];
        self.HUDerror.customView = [InterfaceFunctions LabelHUDwithString:answer];
        
        [self.HUDerror show:YES];
        [self.HUDerror hide:YES afterDelay:2];
         [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        
    }];
   // [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [self.HUDfade show:YES];
    [operation start];
}



@end
