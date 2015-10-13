//
//  RPPreviewViewController+Swizzling.m
//  replayKitDemo
//
//  Created by JackSong on 15/10/7.
//  Copyright © 2015年 JoeySong. All rights reserved.
//

#import "RPPreviewViewController+Swizzling.h"
#import <objc/runtime.h>

@implementation RPPreviewViewController (Swizzling)

+ (IMP)swizzleSelector:(SEL)origSelector
               withIMP:(IMP)newIMP {
    Class class = [self class];
    Method origMethod = class_getInstanceMethod(class,
                                                origSelector);
    IMP origIMP = method_getImplementation(origMethod);
    if(!class_addMethod(self, origSelector, newIMP,
                        method_getTypeEncoding(origMethod)))
    {
        method_setImplementation(origMethod, newIMP);
    }
    
    return origIMP;
}

+ (IMP)swizzleClassSelector:(SEL)origSelector
               withIMP:(IMP)newIMP
{
    Class class = [self class];
    Method origMethod = class_getClassMethod(class,
                                                origSelector);
    IMP origIMP = method_getImplementation(origMethod);
    if(!class_addMethod(self, origSelector, newIMP,
                        method_getTypeEncoding(origMethod)))
    {
        method_setImplementation(origMethod, newIMP);
    }
    
    return origIMP;
}
/*
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        // When swizzling a class method, use the following:
        // Class class = object_getClass((id)self);
        
        SEL originalSelector = @selector(touchesBegan: withEvent:);
        
        SEL swizzledSelector = @selector(touch: event:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}
//*/
/*
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        // When swizzling a class method, use the following:
        // Class class = object_getClass((id)self);
        
        SEL originalSelector = @selector(loadPreviewViewControllerWithMovieURL: completion:);
        
        SEL swizzledSelector = @selector(videoUrl: completion:);
        
        Method originalMethod = class_getClassMethod(class, originalSelector);
        Method swizzledMethod = class_getClassMethod(class, swizzledSelector);
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}
 
//*/
+ (void)videoUrl:(id)url completion:(id)some
{
    NSLog(@"url - %@  completion - %@",url,some);
}

- (void)touch:(NSSet *)touch event:(UIEvent *)event
{
    NSLog(@"touches - %@ events - %@",touch,event);
}

@end
