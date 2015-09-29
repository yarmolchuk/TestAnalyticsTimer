//
//  TimerViewController.m
//  TestAnalyticsTimer
//
//  Created by Dima on 29.09.15.
//  Copyright © 2015 Axon Development Group. All rights reserved.
//

#import "TimerViewController.h"

@interface TimerViewController ()

@property IBOutlet UILabel *timerLabel;
@property IBOutlet UIButton *toggle;

@property NSTimer *timer;
@property NSDateFormatter *dateFormatter;
@property NSInteger ticks;

@end

@implementation TimerViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"Timer"];
    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
}

- (IBAction)startToggle:(id)sender{
    [self logButtonPress:(UIButton *)sender];
    
    if(self.timer){
        [self stop:sender];
        [self.toggle setTitle:@"Start" forState:UIControlStateNormal];
    }
    else{
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(tick:) userInfo:nil repeats:YES];
        [self.toggle setTitle:@"Stop" forState:UIControlStateNormal];
    }
}

- (IBAction)reset:(id)sender{
    [self logButtonPress:(UIButton *)sender];
    [self stop:sender];
    [self.toggle setTitle:@"Start" forState:UIControlStateNormal];
    
    self.ticks = 0;
    self.timerLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d", 0, 0, 0];
}

- (void)stop:(id)sender{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)tick:(NSTimer *)t{
    self.ticks++;
    
    NSInteger lt = self.ticks % 100;
    NSInteger sec = floor((self.ticks / 100)%60);
    NSInteger min = floor((self.ticks / 100)/60);
    
    self.timerLabel.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)min, (long)sec, (long)lt];
}

- (void)logButtonPress:(UIButton *)button{
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker set:kGAIScreenName value:@"Timer"];
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"UX"
                                                          action:@"touch"
                                                           label:[button.titleLabel text]
                                                           value:nil] build]];
    [tracker set:kGAIScreenName value:nil];
}


@end
