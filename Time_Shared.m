//
//  Time_Shared.m
//  psyTrainTrack
//
//  Created by Daniel Boice on 10/7/11.
//  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
//

#import "Time_Shared.h"
#import "PTTAppDelegate.h"
#import "ButtonCell.h"
#import "TimePickerCell.h"
//#import "PickerCell.h"


@implementation Time_Shared
@synthesize timeDef;

@synthesize footerLabel,totalTimeHeaderLabel;
@synthesize tableModel;
@synthesize totalTimeDate;



//@synthesize pauseTime,addStopwatch,stopwatchStartTime,referenceDate,totalTime;
//@synthesize stopwatchFormat,fullDateFormat;
//@synthesize pauseInterval;
//
//@synthesize stopwatchRestartAfterStop,stopwatchIsRunningBool,viewControllerOpen;
//@synthesize stopwatchRunning;
//
//
//@synthesize managedObject;
//
//- (id)initWithManagedObject:(NSManagedObject *)manObjt{
//
//
//  managedObject=manObjt;
//    return self;
//}
//
//- (id)init {
//stopwatchFormat=[[NSDateFormatter alloc]init];
//[stopwatchFormat setDateFormat:@"HH:mm:ss"];
//[stopwatchFormat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];  
//
//fullDateFormat=[[NSDateFormatter alloc]init];
//[fullDateFormat setDateFormat:@"y-mm-dd HH:mm:dd"];
//referenceDate=[stopwatchFormat dateFromString:@"00:00:00"];
//
//    [self resetValuesToDefault];
//    return self;
//}
//
//-(void)resetValuesToDefault{
//
//
//    stopwatchRestartAfterStop=NO;
//    stopwatchIsRunningBool=NO;
//    stopwatchRunning=nil;
//    pauseTime=nil;
//    addStopwatch=nil;
//    stopwatchStartTime=nil;
//
//
//
//
//}


