//
//  MKDSlideViewController.m
//  MKDSlideViewController
//
//  Created by Marcel Dierkes on 03.12.11.
//  Copyright (c) 2011-2013 Marcel Dierkes. All rights reserved.
//

#import "MKDSlideViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIViewController+MKDSlideViewController.h"

typedef NS_ENUM(NSInteger, MKDSlideViewControllerPositionType) {
    MKDSlideViewControllerPositionLeft = -1,
    MKDSlideViewControllerPositionCenter = 0,
    MKDSlideViewControllerPositionRight = 1,
};

@interface UIViewController (MKDSlideViewControllerPrivate)
@property (nonatomic, retain, readwrite) MKDSlideViewController * slideViewController;
@end


@interface MKDSlideViewController ()
@property (nonatomic, assign) MKDSlideViewControllerPositionType slidePosition;

@property (nonatomic, strong) UIView * leftPanelView;
@property (nonatomic, strong) UIView * mainPanelView;
@property (nonatomic, strong) UIView * rightPanelView;


@property (nonatomic, strong) UIPanGestureRecognizer * panGestureRecognizer;
@property (nonatomic, strong) UIView * tapOverlayView;

@property (nonatomic, assign) CGPoint previousLocationInView;

@end

@implementation MKDSlideViewController

- (instancetype)initWithMainViewController:(UIViewController *)mainViewController;
{
    self = [super initWithNibName:nil bundle:nil];
    if( self )
    {
        self.mainViewController = mainViewController;
        
        // Setup defaults
        _slidePosition = MKDSlideViewControllerPositionCenter;
        _handleStatusBarStyleChanges = NO;
        _mainStatusBarStyle = UIStatusBarStyleBlackOpaque;//[[UIApplication sharedApplication] statusBarStyle];
        _leftStatusBarStyle = UIStatusBarStyleBlackOpaque;
        _rightStatusBarStyle = UIStatusBarStyleBlackOpaque;
        _slideSpeed = 0.35f;
        _overlapWidth = 52.0f;
        _leftSwipe = NO;
        _rightSwipe = NO;
        _showMain = NO;
    }
    return self;
}


// Create the view hierarchy
- (void)loadView
{
    UIView * view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    view.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    view.backgroundColor = [UIColor blackColor];
    
    // Setup Panels
    
    
    _rightPanelView = [[UIView alloc] initWithFrame:view.bounds];
    _rightPanelView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _rightPanelView.backgroundColor = [UIColor blackColor];
    [view addSubview:_rightPanelView];
    
#warning Изменение размера leftViewController
    CGRect p = view.bounds;
    p.size.width -= _overlapWidth;
    p.origin.x -= p.size.width;
    
    _leftPanelView = [[UIView alloc] initWithFrame:p];
    _leftPanelView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _leftPanelView.backgroundColor = [UIColor blackColor];
    [view addSubview:_leftPanelView];
    
    _mainPanelView = [[UIView alloc] initWithFrame:view.bounds];
    _mainPanelView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _mainPanelView.backgroundColor = [UIColor blackColor];
    [view addSubview:_mainPanelView];
    [_mainPanelView addGestureRecognizer:self.panGestureRecognizer];
    //    CGRect p = view.bounds;
    //    p.origin.x -= 150;
    
    
    //insert LEFT
    //[_leftPanelView addGestureRecognizer:self.panGestureRecognizer];
    
    
    // Setup main layer shadow
    CALayer * layer = _mainPanelView.layer;
    layer.masksToBounds = NO;
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    layer.shadowOpacity = 0.9f;
    CGRect rect = CGRectInset(_mainPanelView.bounds, 0.0f, -40.0f); // negative inset for an even shadow
    CGPathRef path = [UIBezierPath bezierPathWithRect:rect].CGPath;
    layer.shadowPath = path;
    layer.shadowRadius = 10.0f;
    
    
    // Setup left layer shadow
    CALayer * layer1 = _leftPanelView.layer;
    layer1.masksToBounds = NO;
    layer1.shadowColor = [UIColor blackColor].CGColor;
    layer1.shadowOffset = CGSizeMake(0.0f, 0.0f);
    layer1.shadowOpacity = 0.9f;
    CGRect rect1 = CGRectInset(_leftPanelView.bounds, 0.0f, -40.0f); // negative inset for an even shadow
    CGPathRef path1 = [UIBezierPath bezierPathWithRect:rect1].CGPath;
    layer1.shadowPath = path1;
    layer1.shadowRadius = 10.0f;
    
    
    if( self.mainViewController.view.superview == nil )
    {
        self.mainViewController.view.frame = self.mainPanelView.bounds;
        [self.mainPanelView addSubview:self.mainViewController.view];
    }
    if( self.leftViewController.view.superview == nil )
    {
        self.leftViewController.view.frame = self.leftPanelView.bounds;
        [self.leftPanelView addSubview:self.leftViewController.view];
    }
    if( self.rightViewController.view.superview == nil )
    {
        self.rightViewController.view.frame = self.rightPanelView.bounds;
        [self.rightPanelView addSubview:self.rightViewController.view];
    }
    
    self.view = view;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if( [self.view window] == nil )
    {
        self.delegate = nil;
    }
}

