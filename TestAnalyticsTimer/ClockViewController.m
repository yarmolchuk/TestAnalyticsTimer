//
//  ClockViewController.m
//  TestAnalyticsTimer
//
//  Created by Dima on 29.09.15.
//  Copyright © 2015 Axon Development Group. All rights reserved.
//

#import "ClockViewController.h"

@interface ClockViewController ()

@property IBOutlet UILabel *clockLabel;
@property NSTimer *timer;
@property NSDateFormatter *dateFormatter;

@end

@implementation ClockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.screenName = @"Clock";
}

- (void)viewWillAppear:(BOOL)animated{
    if(self.dateFormatter==nil){
        self.dateFormatter = [[NSDateFormatter alloc] init];
        [self.dateFormatter setDateFormat:@"hh:mm:ss"];
    }
    
    [self tick:nil];
    
    [self.timer invalidate];
    self.timer = nil;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick:) userInfo:nil repeats:YES];
}

- (void)tick:(NSTimer *)timer{
    self.clockLabel.text = [self.dateFormatter stringFromDate:[NSDate date]];
}

@end
