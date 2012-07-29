/*
 *  FrequencyPicker.m
 *  psyTrack Clinician Tools
 *  Version: 1.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. 
 *
 *  Created by Daniel Boice on 12/2/12.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import "FrequencyPickerCell.h"

@interface FrequencyPickerCell (PRIVATE)

- (NSString *)unitForRow:(NSInteger)row;

- (NSInteger)rowForUnit:(NSString *)unit;
- (NSString *)timesForRow:(NSInteger )row;


@end



@implementation FrequencyPickerCell
@synthesize picker;
@synthesize view, pickerField;

// overrides superclass
- (void)performInitialization
{
    [super performInitialization];
    
    // place any initialization code here
    
    // Center the picker in the detailViewController
	CGRect pickerFrame = self.picker.frame;
	pickerFrame.origin.x = (self.view.frame.size.width - pickerFrame.size.width)/2;
	
    
    self.picker.frame = pickerFrame;
    
    if([SCUtilities is_iPad])
		self.view.backgroundColor = [UIColor colorWithRed:32.0f/255 green:35.0f/255 blue:42.0f/255 alpha:1];
	else
		self.view.backgroundColor = [UIColor colorWithRed:41.0f/255 green:42.0f/255 blue:57.0f/255 alpha:1];
    
    UIColor *blueTextColor=[UIColor colorWithRed:50.0f/255 green:79.0f/255 blue:133.0f/255 alpha:1];
    self.label.textColor=blueTextColor;
  
    
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    
    self.picker.dataSource = self;
    self.picker.delegate = self;
    self.picker.showsSelectionIndicator = YES;
    
    self.pickerField = [[UITextField alloc] init];
	self.pickerField.delegate = self;
	self.pickerField.inputView = self.view;
	[self.contentView addSubview:pickerField];
  
    //    
}


//overrides superclass
- (BOOL)becomeFirstResponder
{
    return [pickerField becomeFirstResponder];
}

//overrides superclass
- (BOOL)resignFirstResponder
{
	return [pickerField resignFirstResponder];
}

// overrides superclass
- (void)loadBindingsIntoCustomControls
{
    [super loadBindingsIntoCustomControls];
    
    //    float heightTall=[(NSNumber *)[self.boundObject valueForKey:@"heightTall"]decimalValue];
    NSString *unit=(NSString *)[self.boundObject valueForKey:@"contactFrequencyUnit"];
    
    
    if (!unit) {
        unit=@"";
    }
    
    
    NSInteger numberOfTimes =(NSInteger )[[self.boundObject valueForKey:@"contactFrequencyNumber"] integerValue]; 
    NSInteger lengthOfUnit=(NSInteger )[[self.boundObject valueForKey:@"contactFrequencyUnitLength"]integerValue];
    
    int hundredsTimes;
    if (numberOfTimes>99) {
      hundredsTimes=numberOfTimes/100;
        
    }
    else
    {
        hundredsTimes=0;
    }
    
    self.label.text = [NSString stringWithFormat:@"%i x in %i %@", numberOfTimes,lengthOfUnit, unit] ;
    numberOfTimes=numberOfTimes-(hundredsTimes*100);
    //    NSString *title = @"";
    
    //NSLog(@"hundreds %i tens %i",hundredsTimes,numberOfTimes);
    //NSLog(@"contact frequency unit is %@",unit);
    [picker selectRow:hundredsTimes inComponent:0 animated:YES];
    [picker selectRow:numberOfTimes inComponent:1 animated:YES];
    [picker selectRow:lengthOfUnit inComponent:3 animated:YES];
    [picker selectRow:[self rowForUnit:unit] inComponent:4 animated:YES];
    
    
    
    
    
    
}
// overrides superclass
- (void)commitChanges
{
    if(!needsCommit)
		return;
	
	[super commitChanges];
    // 
    
    NSInteger firstComponent=[picker selectedRowInComponent:0];
    NSInteger secondComponent=[picker selectedRowInComponent:1];
    NSInteger fourthComponent=[picker selectedRowInComponent:3];
    NSString *unit = [self unitForRow:[picker selectedRowInComponent:4]];
    
       
    //    float heightTall=[[NSString stringWithFormat:@"%f", inchesTall]floatValue]; 
    
    NSInteger totalNumber=(firstComponent*100)+secondComponent;
    
    [self.boundObject setValue:[NSNumber numberWithInteger:totalNumber] forKey:@"contactFrequencyNumber"];
    [self.boundObject setValue:unit forKey:@"contactFrequencyUnit"];
    [self.boundObject setValue:[NSNumber numberWithInteger:fourthComponent] forKey:@"contactFrequencyUnitLength"];
    needsCommit = FALSE;
}

//override superclass
- (void)cellValueChanged
{	
    int firstComponent=[picker selectedRowInComponent:0];
    int secondComponent=[picker selectedRowInComponent:1];
    int fourthComponent=[picker selectedRowInComponent:3];
    NSString *unit=[self unitForRow:[picker selectedRowInComponent:4]];
   
    NSString *numberOfTimesString;
    if (firstComponent>0) {
        numberOfTimesString=[NSString stringWithFormat:@"%i%i",firstComponent,secondComponent];
    }
    else
    {
        numberOfTimesString=[NSString stringWithFormat:@"%i",secondComponent];
    }
	self.label.text = [NSString stringWithFormat:@"%@ x in %i %@",numberOfTimesString,fourthComponent, unit] ;
	
	[super cellValueChanged];
}

//override superclass
- (void)willDisplay
{
    [super willDisplay];
    
    self.textLabel.text = @"Contact Frequency";
}

//override superclass
- (void)didSelectCell
{
    self.ownerTableViewModel.activeCell = self;
    
    [pickerField becomeFirstResponder];
}

- (NSString *)unitForRow:(NSInteger)row
{
    NSString *unit = nil;
    switch (row) 
    {
        case 0: unit = @"";    break;
        case 1: unit = @"second";    break;
        case 2: unit = @"minute";    break;
        case 3: unit = @"hour";      break;
        case 4: unit = @"day";       break;
        case 5: unit = @"week";      break;
        case 6: unit = @"month";     break;
        case 7: unit = @"year";      break;
        case 8: unit = @"decade";    break;
        case 9: unit = @"century";   break;
        case 10: unit = @"morning";    break;
        case 11: unit = @"noon";    break;
        case 12: unit = @"evening";    break;
        case 13: unit = @"night";    break;
            
            
    }
    
    int fourthComponent=[picker selectedRowInComponent:3];
    int thirdComponent =[picker selectedRowInComponent:2];
    
    if (thirdComponent==0) {
        if (row!=0&&row!=4 && row>2 && row<8) {
            unit=[unit stringByAppendingString:@"ly"];
        } else if ((row >0 && row<3)||(row>7&&row<10))
        
        {
            unit=[NSString stringWithFormat:@"a %@",unit];
        }
        else if (row==4)
        {
            unit=@"daily";
        }
    }
   else if (fourthComponent!=1) {
        if (row>0 && row<9) {
            unit=[unit stringByAppendingString:@"s"];
        }
        else if (row==9)
        {
            unit=@"centuries";
        }
       
    }

    return unit;
}

- (NSInteger)rowForUnit:(NSString *)unit
{
    NSInteger row = 0;
    
    for(NSInteger i=0; i<5; i++)
    {
        if([unit isEqualToString:[self unitForRow:i]])
        {
            row = i;
            break;
        }
    }
    
    return row;
}

- (NSString *)timesForRow:(NSInteger )row
{
    
    NSString *returnStr;
    
    
    switch (row) {
        case 0:
            returnStr = @"Xs";
            break;
        case 1:
            returnStr = @"X in";
            break;    
        
        case 2:
            returnStr = @"for";
            break; 
        
        default:
            break;
    }
        
  

    return returnStr;
}
#pragma mark -
#pragma mark UIPickerViewDataSource methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 5;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger returnInteger=0;
    
    if (component==0) {
        returnInteger= 100;
    }
    if (component==1) {
        returnInteger= 100;
    }    
    if (component==2) {
        returnInteger= 3;
    }
    if (component==3) {
       
        if ([picker selectedRowInComponent:2]==0) {
            returnInteger= 1;
        }
        else
        {
            returnInteger= 100;
        }
    } 
    
    if (component==4) {
        returnInteger= 13;
    }
    return returnInteger;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    
    float returnFloat=0;
    
    if (component==0) {
        returnFloat= 40.0;
    }
    if (component==1) {
        returnFloat= 40.0;
    }    
    if (component==2) {
        returnFloat= 70.0;
    }
    if (component==3) {
        returnFloat= 40.0;
    }    

    if (component==4) {
        returnFloat= 112.0;
    }
    return returnFloat;
    
    
    
    
}

#pragma mark -
#pragma mark UIPickerViewDelegate methods

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *returnStr = @"";
	
	// note: custom picker doesn't care about titles, it uses custom views
	
    
    
	
    if (component==0) {
        if (row<10) {
            return [NSString stringWithFormat:@"  %i", row];
        }
        else{
            
            return [[NSNumber numberWithInt:row] stringValue];
        }
    }
    
    if (component==1) {
        if (row<10) {
            return [NSString stringWithFormat:@"0%i", row];
        }
        else{
        
        return [[NSNumber numberWithInt:row] stringValue];
        }
    }
    if (component==2) {
        switch (row) {
            case 0:
                returnStr = @"Xs";
                break;
            case 1:
                returnStr = @"X in";
                break;    
                
            case 2:
                returnStr = @"every";
                break; 
                
            default:
                break;
        }
            
            if ([picker selectedRowInComponent:3]>0) {
                [picker selectRow:0 inComponent:3 animated:YES];
            }
        
        
        
        
    }
    
    if (component==3&&row!=0) {
        
        returnStr = [[NSNumber numberWithInteger:row]stringValue];
    }
    else if (component==3&&row==0) {
    
        returnStr=@"";
    
    }
    
    if (component==4) {
       
         returnStr=[self unitForRow:row];
         
               
    }
    
	
	return returnStr;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //NSLog(@"component changed is %i",component);
    
 
               
        [self cellValueChanged];
        if (component==2||component==3) {
            [picker reloadComponent:4];
            [picker reloadComponent:3];
        }
        
        
 
    
   
    
}
@end