#pragma mark - Child View Controllers

- (void)setMainViewController:(UIViewController *)mainViewController
{
    if( _mainViewController != nil )
    {
        // Clean up
        [_mainViewController removeFromParentViewController];
        _mainViewController.slideViewController = nil;
        [_mainViewController.view removeFromSuperview];
    }
    _mainViewController = mainViewController;
    _mainViewController.slideViewController = self;
    [self addChildViewController:_mainViewController];
    
    if( _mainPanelView != nil )
    {
        // Add as subview, if slide view controller view is loaded.
        self.mainViewController.view.frame = self.mainPanelView.bounds;
        [self.mainPanelView addSubview:self.mainViewController.view];
    }
}

- (void)setLeftViewController:(UIViewController *)leftViewController
{
    if( _leftViewController != nil )
    {
        // Clean up
        [_leftViewController removeFromParentViewController];
        _leftViewController.slideViewController = nil;
        [_leftViewController.view removeFromSuperview];
    }
    _leftViewController = leftViewController;
    _leftViewController.slideViewController = self;
    [self addChildViewController:_leftViewController];
    
    if( _leftPanelView != nil )
    {
        // Add as subview, if slide view controller view is loaded.
        self.leftViewController.view.frame = self.leftPanelView.bounds;
        [self.leftPanelView addSubview:self.leftViewController.view];
    }
}

- (void)setRightViewController:(UIViewController *)rightViewController
{
    if( _rightViewController != nil )
    {
        // Clean up
        [_rightViewController removeFromParentViewController];
        _rightViewController.slideViewController = nil;
        [_rightViewController.view removeFromSuperview];
    }
    _rightViewController = rightViewController;
    _rightViewController.slideViewController = self;
    [self addChildViewController:_rightViewController];
    
    if( _rightPanelView != nil )
    {
        // Add as subview, if slide view controller view is loaded.
        self.rightViewController.view.frame = self.rightPanelView.bounds;
        [self.rightPanelView addSubview:self.rightViewController.view];
    }
}

- (void)setMainViewController:(UIViewController *)mainViewController animated:(BOOL)animated
{
    if(!animated)
    {
        self.mainViewController = mainViewController;
        [self showMainViewControllerAnimated:animated];
        return;
    }
    
    if( self.mainViewController != nil )
    {
        // Slide out of sight
        self.backupViewController = self.rightViewController;
        self.rightViewController = self.blackViewController;
        
        CGRect initialFrame = self.mainPanelView.bounds;
        CGRect frame = initialFrame;
        frame.origin.x = frame.size.width + self.overlapWidth;
        
        [UIView animateWithDuration:self.slideSpeed
                         animations:^{
                             self.mainPanelView.frame = frame;
                         }
                         completion:^(BOOL finished) {
                             // Replace the view controller and slide back in
                             self.mainViewController = mainViewController;
                             [self showMainViewControllerAnimated:animated];
                         }
         ];
        
    }
}

