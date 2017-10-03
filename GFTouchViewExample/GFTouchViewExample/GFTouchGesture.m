//
//  GFTouchGesture.m
//  GFTouchViewExample
//
//  Created by Guido Fanfani on 03/10/17.
//  Copyright © 2017 Guido Fanfani. All rights reserved.
//

#import "GFTouchGesture.h"

@interface GFTouchGesture ()

@property id<GFTouchViewProtocol> delegateProtocol;
@property UIColor* backgroundColorPressed;
@property UIColor* backgroundColorOriginal;
@property UIView* targetView;
@property bool onFocus;

@end

@implementation GFTouchGesture

- (instancetype)initWithProtocol:(id<GFTouchViewProtocol>)protocol targetView:(UIView*)targetView {
    self = [super initWithTarget:self action:@selector(handleLongPress:)];
    if (self) {
        _targetView = targetView;
        _delegateProtocol = protocol;
        [self initialize];
    }
    return self;
}

- (instancetype)initWithProtocol:(id<GFTouchViewProtocol>)protocol targetView:(UIView*)targetView  backgroundColorPressed:(UIColor*)backgroundPressed {
    self = [super initWithTarget:self action:@selector(handleLongPress:)];
    if (self) {
        _targetView = targetView;
        _delegateProtocol = protocol;
        _backgroundColorPressed = backgroundPressed;
        [self initialize];
    }
    return self;
}

- (void) initialize {
    _backgroundColorOriginal = _targetView.backgroundColor;
    self.minimumPressDuration = 0;
    self.cancelsTouchesInView = false;
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)gr {
    switch (gr.state){
        case UIGestureRecognizerStateBegan: {
            _onFocus = true;
            // change background on press
            if (self.backgroundColorPressed) {
                _targetView.backgroundColor = self.backgroundColorPressed;
            } else {
                //default backgroundColor pressed
                _targetView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.15];
            }
            [_delegateProtocol onPressedView:_targetView];
            break;
        }
        case UIGestureRecognizerStateChanged: {
            UIView *tappedView = [gr.view hitTest:[gr locationInView:gr.view] withEvent:nil];
            if (![self isContainInContainerView:_targetView targetView:tappedView]) {
                //if touch is outside viewTarget
                _onFocus = false;
                //restore background
                [self restoreView];
            }
            break;

        }
        case UIGestureRecognizerStateEnded: {
            //restore background
            [self restoreView];
            
            if (!_onFocus) {
                return;
            }

            UIView *tappedView = [gr.view hitTest:[gr locationInView:gr.view] withEvent:nil];
            if ([self isContainInContainerView:_targetView targetView:tappedView]) {
                //if touch is on my viewTarget
                if ([self.delegateProtocol respondsToSelector:@selector(clickOnView:)]) {
                    double delayInSeconds = 0.01;
                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                        [self.delegateProtocol clickOnView:_targetView];
                    });
                } else {
                    [NSException raise:@"TouchView: GFTouchViewProtocol not found!" format:@"%@ not conform with GFTouchViewProtocol", self.delegateProtocol.class];
                }
            }
            break;
        }
        default: {
            //restore background
            [self restoreView];
            break;
        }
    }
}

- (void) restoreView {
    _targetView.backgroundColor = self.backgroundColorOriginal;
    [_delegateProtocol onPressedViewEnd:_targetView];

}

- (bool)isContainInContainerView:(UIView*)container targetView:(UIView*)targetView {
    if ([container isEqual:targetView]) {
        return true;
    }
    for (UIView* view in container.subviews) {
        if ([view isEqual:targetView]) {
            return true;
        }
        if (view.subviews.count>0) {
            if ([self isContainInContainerView:view targetView:targetView]) {
                return true;
            }
        }
    }
    return false;
}

@end
