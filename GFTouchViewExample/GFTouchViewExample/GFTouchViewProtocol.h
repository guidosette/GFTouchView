//
//  GFTouchViewProtocol.h
//  GFTouchViewExample
//
//  Created by Guido Fanfani on 03/10/17.
//  Copyright © 2017 Guido Fanfani. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GFTouchViewProtocol <NSObject>

- (void) clickOnView:(UIView*)targetView;

- (void) onPressedView:(UIView*)targetView;

- (void) onPressedViewEnd:(UIView*)targetView;

@end