#pragma mark - Rotation Handling

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark - Panning

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    NSLog(@"CHECK");
    UIView *cell = [gestureRecognizer view];
    CGPoint translation = [gestureRecognizer translationInView:[cell superview]];
    
    // Check for horizontal gesture
    if (fabsf(translation.x) > fabsf(translation.y))
    {
        return YES;
    }
    
    return NO;
}


- (UIPanGestureRecognizer *)panGestureRecognizer
{
    if( _panGestureRecognizer == nil )
    {
        _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        _panGestureRecognizer.maximumNumberOfTouches = 1;
    }
    return _panGestureRecognizer;
}

- (void)pan:(UIPanGestureRecognizer *)gesture
{
    if ((gesture.state == UIGestureRecognizerStateChanged) ||
        (gesture.state == UIGestureRecognizerStateEnded))
    {
        CGPoint velocity = [gesture velocityInView:self.view];
        
        if (fabs(velocity.y > 0) && fabs(velocity.x) < 30 && !self.leftSwipe && !self.rightSwipe)   // panning down or up
        {
            gesture.enabled = NO;
            gesture.enabled = YES;
        }
    }
    
    CGFloat xOffset = self.mainPanelView.frame.origin.x;
    CGFloat snapThreshold = 0.0f;
    CGFloat dividerPosition = 0.0f;
    //    UIApplication * app = [UIApplication sharedApplication];
    //    NSLog(@"LOG: swipe detected. offset:%f, %d",xOffset, self.leftSwipe);
    if( xOffset > (dividerPosition-snapThreshold) /*&& !self.leftSwipe*/)
    {
        _leftPanelView.layer.shadowRadius = 10.0;
        
        // snap to right position
        //       NSLog(@"LOG: swipe from left");
        self.leftSwipe = YES;
        self.rightSwipe = NO;
        CGRect newFrame = self.mainPanelView.frame;
        newFrame.origin.x = CGPointZero.x + 0.001;
        self.mainPanelView.frame = newFrame;
        //        [self showLeftViewControllerAnimated:YES];
        //        if( [self isHandlingStatusBarStyleChanges] )
        //            [app setStatusBarStyle:self.leftStatusBarStyle animated:YES];
        if( gesture.state == UIGestureRecognizerStateBegan )
        {
            self.previousLocationInView = CGPointZero;
            
            //            if( [self isHandlingStatusBarStyleChanges] )
            //                [[UIApplication sharedApplication] setStatusBarStyle:self.leftStatusBarStyle animated:YES];
        }
        else if( gesture.state == UIGestureRecognizerStateChanged)
        {
            [self.view sendSubviewToBack:self.mainPanelView];
            [self.view sendSubviewToBack:self.rightPanelView];
            
            // Decide, which view controller should be revealed
            //            if( self.mainPanelView.frame.origin.x <= 0.0f ) // left
            //                [self.view sendSubviewToBack:self.leftPanelView];
            //            else
            //                [self.view sendSubviewToBack:self.rightPanelView];
            //
            // Calculate position offset
            CGPoint locationInView = [gesture translationInView:self.view];
            CGFloat deltaX = locationInView.x - self.previousLocationInView.x;
            
            // Update view frame
            if(self.leftPanelView.frame.origin.x < 0){
                CGRect newFrame = self.leftPanelView.frame;
                newFrame.origin.x +=deltaX;
                self.leftPanelView.frame = newFrame;
            }
            self.previousLocationInView = locationInView;
        }
        else if( (gesture.state == UIGestureRecognizerStateEnded) || (gesture.state == UIGestureRecognizerStateCancelled) )
        {
            [self updatePanelsForCurrentPosition];
        }
        
        
    }
    
    else if(xOffset <= (dividerPosition-snapThreshold)){
        //        NSLog(@"LOG: swipe from right");
        self.leftSwipe = NO;
        self.rightSwipe = YES;
        
        if( gesture.state == UIGestureRecognizerStateBegan )
        {
            self.previousLocationInView = CGPointZero;
            
            //            if( [self isHandlingStatusBarStyleChanges] )
            //                [[UIApplication sharedApplication] setStatusBarStyle:self.leftStatusBarStyle animated:YES];
        }
        else if( gesture.state == UIGestureRecognizerStateChanged )
        {
            // Decide, which view controller should be revealed
            if( self.mainPanelView.frame.origin.x <= 0.0f ) // left
                [self.view sendSubviewToBack:self.leftPanelView];
            else
                [self.view sendSubviewToBack:self.rightPanelView];
            
            // Calculate position offset
            CGPoint locationInView = [gesture translationInView:self.view];
            CGFloat deltaX = locationInView.x - self.previousLocationInView.x;
            
            // Update view frame
            CGRect newFrame = self.mainPanelView.frame;
            newFrame.origin.x +=deltaX;
            self.mainPanelView.frame = newFrame;
            
            self.previousLocationInView = locationInView;
        }
        else if( (gesture.state == UIGestureRecognizerStateEnded) || (gesture.state == UIGestureRecognizerStateCancelled) )
        {
            [self updatePanelsForCurrentPosition];
        }
    }
    
}

