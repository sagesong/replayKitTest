//
//  RecordController.m
//  replayKitDemo
//
//  Created by Lightning on 15/10/8.
//  Copyright © 2015年 JoeySong. All rights reserved.
//

#import "RecordController.h"
#import <MediaToolbox/MediaToolbox.h>
#import <objc/runtime.h>

@implementation RecordController

- (void)viewDidLoad
{
    [super viewDidLoad];
    id recordController = [[objc_getClass("FigScreenCaptureController") alloc] init];
    
}

@end