-(id)setupTheTimeViewUsingSTV {

    NSManagedObjectContext *managedObjectContext= [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];

    //set up the date time formatters
    NSDateFormatter *shortTimeFormatter = [[NSDateFormatter alloc] init];
	[shortTimeFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    NSDateFormatter *additionalTimeFormatter = [[NSDateFormatter alloc] init];
	[additionalTimeFormatter setDateFormat:@"H:mm"];
    [additionalTimeFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    //Create a class definition for the TimeEntity
    self.timeDef = [SCClassDefinition definitionWithEntityName:@"TimeEntity" 
                                                    withManagedObjectContext:managedObjectContext
                                                           withPropertyNames:[NSArray arrayWithObjects:@"startTime", @"endTime", @"breaks", @"notes"    , nil]];
    
    //Do some property definition customization for the Time Entity defined in timeDef
    //Create the property definition for the startTime property in the timeDef class  definition
    
    SCPropertyDefinition *startTimePropertyDef = [self.timeDef propertyDefinitionWithName:@"startTime"];
	startTimePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:shortTimeFormatter 
                                                                     datePickerMode:UIDatePickerModeTime 
                                                      displayDatePickerInDetailView:YES];
    SCPropertyDefinition *endTimePropertyDef = [self.timeDef propertyDefinitionWithName:@"endTime"];
	endTimePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:shortTimeFormatter 
                                                                   datePickerMode:UIDatePickerModeTime 
                                                    displayDatePickerInDetailView:YES];
        
    NSString *timePickerCellNibName;
    
    if([SCHelper is_iPad])
        timePickerCellNibName=[NSString stringWithString:@"TimePickerCell_iPad"];
    else
        timePickerCellNibName=[NSString stringWithString:@"TimePickerCell"];
    
    
    
    //create the dictionary with the data bindings
    NSDictionary *additionalTimeDataBindings = [NSDictionary 
                                                    dictionaryWithObjects:[NSArray arrayWithObjects:@"additionalTime",@"additionalTime", @"Additional Time", nil ] 
                                                    forKeys:[NSArray arrayWithObjects:@"40" , @"41",@"42",   nil]]; // 40, 41,42 are the control tags
	
    //create the custom property definition for addtional time
    SCCustomPropertyDefinition *additionalTimePropertyDef = [SCCustomPropertyDefinition definitionWithName:@"AdditionalTime" withuiElementNibName:timePickerCellNibName  withObjectBindings:additionalTimeDataBindings];	
    
    //set the autovalidate to false to catch the validation event with a custom validation, which is needed for custom cells
    additionalTimePropertyDef.autoValidate=FALSE;
    
	
    
    [self.timeDef insertPropertyDefinition:additionalTimePropertyDef atIndex:2];
    //create the dictionary with the data bindings
    NSDictionary *subtractTimeDataBindings = [NSDictionary 
                                                    dictionaryWithObjects:[NSArray arrayWithObjects:@"timeToSubtract",@"timeToSubtract", @"Time To Subtract", nil ] 
                                                    forKeys:[NSArray arrayWithObjects:@"40" , @"41",@"42",   nil]]; // 40, 41,42 are the control tags
	
    //create the custom property definition
    SCCustomPropertyDefinition *subtractTimePropertyDef = [SCCustomPropertyDefinition definitionWithName:@"SubtractTime" withuiElementNibName:timePickerCellNibName  withObjectBindings:subtractTimeDataBindings];	
    
    //set the autovalidate to false to catch the validation event with a custom validation, which is needed for custom cells
    subtractTimePropertyDef.autoValidate=NO;
    
	
    
    [self.timeDef insertPropertyDefinition:subtractTimePropertyDef atIndex:3];
    
    
    
    //Create a property definition for the notes property.
    SCPropertyDefinition *timeNoesPropertyDef = [timeDef propertyDefinitionWithName:@"notes"];
    
    //set the notes property definition type to a Text View Cell
    timeNoesPropertyDef.type = SCPropertyTypeTextView;
    
    //create the dictionary with the data bindings
    NSDictionary *stopwatchDataBindings = [NSDictionary 
                                           dictionaryWithObjects:[NSArray arrayWithObjects: @"addStopwatch",@"stopwatchRunning", @"pauseInterval", @"pauseTime", @"stopwatchStartTime",   @"stopwatchRestartAfterStop" ,@"totalTime", nil] 
                                           forKeys:[NSArray arrayWithObjects: @"addStopwatch",@"stopwatchRunning", @"pauseInterval",  @"pauseTime",  @"stopwatchStartTime",  @"stopwatchRestartAfterStop", @"totalTime", nil ]]; // 63 is the control tag for the textField

   
       
    //create a custom property definition for the Button Cell
    SCCustomPropertyDefinition *buttonProperty = [SCCustomPropertyDefinition definitionWithName:@"buttonCell" withuiElementClass:[ButtonCell class] withObjectBindings:nil];

    //add the property definition to the timeDef class 
    [self.timeDef insertPropertyDefinition:buttonProperty atIndex:4];
   
    
    //create the custom property definition
    SCCustomPropertyDefinition *stopwatchDataProperty = [SCCustomPropertyDefinition definitionWithName:@"StopwatchData"
                                                                                  withuiElementNibName:@"StopwatchCell" 
                                                                                    withObjectBindings:stopwatchDataBindings];
	
    
    
   
    
    //insert the custom property definition into the testingSessionDelivered class at index 1
    [self.timeDef insertPropertyDefinition:stopwatchDataProperty atIndex:5];
    
    
    
    //Create a class definition for the BreakTimeEntity
    SCClassDefinition *breakTimeDef = [SCClassDefinition definitionWithEntityName:@"BreakTimeEntity" 
                                                        withManagedObjectContext:managedObjectContext
                                                               withPropertyNames:[NSArray arrayWithObjects:@"reason", @"startTime", @"endTime", @"breakNotes",       nil]];
    
  
//     timeDef.requireEditingModeToEditPropertyValues = TRUE; // lock all property values until put in editing mode
    
    breakTimeDef.orderAttributeName=@"order";
    //Create a class definition for the BreakTimeReasonEntity
    SCClassDefinition *breakTimeReasonDef = [SCClassDefinition definitionWithEntityName:@"BreakTimeReasonEntity" 
                                                        withManagedObjectContext:managedObjectContext
                                                               withPropertyNames:[NSArray arrayWithObjects:@"breakName",nil]];
    
    
    breakTimeReasonDef.orderAttributeName=@"order";
    //Do some property definition customization for the BreakTime Entity defined in breakTimeDef
   
    
    //create a property definition for the reason property in the breakDef class
    SCPropertyDefinition *breaksPropertyDef = [timeDef propertyDefinitionWithName:@"breaks"];
    
 
    
       
    
    breaksPropertyDef.attributes = [SCArrayOfObjectsAttributes attributesWithObjectClassDefinition:breakTimeDef
                                                                                  allowAddingItems:YES
                                                                                allowDeletingItems:YES
                                                                                  allowMovingItems:YES
                                                                        expandContentInCurrentView:YES 
                                                                              placeholderuiElement:nil 
                                                                             addNewObjectuiElement:[SCTableViewCell cellWithText:@"Tap Here To Add Break"] addNewObjectuiElementExistsInNormalMode:YES addNewObjectuiElementExistsInEditingMode:YES];	
    
    breakTimeDef.requireEditingModeToEditPropertyValues=TRUE;
    
    //create a property definition
    SCPropertyDefinition *breakTimeReasonPropertyDef = [breakTimeDef propertyDefinitionWithName:@"reason"];
    
    //set a custom title
    breakTimeReasonPropertyDef.title =@"Break Reason";
    
    //set the title property name
    breakTimeDef.titlePropertyName=@"reason.breakName";

    
    
    breakTimeReasonPropertyDef.type = SCPropertyTypeObjectSelection;
	SCObjectSelectionAttributes *breakTimeReasonSelectionAttribs = [SCObjectSelectionAttributes attributesWithItemsEntityClassDefinition:breakTimeReasonDef allowMultipleSelection:NO allowNoSelection:NO];
    breakTimeReasonSelectionAttribs.allowAddingItems = YES;
    breakTimeReasonSelectionAttribs.allowDeletingItems = YES;
    breakTimeReasonSelectionAttribs.allowMovingItems = YES;
    breakTimeReasonSelectionAttribs.allowEditingItems = YES;
    breakTimeReasonSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Tap Edit to Add Break Reasons)"];
    breakTimeReasonSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add Break Definition"];
    breakTimeReasonPropertyDef.attributes = breakTimeReasonSelectionAttribs;
    SCPropertyDefinition *breakTimeNotesPropertyDef = [breakTimeDef propertyDefinitionWithName:@"breakNotes"];
    breakTimeNotesPropertyDef.type=SCPropertyTypeTextView;
    
 breakTimeReasonDef.titlePropertyName=@"breakName";

 
    
      
    //Create the property definition for the startTime property in the breakTime class  definition
    SCPropertyDefinition *startTimeBreakPropertyDef = [breakTimeDef propertyDefinitionWithName:@"startTime"];
    
   
    //Set the date attributes in the startTime property definition and make it so the date picker appears in a separate view.
    startTimeBreakPropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:shortTimeFormatter
                                                                   datePickerMode:UIDatePickerModeTime
                                                    displayDatePickerInDetailView:YES];
    

    //Create the property definition for the Break endTime property in the breakTime class  definition
    SCPropertyDefinition *endTimeBreakPropertyDef = [breakTimeDef propertyDefinitionWithName:@"endTime"];
    
    //format the the date using a date formatter
   
    //Set the date attributes in the endTime for break property definition and make it so the date picker appears in a separate view.
    endTimeBreakPropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:shortTimeFormatter
                                                                   datePickerMode:UIDatePickerModeTime
                                                    displayDatePickerInDetailView:YES];
    
       
       
  

	
    //create the dictionary with the data bindings
    NSDictionary *breakUndefinedTimeDataBindings = [NSDictionary 
                                          dictionaryWithObjects:[NSArray arrayWithObjects:@"undefinedTime",@"undefinedTime", @"Undefined Time", nil ] 
                                          forKeys:[NSArray arrayWithObjects:@"40" , @"41",@"42",   nil]]; // 40, 41,42 are the control tags
	
    //create the custom property definition
    SCCustomPropertyDefinition *breakUndefinedTimePropertyDef = [SCCustomPropertyDefinition definitionWithName:@"BreakAdditionalTime" withuiElementNibName:timePickerCellNibName  withObjectBindings:breakUndefinedTimeDataBindings];	
    
    //set the autovalidate to false to catch the validation event with a custom validation, which is needed for custom cells
    breakUndefinedTimePropertyDef.autoValidate=YES;
 
	
    
    [breakTimeDef insertPropertyDefinition:breakUndefinedTimePropertyDef atIndex:3];
    
     //create a custom property definition for the Button Cell
    SCCustomPropertyDefinition *buttonBreakTimeClearPropertyDef = [SCCustomPropertyDefinition definitionWithName:@"buttonBreakTimeClearCell" withuiElementClass:[ButtonCell class] withObjectBindings:nil];
    
    [breakTimeDef insertPropertyDefinition:buttonBreakTimeClearPropertyDef atIndex:4];
    

    
    
    SCPropertyGroup *timeGroup=[SCPropertyGroup groupWithHeaderTitle:nil withFooterTitle:nil withPropertyNames:[NSArray arrayWithObjects:@"startTime", @"endTime" ,@"AdditionalTime", @"SubtractTime", @"buttonCell",   @"StopwatchData",     nil]];

    SCPropertyGroup *breaksGroup=[SCPropertyGroup groupWithHeaderTitle:@"Breaks" withFooterTitle:nil withPropertyNames:[NSArray arrayWithObject:@"breaks"]];
    
    SCPropertyGroup *notesGroup=[SCPropertyGroup groupWithHeaderTitle:nil withFooterTitle:nil withPropertyNames:[NSArray arrayWithObject:@"notes"]];
    
    SCPropertyGroup *breakNotesGroup=[SCPropertyGroup groupWithHeaderTitle:nil withFooterTitle:nil withPropertyNames:[NSArray arrayWithObject:@"breakNotes"]];
   
    [timeDef.propertyGroups addGroup:timeGroup];
    [timeDef.propertyGroups addGroup:breaksGroup];
    [timeDef.propertyGroups addGroup:notesGroup];
    [breakTimeDef.propertyGroups addGroup:breakNotesGroup];
    
    counterDateFormatter=[[NSDateFormatter alloc]init];
    [counterDateFormatter setDateFormat:@"HH:mm:ss"];
    
    [counterDateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];  
    
    
    referenceDate=[counterDateFormatter dateFromString:@"00:00:00"];
    
    

    
    return  self;
}
-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailModelCreatedForRowAtIndexPath:(NSIndexPath *)indexPath detailTableViewModel:(SCTableViewModel *)detailTableViewModel{
    
    [self tableViewModel:(SCTableViewModel *)tableViewModel detailModelCreatedForSectionAtIndex:(NSUInteger )indexPath.section detailTableViewModel:(SCTableViewModel *)detailTableViewModel];
    
    
    
    
}