- (void)updatePanelsForCurrentPosition
{
    // UIApplication * app = [UIApplication sharedApplication];
    
    MKDSlideViewControllerPositionType position = self.slidePosition;
    CGFloat xOffset = self.mainPanelView.frame.origin.x;
    CGFloat leftOffset = self.leftPanelView.frame.origin.x;
    CGFloat snapThreshold = self.overlapWidth;
    
    CGFloat dividerPosition = 0.0f;
    
    NSLog(@"LOG: update panels called!");
    if( position == MKDSlideViewControllerPositionCenter )
    {
        if( (xOffset >= (dividerPosition-snapThreshold)) && (xOffset <= (dividerPosition+snapThreshold)) && leftOffset == -self.leftPanelView.frame.size.width)
            //if( xOffset <= (dividerPosition-snapThreshold) )
        {
            NSLog(@"LOG: point  1");
            // Snap to center position
            [self showMainViewControllerAnimated:YES];
            // [self showLeftViewControllerAnimated:YES];
            //            if( [self isHandlingStatusBarStyleChanges] )
            //                [app setStatusBarStyle:self.mainStatusBarStyle animated:YES];
        }
        else if( xOffset < (dividerPosition-snapThreshold) )
        {
            NSLog(@"LOG: point  2");
            // snap to right position
            [self showRightViewControllerAnimated:YES];
            //            if( [self isHandlingStatusBarStyleChanges] )
            //                [app setStatusBarStyle:self.rightStatusBarStyle animated:YES];
        }
        else if((leftOffset + self.leftPanelView.frame.size.width) > self.overlapWidth)
        {
            NSLog(@"LOG: point  3");
            // snap to left position
            [self showLeftViewControllerAnimated:YES];
            //            if( [self isHandlingStatusBarStyleChanges] )
            //                [app setStatusBarStyle:self.leftStatusBarStyle animated:YES];
        }
        else{
            NSLog(@"LOG: point  4");
            [self showMainViewControllerAnimated:YES];
        }
    }
    else if( position == MKDSlideViewControllerPositionLeft )
    {
        dividerPosition = self.view.bounds.size.width - self.overlapWidth;
        
        if( (xOffset >= (dividerPosition-snapThreshold)) && (xOffset <= (dividerPosition+snapThreshold)) )
        {
            NSLog(@"LOG: point  5");
            // Snap back to left position
            [self showLeftViewControllerAnimated:YES];
            //            if( [self isHandlingStatusBarStyleChanges] )
            //                [app setStatusBarStyle:self.leftStatusBarStyle animated:YES];
        }
        else if( xOffset < (dividerPosition-snapThreshold) )
        {
            NSLog(@"LOG: point  6");
            // snap to center position
            [self showMainViewControllerAnimated:YES];
            //            if( [self isHandlingStatusBarStyleChanges] )
            //                [app setStatusBarStyle:self.mainStatusBarStyle animated:YES];
        }
        
    }
    else if( position == MKDSlideViewControllerPositionRight )
    {
        dividerPosition = self.overlapWidth;
        CGFloat rightSideX = xOffset+self.mainPanelView.frame.size.width;
        
        if( (rightSideX <= dividerPosition) && (rightSideX < (dividerPosition+snapThreshold)) ) // FIXME: Is a bit buggy.
        {
            NSLog(@"LOG: point  7");
            
            // snap to right position
            [self showRightViewControllerAnimated:YES];
            //            if( [self isHandlingStatusBarStyleChanges] )
            //                [app setStatusBarStyle:self.rightStatusBarStyle animated:YES];
        }
        else
        {
            NSLog(@"LOG: point  8");
            // snap to center position
            [self showMainViewControllerAnimated:YES];
            //            if( [self isHandlingStatusBarStyleChanges] )
            //                [app setStatusBarStyle:self.mainStatusBarStyle animated:YES];
        }
        
    }
    
    self.previousLocationInView = CGPointZero;
}

