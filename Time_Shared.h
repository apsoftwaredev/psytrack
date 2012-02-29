//
//  Time_Shared.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 10/7/11.
//  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "SCTableViewModel.h"
#import "StopwatchCell.h"

@interface Time_Shared : NSObject <SCViewControllerDelegate, SCTableViewModelDataSource, SCTableViewModelDelegate,UIGestureRecognizerDelegate,SCTableViewCellDelegate>{



    NSTimer *timer;
    SCTableViewModel *tableModel;

    __weak UITextField *stopwatchTextField;
    __weak StopwatchCell *stopwatchCell;
    SCTableViewSection *timeSection;
    __weak UILabel *footerLabel;
    __weak UILabel *totalTimeHeaderLabel;
    
    BOOL viewControllerOpen;
    NSDate *startTime;
    NSDate *endTime;
    NSDate *additionalTime;
    NSDate *timeToSubtract;
    NSDateFormatter *counterDateFormatter;
    NSDate *referenceDate;
    NSDate *totalTimeDate;
    NSDate *addStopwatch;
    UILabel *breakTimeTotalHeaderLabel;
    SCTableViewSection *breakTimeSection;
    
}

@property (strong, nonatomic) IBOutlet SCTableViewModel *tableModel;
@property (weak, nonatomic) IBOutlet  UILabel *totalTimeHeaderLabel;
@property (weak, nonatomic) IBOutlet  UILabel *footerLabel;
@property (strong, nonatomic)   NSDate *totalTimeDate;

//@property (readwrite, nonatomic) IBOutlet NSTimeInterval pauseInterval;
//@property (readwrite, nonatomic) IBOutlet BOOL stopwatchRestartAfterStop;
//@property (strong, nonatomic) IBOutlet NSDate *stopwatchStartTime;
//@property (strong, nonatomic) IBOutlet NSDate *totalTime;
//
//@property (strong, nonatomic) IBOutlet NSDateFormatter *stopwatchFormat;
//@property (strong, nonatomic) IBOutlet NSDateFormatter *fullDateFormat;
//
//@property (strong, nonatomic) IBOutlet NSNumber *stopwatchRunning;
//@property (readwrite, nonatomic) IBOutlet BOOL stopwatchIsRunningBool;
//@property (readwrite, nonatomic) IBOutlet BOOL viewControllerOpen;
//@property (strong, nonatomic) IBOutlet NSDate *referenceDate;
//@property (strong, nonatomic) IBOutlet  NSManagedObject *managedObject;

@property (strong, nonatomic) IBOutlet SCClassDefinition *timeDef;
-(id)setupTheTimeViewUsingSTV;
-(void)calculateTime;
-(NSString *)tableViewModel:(SCTableViewModel *)tableViewModel calculateBreakTimeForRowAtIndexPath:(NSIndexPath *)indexPath withBoundValues:(BOOL)useBoundValues;
-(IBAction)stopwatchStop:(id)sender;
-(IBAction)stopwatchReset:(id)sender;
-(void)willDisappear;
-(NSTimeInterval ) totalBreakTimeInterval;

@end
