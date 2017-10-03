//
//  ViewController.m
//  GFTouchViewExample
//
//  Created by Guido Fanfani on 03/10/17.
//  Copyright © 2017 Guido Fanfani. All rights reserved.
//

#import "ViewController.h"
#import "GFTouchGesture.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *buttonView;
@property (weak, nonatomic) IBOutlet UIView *buttonView2;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
   // [_buttonView addTouchWithProtocol:self backgroundColorPressed:[UIColor blueColor]];
    GFTouchGesture* touch = [[GFTouchGesture alloc] initWithProtocol:self targetView:_buttonView backgroundColorPressed:[UIColor blueColor]];
    [_buttonView addGestureRecognizer:touch];

    GFTouchGesture* touch2 = [[GFTouchGesture alloc] initWithProtocol:self targetView:_buttonView2 backgroundColorPressed:[UIColor greenColor]];
    [_buttonView2 addGestureRecognizer:touch2];
}

#pragma - GFTouchViewProtocol
- (void)clickOnView:(UIView *)targetView {
    if ([targetView isEqual:_buttonView]) {
        NSLog(@"click _buttonView");
    }

    if ([targetView isEqual:_buttonView2]) {
        NSLog(@"click _buttonView2");
    }
}

- (void)onPressedView:(UIView*)targetView {
    if ([targetView isEqual:_buttonView]) {
        _label1.textColor = [UIColor whiteColor];
    }
    
    if ([targetView isEqual:_buttonView2]) {
        _label2.textColor = [UIColor whiteColor];
    }
}

- (void)onPressedViewEnd:(UIView*)targetView {
    if ([targetView isEqual:_buttonView]) {
        _label1.textColor = [UIColor blackColor];
    }
    
    if ([targetView isEqual:_buttonView2]) {
        _label2.textColor = [UIColor blackColor];
    }
}

@end