#pragma mark - Tap Overlay View Handling

- (UIView *)tapOverlayView
{
    if( _tapOverlayView == nil )
    {
        _tapOverlayView = [[UIView alloc] initWithFrame:self.view.bounds];
        _tapOverlayView.backgroundColor = [UIColor clearColor];
        _tapOverlayView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showMainViewController)];
        tapGesture.numberOfTapsRequired = 1;
        tapGesture.numberOfTouchesRequired = 1;
        [_tapOverlayView addGestureRecognizer:tapGesture];
    }
    return _tapOverlayView;
}

- (void)addTapViewOverlay
{
    [self.mainPanelView addSubview:self.tapOverlayView];
}

- (void)removeTapViewOverlay
{
    [self.tapOverlayView removeFromSuperview];
}

#pragma mark - Slide Actions

-(void)callLeftMenu{
    NSLog(@"LOG: left menu called");
    self.leftSwipe = YES;
    CGRect newFrame = self.mainPanelView.frame;
    newFrame.origin.x = CGPointZero.x + 0.001;
    self.mainPanelView.frame = newFrame;
    [self showLeftViewControllerAnimated:YES];
}

-(void)callRightMenu{
    NSLog(@"LOG: right menu called");
    self.rightSwipe = YES;
    [self showRightViewControllerAnimated:YES];
    //    self.leftSwipe = YES;
    //    CGRect newFrame = self.mainPanelView.frame;
    //    newFrame.origin.x = CGPointZero.x + 0.001;
    //    self.mainPanelView.frame = newFrame;
    //    [self showLeftViewControllerAnimated:YES];
}


- (void)showLeftViewController
{
    [self showLeftViewControllerAnimated:YES];
}

- (void)showLeftViewControllerAnimated:(BOOL)animated
{
    //Adding removed baggy shadow
    //    _leftPanelView.layer.shadowRadius = 10.0;
    if(_leftPanelView.layer.shadowRadius == 0.0)
        _leftPanelView.layer.shadowRadius = 10.0;
    self.slidePosition = MKDSlideViewControllerPositionLeft;
    int offset = 10;
    if( [self.delegate respondsToSelector:@selector(slideViewController:willSlideToViewController:)] )
        [self.delegate performSelector:@selector(slideViewController:willSlideToViewController:) withObject:self withObject:self.leftViewController];
    
    //    if( [self isHandlingStatusBarStyleChanges] )
    //        [[UIApplication sharedApplication] setStatusBarStyle:self.leftStatusBarStyle animated:YES];
    
    [self.view sendSubviewToBack:self.mainPanelView];
    [self.view sendSubviewToBack:self.rightPanelView];
    
    
    if( animated )
    {
        [UIView animateWithDuration:(self.slideSpeed) animations:^{
            CGRect theFrame = self.leftPanelView.frame;
            theFrame.origin.x = 0;
            //theFrame.origin.x = /*-theFrame.size.width;*/theFrame.size.width - self.overlapWidth;// + offset;
            self.leftPanelView.frame = theFrame;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:self.slideSpeed animations:^{
                CGRect theFrame = self.leftPanelView.frame;
                theFrame.origin.x = -offset;
                self.leftPanelView.frame = theFrame;
            }];
            [self addTapViewOverlay];
            
            if( [self.delegate respondsToSelector:@selector(slideViewController:didSlideToViewController:)] )
                [self.delegate performSelector:@selector(slideViewController:didSlideToViewController:) withObject:self withObject:self.leftViewController];
        }];
    }
    //    else
    //    {
    //        CGRect theFrame = self.mainPanelView.frame;
    //        theFrame.origin.x = theFrame.size.width - self.overlapWidth;
    //        self.mainPanelView.frame = theFrame;
    //        [self addTapViewOverlay];
    //
    //        if( [self.delegate respondsToSelector:@selector(slideViewController:didSlideToViewController:)] )
    //            [self.delegate performSelector:@selector(slideViewController:didSlideToViewController:) withObject:self withObject:self.leftViewController];
    //    }
}