-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailModelCreatedForSectionAtIndex:(NSUInteger)index detailTableViewModel:(SCTableViewModel *)detailTableViewModel{
    
    [detailTableViewModel.modeledTableView setBackgroundView:nil];
    [detailTableViewModel.modeledTableView setBackgroundView:[[UIView alloc] init]];
    [detailTableViewModel.modeledTableView setBackgroundColor:UIColor.clearColor]; // Make the table view transparent
    
    
   
}



-(IBAction)stopwatchReset:(id)sender{
    
    
    [self calculateTime];
    
}

-(void)calculateTime
{
    
    
    
        SCTableViewSection *section=[tableModel sectionAtIndex:0];
        
   
        SCDateCell *startTimeCell =(SCDateCell *)[section cellAtIndex:0];
        SCDateCell *endTimeEndTimeCell =(SCDateCell *)[section cellAtIndex:1];
        TimePickerCell *additionalTimeCell =(TimePickerCell *)[section cellAtIndex:2];
        TimePickerCell *subtractTimeCell =(TimePickerCell *)[section cellAtIndex:3];
    if (startTimeCell.label.text.length) {
        startTime=startTimeCell.datePicker.date;
        
    }
    else{startTime=referenceDate;}
    
    if (endTimeEndTimeCell.label.text.length) {
        endTime=endTimeEndTimeCell.datePicker.date;
    }
    else{endTime=referenceDate;}
    
    if (additionalTimeCell.timeValue) {
        additionalTime=additionalTimeCell.timeValue;
    }
    else{additionalTime=referenceDate;}
    
    if (subtractTimeCell.timeValue) {
        timeToSubtract=subtractTimeCell.timeValue;
    }
    else{timeToSubtract=referenceDate;}
    
    
        
    if (startTime && startTime != referenceDate &&endTime &&endTime!=referenceDate) {
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc ]init];
        [dateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
        [dateFormatter setDateFormat:@"H:mm"];
        NSDateFormatter *dateFormatClearSeconds=[[NSDateFormatter alloc]init];
        [dateFormatClearSeconds setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        [dateFormatClearSeconds setDateFormat:@"H:mm"];
        
        startTime=[dateFormatClearSeconds dateFromString:[dateFormatter stringFromDate:startTime]];
        endTime=[dateFormatClearSeconds dateFromString:[dateFormatter stringFromDate:endTime]];
        NSLog(@"start time %@ end time %@ additioanl time %@ time to subtract %@",startTime,endTime,additionalTime,timeToSubtract);

        
    }
   
        
        
    if (stopwatchCell.addStopwatch) {
        addStopwatch=stopwatchCell.addStopwatch;
    }
    
    NSTimeInterval startAndEndTimeInterval=0.0;
    if (startTimeCell.label.text.length>0&&endTimeEndTimeCell.label.text.length>0) {
        if ([endTime timeIntervalSinceDate:startTime]>0.0)
        {
            
            startAndEndTimeInterval=[endTime timeIntervalSinceDate:startTime];
        }
    }
    
    
    if ([additionalTime timeIntervalSinceDate:referenceDate]>0.0) 
    {
        startAndEndTimeInterval=startAndEndTimeInterval+[additionalTime timeIntervalSinceDate:referenceDate];
    }
   
    if ([addStopwatch timeIntervalSinceDate:referenceDate]>0.0) {
        startAndEndTimeInterval=startAndEndTimeInterval+[addStopwatch timeIntervalSinceDate:referenceDate];
    }
    if ([timeToSubtract timeIntervalSinceDate:referenceDate]>0.0) {
        startAndEndTimeInterval=startAndEndTimeInterval-[timeToSubtract timeIntervalSinceDate:referenceDate];
    }
   
    NSString *totalTimeString;
    if (startAndEndTimeInterval>=0.983333) {
        
        //cut off miliseconds
        
        totalTimeString=[NSString stringWithFormat:@"%f",startAndEndTimeInterval];
        
        
        NSRange range;
        range.length=6;
        range.location=totalTimeString.length-6;
        totalTimeString=[totalTimeString stringByReplacingCharactersInRange:range withString:@"000000"];
        
        
        startAndEndTimeInterval=[totalTimeString doubleValue];
    }
    else
    {
        
        startAndEndTimeInterval=0;
    }
    
    NSTimeInterval totalBreakTime=[self totalBreakTimeInterval];

    if ( startAndEndTimeInterval>totalBreakTime) {
        startAndEndTimeInterval=startAndEndTimeInterval-totalBreakTime;
    }
    else if(totalBreakTime>0){
    
        startAndEndTimeInterval=0.0;
    }

    
  

    totalTimeDate=[referenceDate dateByAddingTimeInterval:startAndEndTimeInterval];
    
    
    
    
    //define a gregorian calandar
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    //define the calandar unit flags
    NSUInteger unitFlags = NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    //define the date components
    NSDateComponents *dateComponents = [gregorianCalendar components:unitFlags
                                                            fromDate:startTime
                                                              toDate:endTime
                                                             options:0];
    
    
    
    
    float day, hour, minute, second;
    day=[dateComponents day];
    hour=[dateComponents hour];
    minute=[dateComponents minute];
    second= [dateComponents second];
    
  
    
    
    //    }
    
    
  
    
    totalTimeHeaderLabel.text=[NSString stringWithFormat:@"Total Time:%@",[counterDateFormatter stringFromDate:totalTimeDate]];
    
    //     totalTimeString=[NSString stringWithFormat:@"start time is %@, end time is %@, additional time is %@, timeToSubtract is %@",startTime,endTime, additionalTime, timeToSubtract];
    //    return totalTimeDate;
    
    
    
}







