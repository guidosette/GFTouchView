//
//  GFTouchGesture.h
//  GFTouchViewExample
//
//  Created by Guido Fanfani on 03/10/17.
//  Copyright © 2017 Guido Fanfani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GFTouchViewProtocol.h"

@interface GFTouchGesture : UILongPressGestureRecognizer

- (instancetype)initWithProtocol:(id<GFTouchViewProtocol>)protocol targetView:(UIView*)targetView;

- (instancetype)initWithProtocol:(id<GFTouchViewProtocol>)protocol targetView:(UIView*)targetView backgroundColorPressed:(UIColor*)backgroundPressed;

@end