- (void)showRightViewController
{
    [self showRightViewControllerAnimated:YES];
}

- (void)showRightViewControllerAnimated:(BOOL)animated
{
    self.slidePosition = MKDSlideViewControllerPositionRight;
    int offset = 10;
    if( [self.delegate respondsToSelector:@selector(slideViewController:willSlideToViewController:)] )
        [self.delegate performSelector:@selector(slideViewController:willSlideToViewController:) withObject:self withObject:self.rightViewController];
    
    //    if( [self isHandlingStatusBarStyleChanges] )
    //        [[UIApplication sharedApplication] setStatusBarStyle:self.rightStatusBarStyle animated:YES];
    
    [self.view sendSubviewToBack:self.leftPanelView];
    
    if( animated )
    {
        [UIView animateWithDuration:self.slideSpeed animations:^{
            CGRect theFrame = self.mainPanelView.frame;
            theFrame.origin.x = -theFrame.size.width + self.overlapWidth - offset;
            self.mainPanelView.frame = theFrame;
        } completion:^(BOOL finished) {[UIView animateWithDuration:self.slideSpeed animations:^{
            CGRect theFrame = self.mainPanelView.frame;
            
            theFrame.origin.x = -theFrame.size.width + self.overlapWidth;
            self.mainPanelView.frame = theFrame;
        }];
            
            [self addTapViewOverlay];
            
            if( [self.delegate respondsToSelector:@selector(slideViewController:didSlideToViewController:)] )
                [self.delegate performSelector:@selector(slideViewController:didSlideToViewController:) withObject:self withObject:self.rightViewController];
        }];
    }
    else
    {
        CGRect theFrame = self.mainPanelView.frame;
        theFrame.origin.x = -theFrame.size.width + self.overlapWidth;
        self.mainPanelView.frame = theFrame;
        [self addTapViewOverlay];
        
        if( [self.delegate respondsToSelector:@selector(slideViewController:didSlideToViewController:)] )
            [self.delegate performSelector:@selector(slideViewController:didSlideToViewController:) withObject:self withObject:self.rightViewController];
    }
    
}

- (void)showMainViewController
{
    [self showMainViewControllerAnimated:YES];
}