-(IBAction)stopwatchUpdated:(id)sender {
    
    [self calculateTime];
    
}

-(IBAction)stopwatchStop:(id)sender{
    
    
    [self calculateTime];
    
    
}

-(void)tableViewModel:(SCTableViewModel *)tableViewModel willConfigureCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
 
    NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
    
//    if(tableViewModel.tag==1){
//        
//        if (cell.tag==1) {
//            if ([cell isKindOfClass:[SCObjectCell class]]) {
//                
//                
//                if (![cell viewWithTag:28] ) {
//                    
//                    UILabel *totalTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(cell.frame.size.width-125, 5, 85, 30)];
//                    
//                    
//                    totalTimeLabel.tag=28;
//                    totalTimeLabel.text=[NSString stringWithFormat:@"00:00:00"];
//                    totalTimeLabel.backgroundColor=[UIColor clearColor];
//                    totalTimeLabel.textAlignment=UITextAlignmentRight;
//                    totalTimeLabel.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
//                    [totalTimeLabel setFont:[UIFont fontWithName:@"Arial Rounded MT Bold" size:18]];
//                    totalTimeLabel.textColor=[UIColor colorWithRed:50.0f/255 green:69.0f/255 blue:133.0f/255 alpha:1.0];
//                    [cell addSubview:(UIView *)totalTimeLabel];
//                    
//                    
//                }
//            }
//        }
//        
//        
//        
//        
//    }
    if (tableViewModel.tag==2) {
     
        
        
        if (indexPath.section==0) {
            
            if (cell.tag==2||cell.tag==3) 
                
            {
                if ([cell isKindOfClass:[SCDateCell class]]) {
                    SCDateCell *dateCell= (SCDateCell *) cell;
                    //define a gregorian calandar
                    //                    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
                    //                    
                    
                    [dateCell.dateFormatter setDefaultDate:referenceDate];
                    
                    [dateCell.dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
                    
                    [dateCell.datePicker setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
                }
                
            }
            
            
            switch (cell.tag) 
            {
                    
                    
                case 5:
                {
                    
                    if ([cell class]==[StopwatchCell class]) {
                        stopwatchCell=(StopwatchCell *)cell;
                        stopwatchTextField=(UITextField *)stopwatchCell.stopwatchTextField;
                        
                        [[NSNotificationCenter defaultCenter]
                         addObserver:self
                         selector:@selector(stopwatchUpdated:)
                         name:@"addStopwatchChanged"
                         object:nil];
                        
                        [[NSNotificationCenter defaultCenter]
                         addObserver:self
                         selector:@selector(stopwatchReset:)
                         name:@"stopwatchResetButtonTapped"
                         object:nil];  
                        
                        [[NSNotificationCenter defaultCenter]
                         addObserver:self
                         selector:@selector(stopwatchStop:)
                         name:@"stopwatchStopButtonTapped"
                         object:nil];
                        
                        timeSection=[tableViewModel sectionAtIndex:0];
                    }
                    
           
                }
                    
                    break;
                case 4:
                {
                    
                    if ([cell isKindOfClass:[ButtonCell class]]) {
                        
                        
                        UIButton *button =(UIButton *)[cell viewWithTag:300];
                        [button setTitle:@"Clear Times" forState:UIControlStateNormal];
                        button.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin;
                        cell.backgroundColor=[UIColor clearColor];
                        
                        
                    }
                }
                    break;
                    
                default:
                    break;
            }
            
        }  
        
        if (indexPath.section==1) {
            
            
            if ([cellManagedObject.entity.name isEqualToString:@"BreakTimeEntity"]) 
            {
                
                if (![cell viewWithTag:28]) {
                    
                    
                    
                    UILabel *totalBreakTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(cell.frame.size.width-125, 5, 85, 30)];
                    totalBreakTimeLabel.tag=28;
                    totalBreakTimeLabel.text=[NSString stringWithFormat:@"00:00:00"];
                    totalBreakTimeLabel.backgroundColor=[UIColor clearColor];
                    totalBreakTimeLabel.textAlignment=UITextAlignmentRight;
                    totalBreakTimeLabel.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
                    [totalBreakTimeLabel setFont:[UIFont fontWithName:@"Arial Rounded MT Bold" size:18]];
                    totalBreakTimeLabel.textColor=[UIColor colorWithRed:50.0f/255 green:69.0f/255 blue:133.0f/255 alpha:1.0];
                    [cell addSubview:(UIView *)totalBreakTimeLabel];
                    
                    [cell reloadInputViews];
                }
            }
            
        }
        
    }
    
    if (tableViewModel.tag==3) 
    {
        
        if ([cellManagedObject.entity.name isEqualToString:@"BreakTimeEntity"]) {
            
                       
            
            if (cell.tag==4) {
                if ([cell isKindOfClass:[ButtonCell class]]) 
                {
                    UIButton *button =(UIButton *)[cell viewWithTag:300];
                    [button setTitle:@"Clear Times" forState:UIControlStateNormal];
                    button.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin;
                    cell.backgroundColor=[UIColor clearColor];
                }
            }
            
            
        }
        
    }
}


