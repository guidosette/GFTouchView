//
//  UIView+GFTouchView.m
//  GFTouchViewExample
//
//  Created by Guido Fanfani on 03/10/17.
//  Copyright © 2017 Guido Fanfani. All rights reserved.
//

#import "UIView+GFTouchView.h"
#import <objc/runtime.h>

@interface UIView ()

@property id<GFTouchViewProtocol> delegateProtocol;
@property (nonatomic, copy) UIColor* backgroundColorPressed;
@property (nonatomic, copy) UIColor* backgroundColorOriginal;

@end

NSString * const kDelegateProtocolKey = @"kDelegateProtocolKey";
NSString * const kBackgroundColorPressedKey = @"kBackgroundColorPressedKey";
NSString * const kBackgroundColorOriginalKey = @"kBackgroundColorOriginalKey";

@implementation UIView (GFTouchView)

#pragma - Setter and Getter
- (void)setDelegateProtocol:(id<GFTouchViewProtocol>)delegateProtocol {
    objc_setAssociatedObject(self, (__bridge const void * _Nonnull)kDelegateProtocolKey, delegateProtocol, OBJC_ASSOCIATION_ASSIGN);
}

- (id<GFTouchViewProtocol>)delegateProtocol {
    return objc_getAssociatedObject(self, (__bridge const void * _Nonnull)(kDelegateProtocolKey));
}

-(void)setBackgroundColorPressed:(UIColor *)backgroundColorPressed {
    objc_setAssociatedObject(self, (__bridge const void * _Nonnull)kBackgroundColorPressedKey, backgroundColorPressed, OBJC_ASSOCIATION_ASSIGN);
}

- (UIColor *)backgroundColorPressed {
    return objc_getAssociatedObject(self, (__bridge const void * _Nonnull)(kBackgroundColorPressedKey));
}

-(void)setBackgroundColorOriginal:(UIColor *)backgroundColorOriginal {
    objc_setAssociatedObject(self, (__bridge const void * _Nonnull)kBackgroundColorOriginalKey, backgroundColorOriginal, OBJC_ASSOCIATION_ASSIGN);
}

- (UIColor *)backgroundColorOriginal {
    return objc_getAssociatedObject(self, (__bridge const void * _Nonnull)(kBackgroundColorOriginalKey));
}

- (void)addTouchWithProtocol:(id<GFTouchViewProtocol>)protocol {
    self.delegateProtocol = protocol;
    [self initialize];
}

- (void)addTouchWithProtocol:(id<GFTouchViewProtocol>)protocol backgroundColorPressed:(UIColor*)backgroundPressed {
    self.delegateProtocol = protocol;
    self.backgroundColorPressed = backgroundPressed;
    [self initialize];
}

- (void) initialize {
    self.backgroundColorOriginal = [self.backgroundColor copy];

    //add gesture
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    longPressGesture.minimumPressDuration = 0;
    longPressGesture.cancelsTouchesInView = false;
    [self addGestureRecognizer:longPressGesture];
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)gr {
    switch (gr.state){
        case UIGestureRecognizerStateBegan: {
            // change background on press
            if (self.backgroundColorPressed) {
                self.backgroundColor = self.backgroundColorPressed;
            } else {
                //default backgroundColor pressed
                self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.15];
            }
            break;
        }
        case UIGestureRecognizerStateChanged: {
            UIView *tappedView = [gr.view hitTest:[gr locationInView:gr.view] withEvent:nil];
            if (![self isContainInContainerView:self targetView:tappedView]) {
                //if touch is outside viewTarget
                //restore background
                self.backgroundColor = self.backgroundColorOriginal;
            }
            break;

        }
        case UIGestureRecognizerStateEnded: {
            //restore background
            self.backgroundColor = self.backgroundColorOriginal;

            UIView *tappedView = [gr.view hitTest:[gr locationInView:gr.view] withEvent:nil];
            if ([self isContainInContainerView:self targetView:tappedView]) {
                //if touch is on my viewTarget
                if ([self.delegateProtocol respondsToSelector:@selector(clickOnView:)]) {
                    double delayInSeconds = 0.01;
                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
                    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                        [self.delegateProtocol clickOnView:self];
                    });
                } else {
                    [NSException raise:@"TouchView: GFTouchViewProtocol not found!" format:@"%@ not conform with GFTouchViewProtocol", self.delegateProtocol.class];
                }
            }
            break;
        }
        default: {
            //restore background
            self.backgroundColor = self.backgroundColorOriginal;
            break;
        }
    }
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
