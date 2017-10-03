//
//  UIView+GFTouchView.h
//  GFTouchViewExample
//
//  Created by Guido Fanfani on 03/10/17.
//  Copyright © 2017 Guido Fanfani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GFTouchViewProtocol.h"

@interface UIView (GFTouchView)

- (void)addTouchWithProtocol:(id<GFTouchViewProtocol>)protocol;

- (void)addTouchWithProtocol:(id<GFTouchViewProtocol>)protocol backgroundColorPressed:(UIColor*)backgroundPressed;

@end