- (void)showMainViewControllerAnimated:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"callingMainView" object:nil];
    if(self.leftSwipe){ //FOR LEFT MENU
        
        
        self.leftSwipe = NO;
        NSLog(@"LOG: calling showMainViewControllerAnimated");
        //[self.view sendSubviewToBack:self.leftPanelView];
        //[self.view sendSubviewToBack:self.rightPanelView];
        //}
        
        self.slidePosition = MKDSlideViewControllerPositionCenter;
        CGPoint offset = {-10,.0}; // - for left bounce, + for right
        if( self.mainPanelView.frame.origin.x < 0)
            offset.x *= -1;
        //        if( [self isHandlingStatusBarStyleChanges] )
        //            [[UIApplication sharedApplication] setStatusBarStyle:self.mainStatusBarStyle animated:YES];
        
        if( self.mainPanelView.frame.origin.x != CGPointZero.x )
        {
            if( [self.delegate respondsToSelector:@selector(slideViewController:willSlideToViewController:)] )
                [self.delegate performSelector:@selector(slideViewController:willSlideToViewController:) withObject:self withObject:self.mainViewController];
            
            if( animated )
            {
                [UIView animateWithDuration:(self.slideSpeed) animations:^{
                    CGRect theFrame = self.leftPanelView.frame;
                    //theFrame.origin = offset;
                    theFrame.origin.x = -theFrame.size.width;
                    self.leftPanelView.frame = theFrame;
                } completion:^(BOOL finished) {
                    //                [UIView animateWithDuration:(self.slideSpeed) animations:^{
                    //                    CGRect theFrame = self.leftPanelView.frame;
                    //                    theFrame.origin = CGPointZero;
                    //                    self.leftPanelView.frame = theFrame;
                    //                }];
                    
                    //To remove baggy shadow
                    _leftPanelView.layer.shadowRadius = 0;
                    
                    [self removeTapViewOverlay];
                    
                    if( [self.delegate respondsToSelector:@selector(slideViewController:didSlideToViewController:)] )
                        [self.delegate performSelector:@selector(slideViewController:didSlideToViewController:) withObject:self withObject:self.mainViewController];
                }];
            }
            //        else
            //        {
            //            CGRect theFrame = self.mainPanelView.frame;
            //            theFrame.origin = CGPointZero;
            //            self.mainPanelView.frame = theFrame;
            //            [self removeTapViewOverlay];
            //
            //            if( [self.delegate respondsToSelector:@selector(slideViewController:didSlideToViewController:)] )
            //                [self.delegate performSelector:@selector(slideViewController:didSlideToViewController:) withObject:self withObject:self.mainViewController];
            //        }
            
            
            //self.leftSwipe = NO;
            [UIView animateWithDuration:(self.slideSpeed) animations:^{
                
                CGRect rect = self.mainPanelView.frame;
                rect.origin.x = CGRectZero.origin.x;
                self.mainPanelView.frame = rect;
            } completion:^(BOOL finished) {
                if(self.backupViewController)
                    self.rightViewController = self.backupViewController;
            }];
        }
    }
    else{   // FOR RIGHT MENU
        self.rightSwipe = NO;
        self.slidePosition = MKDSlideViewControllerPositionCenter;
        // CGPoint offset = {-10,.0}; // - for left bounce, + for right
        CGPoint offset = {0,.0}; // - no bounce
        if( self.mainPanelView.frame.origin.x < 0)
            offset.x *= -1;
        //        if( [self isHandlingStatusBarStyleChanges] )
        //            [[UIApplication sharedApplication] setStatusBarStyle:self.mainStatusBarStyle animated:YES];
        
        if( self.mainPanelView.frame.origin.x != CGPointZero.x )
        {
            if( [self.delegate respondsToSelector:@selector(slideViewController:willSlideToViewController:)] )
                [self.delegate performSelector:@selector(slideViewController:willSlideToViewController:) withObject:self withObject:self.mainViewController];
            
            if( animated )
            {
                [UIView animateWithDuration:(self.slideSpeed) animations:^{
                    CGRect theFrame = self.mainPanelView.frame;
                    theFrame.origin = offset;
                    self.mainPanelView.frame = theFrame;
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:(self.slideSpeed) animations:^{
                        CGRect theFrame = self.mainPanelView.frame;
                        theFrame.origin = CGPointZero;
                        self.mainPanelView.frame = theFrame;
                    }];
                    [self removeTapViewOverlay];
                    
                    if( [self.delegate respondsToSelector:@selector(slideViewController:didSlideToViewController:)] )
                        [self.delegate performSelector:@selector(slideViewController:didSlideToViewController:) withObject:self withObject:self.mainViewController];
                }];
            }
            else
            {
                CGRect theFrame = self.mainPanelView.frame;
                theFrame.origin = CGPointZero;
                self.mainPanelView.frame = theFrame;
                [self removeTapViewOverlay];
                
                if( [self.delegate respondsToSelector:@selector(slideViewController:didSlideToViewController:)] )
                    [self.delegate performSelector:@selector(slideViewController:didSlideToViewController:) withObject:self withObject:self.mainViewController];
            }
            
        }
    }
    
}

@end
