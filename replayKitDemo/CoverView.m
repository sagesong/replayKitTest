//
//  CoverView.m
//  replayKitDemo
//
//  Created by Lightning on 15/10/9.
//  Copyright © 2015年 JoeySong. All rights reserved.
//

#import "CoverView.h"

@implementation CoverView

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    return NO;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    return nil;
}

@end
