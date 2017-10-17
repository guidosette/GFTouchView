//
//  GFTouchGesture.h
//  GFTouchViewExample
//
//  Created by Guido Fanfani on 03/10/17.
//  Copyright © 2017 Guido Fanfani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GFTouchViewProtocol.h"

@interface GFTouchGesture : UILongPressGestureRecognizer<UIGestureRecognizerDelegate>

/**
 Change background color of targetView when pressed on it.
 @param targetView is a view target of tap.
 */
- (instancetype)initWithTargetView:(UIView*)targetView;

/**
 Change background color of targetView when pressed on it.
 @param protocol it's a object (view controller) that implements a GFTouchViewProtocol.
 @param targetView is a view target of tap.
 */
- (instancetype)initWithProtocol:(id<GFTouchViewProtocol>)protocol targetView:(UIView*)targetView;

/**
 Change background color of targetView when pressed on it.
 @param protocol it's a object (view controller) that implements a GFTouchViewProtocol.
 @param targetView is a view target of tap.
 @param backgroundPressed When touch or press the targetView, its backgroundColor change to backgroundPressed.
 */
- (instancetype)initWithProtocol:(id<GFTouchViewProtocol>)protocol targetView:(UIView*)targetView backgroundColorPressed:(UIColor*)backgroundPressed;

@end
