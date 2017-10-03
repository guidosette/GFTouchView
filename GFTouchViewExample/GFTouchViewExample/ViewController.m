//
//  ViewController.m
//  GFTouchViewExample
//
//  Created by Guido Fanfani on 03/10/17.
//  Copyright © 2017 Guido Fanfani. All rights reserved.
//

#import "ViewController.h"
#import "UIView+GFTouchView.h"
#import "GFTouchGesture.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *buttonView;
@property (weak, nonatomic) IBOutlet UIView *buttonView2;

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
    NSLog(@"clickOnView");
    if ([targetView isEqual:_buttonView]) {
        NSLog(@"click _buttonView");
    }

    if ([targetView isEqual:_buttonView2]) {
        NSLog(@"click _buttonView2");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