-(void) tableViewModel:(SCTableViewModel *)tableViewModel customButtonTapped:(UIButton *)button forRowWithIndexPath:(NSIndexPath *)indexPath{
    
    
    SCTableViewSection *section=(SCTableViewSection *)[tableViewModel sectionAtIndex:indexPath.section];
    
    if (tableViewModel.tag==2) 
    {
        
        
        if (section.cellCount>=6) 
        {
            
            if ([[section cellAtIndex:5] class]==[StopwatchCell class]) 
            {
                
                
                
                switch (button.tag)
                {
                    case 300:
                        // clear the times
                    {
                        if (section.cellCount>3) {
                            
                            if ([[section cellAtIndex:0]isKindOfClass:[SCDateCell class]]) {
                                
                                SCDateCell *startTimeCell=(SCDateCell *)[section cellAtIndex:0];
                                SCDateCell *endTimeCell=(SCDateCell *)[section cellAtIndex:1];
                                TimePickerCell *additionalTimeCell=(TimePickerCell *)[section cellAtIndex:2];
                                TimePickerCell *timeToSubtractCell=(TimePickerCell *)[section cellAtIndex:3];
                                
                                [startTimeCell.boundObject setValue:nil forKey:@"startTime"];
                                [endTimeCell.boundObject setValue:nil forKey:@"endTime"];
                                [additionalTimeCell.boundObject setValue:referenceDate forKey:@"additionalTime"];
                                [timeToSubtractCell.boundObject setValue:referenceDate forKey:@"timeToSubtract"];
                                
                                startTime=nil;
                                
                                endTime=nil;
                                
                                additionalTime=nil;
                                
                                
                                
                                timeToSubtract=nil;
                                [section reloadBoundValues];
                                
                                [self calculateTime];
                            }
                        }
                        break;
                    }
                }
            }
        }
        
    }
    if (tableViewModel.tag==3) 
    {
        NSManagedObject *sectionManagedObject=(NSManagedObject *)section.boundObject;
        if ([sectionManagedObject.entity.name isEqualToString:@"BreakTimeEntity"]) {
            
            switch (button.tag)
            {
                case 300:
                    // clear the times
                {
                    SCDateCell *startTimeCell=(SCDateCell *)[section cellAtIndex:1];
                    SCDateCell *endTimeCell=(SCDateCell *)[section cellAtIndex:2];
                    TimePickerCell *undefinedTimeCell=(TimePickerCell *)[section cellAtIndex:3];
                    
                    
                    [startTimeCell.boundObject setNilValueForKey:@"startTime"];
                    [endTimeCell.boundObject setNilValueForKey:@"endTime"];
                    [undefinedTimeCell.boundObject setValue:referenceDate forKey:@"undefinedTime"];
                    
                    
                   
                    
                    [startTimeCell reloadBoundValue];
                    [endTimeCell reloadBoundValue];
                    [undefinedTimeCell reloadBoundValue];
                    breakTimeTotalHeaderLabel.text=[self tableViewModel:tableViewModel calculateBreakTimeForRowAtIndexPath:indexPath withBoundValues:YES];
                    
                }
            }
        }
    }
}

-(void)willDisappear{

    [stopwatchCell invalidateTheTimer];
    [[NSNotificationCenter defaultCenter]
     removeObserver:self];
    [[NSNotificationCenter defaultCenter]
     removeObserver:self];
    
    [[NSNotificationCenter defaultCenter]
     removeObserver:self];
      [self calculateTime];
    viewControllerOpen=FALSE;

}

-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailViewWillAppearForSectionAtIndex:(NSUInteger)index withDetailTableViewModel:(SCTableViewModel *)detailTableViewModel{
    
    if (detailTableViewModel.tag==2) {
        [detailTableViewModel.modeledTableView setEditing:YES animated:NO];
        
    }
    
    
    
    
}
-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailViewWillAppearForRowAtIndexPath:(NSIndexPath *)indexPath withDetailTableViewModel:(SCTableViewModel *)detailTableViewModel{
    
    
    if (detailTableViewModel.tag==2) {
        [detailTableViewModel.modeledTableView setEditing:YES animated:NO];
       
        
    }
    
    
}



