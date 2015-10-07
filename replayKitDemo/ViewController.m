//
//  ViewController.m
//  replayKitDemo
//
//  Created by JackSong on 15/10/7.
//  Copyright © 2015年 JoeySong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<RPPreviewViewControllerDelegate>

@property (nonatomic, weak) UILabel *timeLable;
@property (nonatomic, weak) UIButton *startBtn;
@property (nonatomic, weak) UIButton *stopBtn;

@end

static int count = 0;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerCallBack) userInfo:nil repeats:YES];
    
    [self setupUI];
}

- (void)timerCallBack
{
    count++;
    self.timeLable.text = [NSString stringWithFormat:@"%3d",count];
}

- (void)setupUI
{
    UILabel *lable = [[UILabel alloc] init];
    self.timeLable = lable;
    lable.textAlignment = NSTextAlignmentCenter;
    lable.backgroundColor = [UIColor purpleColor];
    lable.textColor = [UIColor blackColor];
    lable.text = @"0000";
    [lable sizeToFit];
    [self.view addSubview:lable];
    lable.center = self.view.center;
    
    UIButton *start = [UIButton buttonWithType:UIButtonTypeCustom];
    self.startBtn = start;
    [self.view addSubview:start];
    [start setTitle:@"start record" forState:UIControlStateNormal];
    start.backgroundColor = [UIColor yellowColor];
    start.frame = CGRectMake(0, 0, 100, 100);
    [start addTarget:self action:@selector(startClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *stop = [UIButton buttonWithType:UIButtonTypeCustom];
    self.stopBtn = stop;
    [self.view addSubview:stop];
    [stop setTitle:@"stop record" forState:UIControlStateNormal];
    stop.frame = CGRectMake(0, 100, 100, 100);
    stop.backgroundColor = [UIColor redColor];
    [stop addTarget:self action:@selector(stopClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)startClicked:(UIButton *)btn
{
    RPScreenRecorder *recorder = [RPScreenRecorder sharedRecorder];
    if (!recorder.available) {
        NSLog(@"recorder is not available");
        return;
    }
    if (recorder.recording) {
        NSLog(@"it is recording");
        return;
    }
    [recorder startRecordingWithMicrophoneEnabled:YES handler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"start recorder error - %@",error);
        }
        
    }];
}

- (void)stopClicked:(UIButton *)btn
{
    RPScreenRecorder *recorder = [RPScreenRecorder sharedRecorder];
    if (!recorder.recording) {
        return;
    }
    [recorder stopRecordingWithHandler:^(RPPreviewViewController * _Nullable previewViewController, NSError * _Nullable error) {
        previewViewController.previewControllerDelegate = self;
        NSLog(@"subviews-%@",previewViewController.view.subviews);
        NSLog(@"subviews-%@",previewViewController.view.subviews[0].subviews);
        NSLog(@"subviews-%@",previewViewController.view.subviews[0].subviews[0].subviews);
        
        id view = previewViewController.view.subviews[0];
        id remote = [view performSelector:@selector(remoteViewController)];
        NSLog(@"remote- %@",remote);
        
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        UIView *coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width - 100, 64)];
        coverView.backgroundColor = [UIColor redColor];
        [previewViewController.view addSubview:coverView];
        
        
        SEL originalSelector = @selector(loadPreviewViewControllerWithMovieURL: completion:);
        [previewViewController performSelector:originalSelector withObject:[NSURL URLWithString:@"good"] withObject:nil];
        
        [self presentViewController:previewViewController animated:YES completion:nil];
    }];
}

- (void)previewControllerDidFinish:(RPPreviewViewController *)previewController
{
    [previewController dismissViewControllerAnimated:YES completion:nil];
}

/* @abstract Called when the view controller is finished and returns a set of activity types that the user has completed on the recording. The built in activity types are listed in UIActivity.h. */
- (void)previewController:(RPPreviewViewController *)previewController didFinishWithActivityTypes:(NSSet <NSString *> *)activityTypes
{
    NSLog(@"activity - %@",activityTypes);
}

@end
