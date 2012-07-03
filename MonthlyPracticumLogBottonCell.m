//
//  MonthlyPracticumLogBottonCell.m
//  PsyTrack
//
//  Created by Daniel Boice on 6/26/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "MonthlyPracticumLogBottonCell.h"
#import "InterventionTypeSubtypeEntity.h"
#import "MonthlyPracticumLogTopCell.h"
#import "QuartzCore/QuartzCore.h"
#import "ClinicianEntity.h"
@implementation MonthlyPracticumLogBottonCell


@synthesize cellSubTypeLabel;
@synthesize hoursWeek1Label;
@synthesize hoursWeek2Label;
@synthesize hoursWeek3Label;
@synthesize hoursWeek4Label;
@synthesize hoursWeek5Label;
@synthesize hoursMonthTotalLabel;
@synthesize hoursCumulativeLabel;
@synthesize hoursTotalHoursLabel;
@synthesize cellsContainerView;



-(void)willDisplay{

NSLog(@"self bound object is %@",self.boundObject);
    InterventionTypeSubtypeEntity *interventionTypeSubtype=(InterventionTypeSubtypeEntity *)self.boundObject;
    [interventionTypeSubtype willAccessValueForKey:@"interventionSubtype"];
    
    cellSubTypeLabel.text=interventionTypeSubtype.interventionSubType;
    [interventionTypeSubtype didAccessValueForKey:@"interventionSubtype"];
    
    NSLog(@"superview class is %@",[self.superview.superview.superview.superview.superview class]);
    NSLog(@"superview subviews are %@",[[[[self.superview.superview.subviews objectAtIndex:0] subviews]objectAtIndex:1] subviews]);
        
        
       
//        NSString *monthTotalStr=[interventionTypeSubtype totalHoursToDateForMonthStr:monthToDisplay];
        
        
//        NSLog(@"month total str is %@",monthTotalStr);
//        
//        self.hoursMonthTotalLabel.text=monthTotalStr;
        
    if ((!monthToDisplay_||!clinician_)&& [self.superview.superview.superview.superview.superview isKindOfClass:[MonthlyPracticumLogTopCell class]]) {
        MonthlyPracticumLogTopCell *monthlyPracticumLogTopCell=(MonthlyPracticumLogTopCell *)self.superview.superview.superview.superview.superview;
        
        
        monthToDisplay_=(NSDate *)monthlyPracticumLogTopCell.monthToDisplay;
        clinician_=(ClinicianEntity *)monthlyPracticumLogTopCell.clinician;
    }
        self.hoursMonthTotalLabel.text=[interventionTypeSubtype totalHoursToDateForMonthStr:monthToDisplay_  clinician:(ClinicianEntity*)clinician_];
        self.hoursWeek1Label.text=[interventionTypeSubtype week1TotalHoursForMonthStr:monthToDisplay_ clinician:clinician_];
        self.hoursWeek2Label.text=[interventionTypeSubtype week2TotalHoursForMonthStr:monthToDisplay_ clinician:(ClinicianEntity*)clinician_];
        self.hoursWeek3Label.text=[interventionTypeSubtype week3TotalHoursForMonthStr:monthToDisplay_ clinician:(ClinicianEntity*)clinician_];
        self.hoursWeek4Label.text=[interventionTypeSubtype week4TotalHoursForMonthStr:monthToDisplay_ clinician:(ClinicianEntity*)clinician_];
        self.hoursWeek5Label.text=[interventionTypeSubtype week5TotalHoursForMonthStr:monthToDisplay_ clinician:(ClinicianEntity*)clinician_];
  
    
    
    self.layer.borderWidth=0;
    self.accessoryType=UITableViewCellAccessoryNone;

}

-(void)performInitialization{


   

}
-(void)loadBindingsIntoCustomControls{

    [super loadBindingsIntoCustomControls];
    
    if ((!monthToDisplay_||!clinician_)&& [self.superview.superview.superview.superview.superview isKindOfClass:[MonthlyPracticumLogTopCell class]]) {
        MonthlyPracticumLogTopCell *monthlyPracticumLogTopCell=(MonthlyPracticumLogTopCell *)self.superview.superview.superview.superview.superview;
        
        
        monthToDisplay_=(NSDate *)monthlyPracticumLogTopCell.monthToDisplay;
        clinician_=(ClinicianEntity *)monthlyPracticumLogTopCell.clinician;
    }

}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