-(NSTimeInterval ) totalBreakTimeInterval{
    
    SCArrayOfObjectsSection *arrayOfObjectsSection=(SCArrayOfObjectsSection *)[ tableModel sectionAtIndex:1];
 
  
    NSDate *breakStartTime, *breakEndTime,*breakUndefinedTime;
    
    
    NSTimeInterval totalBreakTimeInterval=0;
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc ]init];
    [dateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
    [dateFormatter setDateFormat:@"H:mm"];
    NSDateFormatter *dateFormatClearSeconds=[[NSDateFormatter alloc]init];
    [dateFormatClearSeconds setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [dateFormatClearSeconds setDateFormat:@"H:mm"];
    
    for(id obj in arrayOfObjectsSection.itemsSet) { 
        
        breakStartTime=(NSDate *)[obj valueForKey:@"startTime"];
        breakEndTime=(NSDate *)[obj valueForKey:@"endTime"];
        breakUndefinedTime=(NSDate *)[obj valueForKey:@"undefinedTime"];
        
       
        if (breakStartTime && breakStartTime != referenceDate &&breakEndTime &&breakEndTime!=referenceDate) {
           
            
            breakStartTime=[dateFormatClearSeconds dateFromString:[dateFormatter stringFromDate:breakStartTime]];
            breakEndTime=[dateFormatClearSeconds dateFromString:[dateFormatter stringFromDate:breakEndTime]];
           

            
           
            
        }
        
           NSTimeInterval startAndEndTimeInterval=[breakEndTime timeIntervalSinceDate:breakStartTime]+[breakUndefinedTime timeIntervalSinceDate:referenceDate];
        totalBreakTimeInterval=totalBreakTimeInterval+startAndEndTimeInterval;
    }
                                    
    
    NSString *totalTimeString;
    if (totalBreakTimeInterval>=1) {
        
        //cut off miliseconds
        
        totalTimeString=[NSString stringWithFormat:@"%f",totalBreakTimeInterval];
        NSLog(@"totoal time string is %@", totalTimeString);
        
        NSRange range;
        range.length=6;
        range.location=totalTimeString.length-6;
        totalTimeString=[totalTimeString stringByReplacingCharactersInRange:range withString:@"000000"];
        
        
        totalBreakTimeInterval=[totalTimeString doubleValue];
    }
    else
    {
        
        totalBreakTimeInterval=0;
    }
    

       
    return totalBreakTimeInterval;

  

    
}
-(NSString *)totalBreakTimeString{



    
     NSTimeInterval totalBreakTimeInterval=[self totalBreakTimeInterval];

    
    NSDate *timeFromReferenceTime=[referenceDate dateByAddingTimeInterval:totalBreakTimeInterval];
  
    return [NSString stringWithFormat:@"Total Break Time: %@",[counterDateFormatter stringFromDate:timeFromReferenceTime]];
    


}

- (void)tableViewModel:(SCTableViewModel *)tableViewModel didAddSectionAtIndex:(NSInteger)index
{
    
    SCTableViewSection *section = [tableViewModel sectionAtIndex:index];
    
    NSManagedObject *sectionManagedObject=(NSManagedObject *)section.boundObject;
    
    
    if(section.headerTitle !=nil)
    {
        
        if (!(tableViewModel.tag ==2 && index==0 &&[sectionManagedObject.entity.name isEqualToString:@"TimeEntity"] )) 
        {
            
            
            UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 60)];
            UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 300, 40)];
            headerLabel.tag=60;
            
            headerLabel.backgroundColor = [UIColor clearColor];
            headerLabel.textColor = [UIColor whiteColor];
            
            if (tableViewModel.tag ==2 && index==1) {
                headerLabel.text= [self  totalBreakTimeString];
               
                [self calculateTime];
            }
            else
            {
                headerLabel.text=section.headerTitle;
            
            }
            
            [containerView addSubview:headerLabel];
            
            section.headerView = containerView;
            
           
            
        }
        
    }
    if (tableViewModel.tag ==2 && index==1) 
        
    { 
        [section editingModeDidChange];
        
    }
    
    if((tableViewModel.tag==2 && index==0 &&[sectionManagedObject.entity.name isEqualToString:@"TimeEntity"])||(tableViewModel.tag==3 &&index==0 && [sectionManagedObject.entity.name isEqualToString:@"BreakTimeEntity"]))
    {
        
        
        
        UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        containerView.autoresizingMask=UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleRightMargin;
        
        UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        
        headerLabel.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        headerLabel.backgroundColor = [UIColor blackColor];
        headerLabel.alpha=0.5;
        headerLabel.textColor = [UIColor whiteColor];
        headerLabel.font=[UIFont fontWithName:@"Arial Rounded MT Bold" size:30];
        
        
        
        
        
        [containerView addSubview:headerLabel];
        headerLabel.textAlignment=UITextAlignmentCenter;
        section.headerView = containerView;
        
        
        switch (tableViewModel.tag) {
            case 2:
                totalTimeHeaderLabel=headerLabel;
                break;
                
            case 3:
                breakTimeTotalHeaderLabel=headerLabel;
                break;
                
                
            default:
                break;
        }
        
        
        //        section.footerView.autoresizingMask=;
        //        
        //       NSLog(@"section width is is %f",section.footerView.frame.size.width;
       
    }
    
    
}




