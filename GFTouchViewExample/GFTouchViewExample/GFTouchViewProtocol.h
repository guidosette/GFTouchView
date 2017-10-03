//
//  GFTouchViewProtocol.h
//  GFTouchViewExample
//
//  Created by Guido Fanfani on 03/10/17.
//  Copyright © 2017 Guido Fanfani. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GFTouchViewProtocol <NSObject>

/**
 Called when finish pressing on targetView
 @param targetView is a view target of tap.
 */
- (void) clickOnView:(UIView*)targetView;

/**
 Called when start pressing on targetView
 @param targetView is a view target of tap.
 */
- (void) onPressedView:(UIView*)targetView;

/**
 Called when finish pressing on targetView
 @param targetView is a view target of tap.
 */
- (void) onPressedViewEnd:(UIView*)targetView;

@end
