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
    
    [super willDisplay];
DLog(@"self bound object is %@",self.boundObject);
   
        
      self.cellSubTypeLabel.text=self.trackTypeWithTotalTimesObject.typeLabelText;
           
        
            
    
    self.layer.borderWidth=0;
    self.accessoryType=UITableViewCellAccessoryNone;

}

-(void)performInitialization{


   

}

-(void)loadBindingsIntoCustomControls{

    [super loadBindingsIntoCustomControls];
   
    
    self.trackTypeWithTotalTimesObject=(TrackTypeWithTotalTimes *) self.boundObject; 

    self.cellSubTypeLabel.text=trackTypeWithTotalTimesObject_.typeLabelText;
    
    if (!monthToDisplay_||!clinician_) {       
        monthToDisplay_=(NSDate *)self.trackTypeWithTotalTimesObject.monthToDisplay;
        
    }
    

    self.hoursWeek1Label.text=trackTypeWithTotalTimesObject_.totalWeek1Str;
    self.hoursWeek2Label.text=trackTypeWithTotalTimesObject_.totalWeek2Str;
    self.hoursWeek3Label.text=trackTypeWithTotalTimesObject_.totalWeek3Str;
    self.hoursWeek4Label.text=trackTypeWithTotalTimesObject_.totalWeek4Str;
    self.hoursWeek5Label.text=trackTypeWithTotalTimesObject_.totalWeek5Str;
    
    if (self.hoursWeekUndefinedLabel) {
        self.hoursWeekUndefinedLabel.text=trackTypeWithTotalTimesObject_.totalWeekUndefinedStr;
    }
    self.hoursMonthTotalLabel.text=trackTypeWithTotalTimesObject_.totalForMonthStr;
    self.hoursCumulativeLabel.text=trackTypeWithTotalTimesObject_.totalCummulativeStr;
    self.hoursTotalHoursLabel.text=trackTypeWithTotalTimesObject_.totalToDateStr;
    

    

    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


@end