- (void)tableViewModel:(SCTableViewModel *)tableViewModel 
       willDisplayCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    NSManagedObject *cellManagedObject = (NSManagedObject *)cell.boundObject;
    
    
    
    if (tableViewModel.tag==0) 
    {
        
        
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        //set the date format
        [dateFormatter setDateFormat:@"MMM d, yyyy"];
        //Set the date attributes in the  property definition and make it so the date picker appears 
        cell.textLabel.text= [dateFormatter stringFromDate:[cellManagedObject valueForKey:@"dateOfService"]];
        
    }
    
    
    if (tableViewModel.tag==1) 
    {
        
        
        if (cell.tag==1)
        {
           
            if ([cell isKindOfClass:[SCObjectCell class]]) 
            {
                
                totalTimeDate=(NSDate *)[cell.boundObject valueForKey:@"totalTime"];
                
                NSString *totalTimeString=[counterDateFormatter stringFromDate:totalTimeDate];
                UILabel *totalTimeLabel=(UILabel *)[cell viewWithTag:28];
                totalTimeLabel.text=totalTimeString;
                
                BOOL stopwatchIsRunning =(BOOL)[[cell.boundObject valueForKey:@"stopwatchRunning"]boolValue];
                
                if (stopwatchIsRunning)
                {
                    
                    totalTimeLabel.textColor=[UIColor redColor];
                    
                }
                else
                {
                    
                    totalTimeLabel.textColor=[UIColor colorWithRed:50.0f/255 green:69.0f/255 blue:133.0f/255 alpha:1.0];
                    
                }
            }
        }
        //        UIView *view=(UIView *)[timeCell viewWithTag:5];
        //        UILabel*lable =(UILabel*)view;
        //        lable.text=@"test";
        //        timeCell.label.text=(NSString *)[counterDateFormatter stringFromDate:totalTimeDate];
        
    }
    
    
    
    
    
    if (tableViewModel.tag==2) {
        
        
       
        
        if ([cellManagedObject.entity.name isEqualToString:@"TimeEntity"]) {
           
            if (cell.tag>=0 && cell.tag<4) {
                if ([cell isKindOfClass:[SCDateCell class]]){
                    SCDateCell *dateCell=(SCDateCell *)cell;
                    
                    switch (cell.tag) {
                        case 0:
                            startTime=[cellManagedObject valueForKey:@"startTime"];
                            break;
                        case 1:
                            endTime=[cellManagedObject valueForKey:@"endTime"];
                            break;
                        case 2:
                            additionalTime=dateCell.datePicker.date;
                            [dateCell.dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
                            break;
                            
                        case 3:
                            timeToSubtract=dateCell.datePicker.date;
                            [dateCell.dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
                            break;
                            
                            
                    }
                    
                }
            }
            
            
            if (cell.tag==5) 
            {
                
                if ([cell isKindOfClass:[StopwatchCell class]]) 
                {
                    
                    addStopwatch=(NSDate *)[cell.boundObject valueForKey:@"addStopwatch"];
                    
                    
                    
                    //set the date format
                    
                    //                n  
                    //                   
                    //                
                    stopwatchTextField.text=[stopwatchCell.stopwatchFormat stringFromDate:addStopwatch];
                    
                    
                    BOOL stopwatchIsRunningBool;
                    stopwatchIsRunningBool=(BOOL )[[cellManagedObject valueForKey:@"stopwatchRunning"] boolValue];
                    
                    
                    if (stopwatchIsRunningBool &&!viewControllerOpen) 
                    {
                        [stopwatchCell startButtonTapped:self];
                    }
                    if (!viewControllerOpen) {
                        [self calculateTime];
                    }
                    viewControllerOpen=YES;
                    
                }
            }
            
            
        }
        else
        {
            
                        
            if ([cellManagedObject.entity.name isEqualToString:@"BreakTimeEntity"]) 
            {
               
                
                
                UILabel *totalTimeLabel=(UILabel *)[cell viewWithTag:28];
                totalTimeLabel.text=[self tableViewModel:tableViewModel calculateBreakTimeForRowAtIndexPath:indexPath withBoundValues:YES];
                SCTableViewSection *section=[tableViewModel sectionAtIndex:1];
                
              NSString *totalBreakTimeString=(NSString *)[self totalBreakTimeString];
                UILabel *headerLabel=(UILabel *)[section.headerView viewWithTag:60];
                headerLabel.text=totalBreakTimeString;
                
            }
            
        }
    }
    if (tableViewModel.tag==3) 
    {
        
          
        
        NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
        if ([cellManagedObject.entity.name isEqualToString:@"BreakTimeEntity"]) {
            
           
//                    SCTableViewSection *section =(SCTableViewSection *)[tableViewModel sectionAtIndex:indexPath.section];
//                   
                    if (!tableViewModel.modeledTableView.editing) {
                         [tableViewModel didTapEditButtonItem];
                        [tableViewModel.modeledTableView setEditing:TRUE]; 
                       
                    }
                   
                                    
                              
                    
                  
            
            if(cell.tag>0 && cell.tag<4 && indexPath.section==0) 
            {
                breakTimeTotalHeaderLabel.text=[self tableViewModel:tableViewModel calculateBreakTimeForRowAtIndexPath:indexPath withBoundValues:YES];
                
            }
        }
        
    }
    
    
    
    
}

-(void)tableViewModelDidEndEditing:(SCTableViewModel *)tableViewModel{


NSLog(@"did end editing");

  
    
}

-(void)tableViewModel:(SCTableViewModel *)tableViewModel valueChangedForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
   
    
    
//    if (tableViewModel.tag==1) 
//    {
//        SCSelectionCell *timeCell=(SCSelectionCell *)[tableViewModel.modeledTableView cellForRowAtIndexPath:indexPath];
//        
//        if (timeCell.tag==1)
//        {
//            
//            
//            
//            
//            
//            
//            NSLog(@"cell is kind of class %@",[timeCell class]);
//            if ([timeCell isKindOfClass:[SCObjectCell class]]) 
//            {
//                
//                [timeCell.boundObject setValue:totalTimeDate forKey:@"totalTime"];
//                [self tableViewModel:(SCTableViewModel *)tableViewModel 
//                     willDisplayCell:(SCTableViewCell *)timeCell forRowAtIndexPath:(NSIndexPath *)indexPath];
//                
//                
//                
//                
//            }
//        }
//        //        UIView *view=(UIView *)[timeCell viewWithTag:5];
//        //        UILabel*lable =(UILabel*)view;
//        //        lable.text=@"test";
//        //        timeCell.label.text=(NSString *)[counterDateFormatter stringFromDate:totalTimeDate];
//        
//    }
    
    
    
    if (tableViewModel.tag==2) {
        
        SCTableViewCell *cell=(SCTableViewCell *)[tableViewModel cellAtIndexPath:indexPath];
        NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
       
        
        if ([cellManagedObject.entity.name isEqualToString:@"TimeEntity"]) {
            
            
            switch (cell.tag) {
                case 0:
                {
                    
                    SCDateCell *startTimeCell =(SCDateCell *)cell;
                    
                   
                    startTime=(NSDate*)startTimeCell.datePicker.date;
                    
                    
                }
                    break;
                case 1:
                {
                    SCDateCell *endTimeCell =(SCDateCell *)cell;
                    
                    endTime=(NSDate*)endTimeCell.datePicker.date;
                    
                }
                    break;
                case 2:
                {
                    TimePickerCell *additionalTimeCell =(TimePickerCell *)cell;
                    
    
                    additionalTime=(NSDate*)additionalTimeCell.timeValue;
                    
                }
                    break;
                    
                case 3:
                {
                    TimePickerCell *timeToSubtractCell =(TimePickerCell *)cell;
                    
                    timeToSubtract=(NSDate*)timeToSubtractCell.timeValue;
                    
                }
                    break;
                    
                    
                default:
                    break;
            }
            
            [self calculateTime];
        }
        
    } 
    
    
    if (tableViewModel.tag==3) {
        
        SCTableViewCell *cell=(SCTableViewCell *)[tableViewModel cellAtIndexPath:indexPath];
        NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
       
        
        if ([cellManagedObject.entity.name isEqualToString:@"BreakTimeEntity"]) {
         
            
       
            if (cell.tag==1||cell.tag==2||cell.tag==3)
                breakTimeTotalHeaderLabel.text=[self tableViewModel:tableViewModel calculateBreakTimeForRowAtIndexPath:indexPath withBoundValues:NO];
        }
        
    } 
    
    
    
    
    
}
-(NSString *)tableViewModel:(SCTableViewModel *)tableViewModel calculateBreakTimeForRowAtIndexPath:(NSIndexPath *)indexPath withBoundValues:(BOOL)useBoundValues{
    
    SCTableViewSection *section=[tableViewModel sectionAtIndex:indexPath.section];
    NSManagedObject *sectionBoundObject=(NSManagedObject *)section.boundObject;
    NSDate *breakStartTime;
    NSDate *breakEndTime;
    
    
    NSDate *breakUndefinedTime;
    
       
    if (tableViewModel.tag==3 && section.cellCount>=4 && [sectionBoundObject.entity.name isEqualToString:@"BreakTimeEntity"]) {
        
        
        
        SCDateCell *breakStartTimeCell =(SCDateCell *)[section cellAtIndex:1];
        SCDateCell *breakEndTimeCell =(SCDateCell *)[section cellAtIndex:2];
        TimePickerCell *breakUndefinedTimeCell =(TimePickerCell *)[section cellAtIndex:3];
        
        if (useBoundValues) {
            breakStartTime=[breakStartTimeCell.boundObject valueForKey:@"startTime"];
            breakEndTime=[breakEndTimeCell.boundObject valueForKey:@"endTime"];
            
            breakUndefinedTime=[breakUndefinedTimeCell.boundObject valueForKey:@"undefinedTime"];
        }
        else
        {
            if (breakStartTimeCell.label.text.length>0 && breakEndTimeCell.label.text.length>0) {
                breakStartTime=breakStartTimeCell.datePicker.date;
                breakEndTime=breakEndTimeCell.datePicker.date;
            }
            else
            {
                breakStartTime=referenceDate;
                breakEndTime=referenceDate;
            }
            
            if (breakUndefinedTimeCell.timeValue) {
                breakUndefinedTime=breakUndefinedTimeCell.timeValue;
            }
            else{breakUndefinedTime=referenceDate;}
           
        }
    }
   
    
    if (tableViewModel.tag==2 ){//&& [sectionBoundObject.entity.name isEqualToString:@"BreakTimeEntity"]) {
        
               
        if (indexPath.section==1) {
            
            
            SCObjectCell *breakObjectCell=(SCObjectCell *)[section cellAtIndex:indexPath.row];
            
            breakStartTime=(NSDate *)[breakObjectCell.boundObject valueForKey:@"startTime"];
            breakEndTime=(NSDate *)[breakObjectCell.boundObject valueForKey:@"endTime"];
            
            breakUndefinedTime=(NSDate *)[breakObjectCell.boundObject valueForKey:@"undefinedTime"];
        }
    }
    
    if (breakStartTime && breakStartTime != referenceDate &&breakEndTime &&breakEndTime!=referenceDate) {
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc ]init];
        [dateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
        [dateFormatter setDateFormat:@"H:mm"];
        NSDateFormatter *dateFormatClearSeconds=[[NSDateFormatter alloc]init];
        [dateFormatClearSeconds setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        [dateFormatClearSeconds setDateFormat:@"H:mm"];
                
        breakStartTime=[dateFormatClearSeconds dateFromString:[dateFormatter stringFromDate:breakStartTime]];
        breakEndTime=[dateFormatClearSeconds dateFromString:[dateFormatter stringFromDate:breakEndTime]];
        
    }
    NSTimeInterval startAndEndTimeInterval=0.0;
 
    if ([breakEndTime timeIntervalSinceDate:breakStartTime]>0.0)
    {
        
        startAndEndTimeInterval=[breakEndTime timeIntervalSinceDate:breakStartTime];
    }
    
    if ([breakUndefinedTime timeIntervalSinceDate:referenceDate]>0.0) 
    {
        startAndEndTimeInterval=startAndEndTimeInterval+[breakUndefinedTime timeIntervalSinceDate:referenceDate];
    }
   
    NSString *totalTimeString;
    if (startAndEndTimeInterval>=1) {
        
        //cut off miliseconds
        
        totalTimeString=[NSString stringWithFormat:@"%f",startAndEndTimeInterval];
        
        
        NSRange range;
        range.length=6;
        range.location=totalTimeString.length-6;
        totalTimeString=[totalTimeString stringByReplacingCharactersInRange:range withString:@"000000"];
        
        
        startAndEndTimeInterval=[totalTimeString doubleValue];
    }
    else
    {
        
        startAndEndTimeInterval=0;
    }
    
    
    NSDate *timeFromReferenceTime=[referenceDate dateByAddingTimeInterval:startAndEndTimeInterval];
    if (tableViewModel.tag==2) {
        return [NSString stringWithFormat:@"%@",[counterDateFormatter stringFromDate:timeFromReferenceTime]];
    }
    
    
    return [NSString stringWithFormat:@"Time:%@",[counterDateFormatter stringFromDate:timeFromReferenceTime]];
    
}

-(void)tableViewModel:(SCTableViewModel *)tableViewModel valueChangedForSectionAtIndex:(NSUInteger)index{
    
    
    if(tableModel.tag==2 &&index==1)
        [self calculateTime];

    
}
-(void)tableViewModel:(SCTableViewModel *)tableViewModel didRemoveRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if(tableModel.tag==2 &&indexPath.section==1)
    {
        [self calculateTime];
        SCTableViewSection *section=(SCTableViewSection *)[tableModel sectionAtIndex:1];
        UILabel *breakSectionHeaderLabel=(UILabel *)[section.headerView viewWithTag:60];
        
        
        breakSectionHeaderLabel.text=[self totalBreakTimeString];
    }
    
    
}

@end
