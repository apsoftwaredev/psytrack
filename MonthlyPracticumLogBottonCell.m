/*
 *  MonthlyPracticumLogBottonCell.m
 *  psyTrack
 *  Version: 1.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. 
 *
 *  Created by Daniel Boice on  6/26/12.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */

#import "MonthlyPracticumLogBottonCell.h"
#import "InterventionTypeSubtypeEntity.h"
#import "MonthlyPracticumLogTopCell.h"
#import "QuartzCore/QuartzCore.h"
#import "ClinicianEntity.h"


@implementation MonthlyPracticumLogBottonCell

@synthesize trackTypeWithTotalTimesObject=trackTypeWithTotalTimesObject_;
@synthesize cellSubTypeLabel;
@synthesize hoursWeek1Label;
@synthesize hoursWeek2Label;
@synthesize hoursWeek3Label;
@synthesize hoursWeek4Label;
@synthesize hoursWeek5Label;
@synthesize hoursWeekUndefinedLabel;
@synthesize hoursMonthTotalLabel;
@synthesize hoursCumulativeLabel;
@synthesize hoursTotalHoursLabel;
@synthesize cellsContainerView;



-(void)willDisplay{
NSLog(@"self bound object is %@",self.boundObject);
   
    cellSubTypeLabel.text=trackTypeWithTotalTimesObject_.typeLabelText;
           
       
//        NSString *monthTotalStr=[interventionTypeSubtype totalHoursToDateForMonthStr:monthToDisplay];
        
        
//        NSLog(@"month total str is %@",monthTotalStr);
//        
//        self.hoursMonthTotalLabel.text=monthTotalStr;
        
   

        
        NSLog(@"month is %@ clinician is %@",monthToDisplay_,clinician_);
  
        
        self.hoursWeek1Label.text=trackTypeWithTotalTimesObject_.totalWeek1Str;
        self.hoursWeek2Label.text=trackTypeWithTotalTimesObject_.totalWeek2Str;
        self.hoursWeek3Label.text=trackTypeWithTotalTimesObject_.totalWeek3Str;
        self.hoursWeek4Label.text=trackTypeWithTotalTimesObject_.totalWeek4Str;
        self.hoursWeek5Label.text=trackTypeWithTotalTimesObject_.totalWeek5Str;
        
        if (trackTypeWithTotalTimesObject_.totalWeekUndefinedTI>0) {
            self.hoursWeekUndefinedLabel.text=trackTypeWithTotalTimesObject_.totalWeekUndefinedStr;
        }
        self.hoursMonthTotalLabel.text=trackTypeWithTotalTimesObject_.totalForMonthStr;
        self.hoursCumulativeLabel.text=trackTypeWithTotalTimesObject_.totalCummulativeStr;
        self.hoursTotalHoursLabel.text=trackTypeWithTotalTimesObject_.totalToDateStr;
    
    
    
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

    id trackTypeObject=(id )self.boundObject;
    
   
    
   self.trackTypeWithTotalTimesObject=[[TrackTypeWithTotalTimes alloc]initWithMonth:monthToDisplay_ clinician:clinician_ trackTypeObject:trackTypeObject]; 
    
    
    
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
