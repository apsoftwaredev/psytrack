/*
 *  HeightPickerCell.m
 *  psyTrack Clinician Tools
 *  Version: 1.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. 
 *
 *  Created by Daniel Boice on 11/9/12.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */
#import "HeightPickerCell.h"
#import "Math.h"
@interface HeightPickerCell (PRIVATE)

- (NSString *)bigUnitForRow:(NSInteger)row;
- (NSString *)littleUnitForRow:(NSInteger)row;
- (NSInteger)rowForBigUnit:(NSString *)unit;
- (NSInteger)rowForLittleUnit:(NSString *)unit;

@end



@implementation HeightPickerCell
@synthesize picker, pickerField;
@synthesize view;
// overrides superclass
- (void)performInitialization
{
    [super performInitialization];
    
    // place any initialization code here
   
    CGRect pickerFrame = self.picker.frame;
     
	pickerFrame.origin.x = (self.view.frame.size.width - pickerFrame.size.width)/2;
	

    self.picker.frame = pickerFrame;
  
    if([SCUtilities is_iPad])
		self.view.backgroundColor = [UIColor colorWithRed:32.0f/255 green:35.0f/255 blue:42.0f/255 alpha:1];
	else
		self.view.backgroundColor = [UIColor colorWithRed:41.0f/255 green:42.0f/255 blue:57.0f/255 alpha:1];
    

    
    picker.dataSource = self;
    picker.delegate = self;
    picker.showsSelectionIndicator = YES;
    
    self.pickerField = [[UITextField alloc] init];
	pickerField.delegate = self;
	pickerField.inputView = picker;
	[self.contentView addSubview:pickerField];
    
    
    //    UILabel *hourLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 37)];
    //    hourLabel.text=@"experiment";
    //    
    
//    [picker reloadInputViews];
     loadUnitsFromBoundObject=TRUE;
    //    
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
- (void)loadBoundValueIntoControl
{
    [super loadBoundValueIntoControl];
    
//    float heightTall=[(NSNumber *)[self.boundObject valueForKey:@"heightTall"]decimalValue];
    NSString *bigUnit=(NSString *)[self.boundObject valueForKey:@"heightUnit"];
   
    
    
   
   
    NSInteger heightTallInchesOrCentemeters =(NSInteger )[[self.boundObject valueForKey:@"heightTall"] integerValue]; 
    float meters, centimeters,feet,inches;
    NSInteger heightTallFtOrM=0;
    NSString *littleUnit;
    componentChanged=3;
    if ([bigUnit isEqualToString:@"ft"]) {
        if (heightTallInchesOrCentemeters>12) {
            feet=(heightTallInchesOrCentemeters/12);
            inches=fmodf([[NSNumber numberWithInteger:heightTallInchesOrCentemeters ] floatValue], 12.0);
        }
        else{
            feet=0;
            inches=[[NSNumber numberWithInteger:heightTallInchesOrCentemeters]floatValue];
        }
        heightTallInchesOrCentemeters=[[NSNumber numberWithFloat:roundf(inches)]integerValue];
        heightTallFtOrM=[[NSNumber numberWithFloat:roundf(feet)]integerValue];
        littleUnit=@"in";
        
        
    }
    else if ([bigUnit isEqualToString:@"m"]){
        
       
        
        if (heightTallInchesOrCentemeters>=100) {
             meters=(heightTallInchesOrCentemeters/100);
            centimeters=fmodf([[NSNumber numberWithInteger:heightTallInchesOrCentemeters ] floatValue], 100.0);
        }
        else{
            meters=0;
            centimeters=[[NSNumber numberWithInteger:heightTallInchesOrCentemeters]floatValue];
        }
        heightTallInchesOrCentemeters=[[NSNumber numberWithFloat:roundf(centimeters)]integerValue];
        heightTallFtOrM=[[NSNumber numberWithFloat:roundf(meters)]integerValue];
        
        if (heightTallFtOrM>=3 &&heightTallInchesOrCentemeters>=64) {
           
            heightTallFtOrM=3;
            heightTallInchesOrCentemeters=63;
            componentChanged=4;
        }
        littleUnit=@"cm"; 
    
    }

    

    
    //    NSString *title = @"";
    [picker selectRow:heightTallFtOrM inComponent:0 animated:YES];
    [picker selectRow:[self rowForBigUnit:bigUnit] inComponent:1 animated:YES];
    [picker selectRow:heightTallInchesOrCentemeters inComponent:2 animated:YES];
    [picker selectRow:[self rowForLittleUnit:littleUnit] inComponent:3 animated:NO];
   
    self.label.text = [NSString stringWithFormat:@"%i %@ %i %@",heightTallFtOrM,bigUnit,heightTallInchesOrCentemeters,littleUnit] ;
    
    
   
    
}
// overrides superclass
- (void)commitChanges
{
    if(!needsCommit)
		return;
	
	[super commitChanges];
    // 
    
    NSInteger firstComponent=[picker selectedRowInComponent:0];
   
    NSInteger thirdComponent=[picker selectedRowInComponent:2];
    NSString *bigUnit = [self bigUnitForRow:[picker selectedRowInComponent:1]];
  
    NSInteger heightTall=0;  //going to be centemeters or inches
    if ([bigUnit isEqualToString:@"ft"]) {
        heightTall=(firstComponent*12)+thirdComponent;
    }
    else if ([bigUnit isEqualToString:@"m"]){
    
        heightTall=(firstComponent*100)+thirdComponent;
    }
    
    
//    float heightTall=[[NSString stringWithFormat:@"%f", inchesTall]floatValue]; 
    
 
    

    [self.boundObject setValue:[NSNumber numberWithInteger:heightTall] forKey:@"heightTall"];
    [self.boundObject setValue:bigUnit forKey:@"heightUnit"];
    
    needsCommit = FALSE;
}

//override superclass
- (void)cellValueChanged
{
    [super cellValueChanged];
    int firstComponent=[picker selectedRowInComponent:0];
    NSString *bigUnit=[self bigUnitForRow:[picker selectedRowInComponent:1]];
    int thirdComponent=[picker selectedRowInComponent:2];
    NSString *littleUnit = [self littleUnitForRow:[picker selectedRowInComponent:3]];
   
    
	self.label.text = [NSString stringWithFormat:@"%i %@ %i %@",firstComponent,bigUnit,thirdComponent,littleUnit] ;
	
	
}

//override superclass
- (void)willDisplay
{
    [super willDisplay];
    
    self.textLabel.text = @"Height";
}

//override superclass
- (void)didSelectCell
{
    self.ownerTableViewModel.activeCell = self;
    
    [pickerField becomeFirstResponder];
}

- (NSString *)bigUnitForRow:(NSInteger)row
{
    NSString *title = nil;
    switch (row) 
    {
        case 0: title = @"ft";        break;
        case 1: title = @"m";     break;
        
            
    }
    return title;
}
- (NSString *)littleUnitForRow:(NSInteger)row
{
    NSString *title = nil;
    switch (row) 
    {
        case 0: title = @"in";        break;
        case 1: title = @"cm";     break;
            
            
    }
    return title;
}

- (NSInteger)rowForBigUnit:(NSString *)title
{
    
    
    NSInteger row = 0;
    
    for(NSInteger i=0; i<5; i++)
    {
        if([title isEqualToString:[self bigUnitForRow:i]])
        {
            row = i;
            break;
        }
    }
    
    return row;
}
- (NSInteger)rowForLittleUnit:(NSString *)title
{
    
    
    NSInteger row = 0;
    
    for(NSInteger i=0; i<5; i++)
    {
        if([title isEqualToString:[self littleUnitForRow:i]])
        {
            row = i;
            break;
        }
    }
    
    return row;
}



#pragma mark -
#pragma mark UIPickerViewDataSource methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 4;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger returnInteger=0;
   


NSString *bigUnit,*littleUnit ;
if (loadUnitsFromBoundObject) {
    bigUnit=(NSString *)[self.boundObject valueForKey:@"heightUnit"];
    if ([bigUnit isEqualToString:@"ft"]) {
        littleUnit=@"in";
    }
    else if([bigUnit isEqualToString:@"m"] ){
        
        littleUnit=@"cm";
    }
    
}

else
{
    
    bigUnit=[self bigUnitForRow:[picker selectedRowInComponent:1]];
    littleUnit=[self littleUnitForRow:[picker selectedRowInComponent:3]];
    
}
    if (component==0) {
        
        
        if (componentChanged==3) {
            if ([littleUnit isEqualToString:@"in"]) {
                returnInteger=12;
            }
            else if([littleUnit isEqualToString:@"cm"] ){
                returnInteger=4;
            }
            
        }else if ([bigUnit isEqualToString:@"ft"]) {
            returnInteger=12;
        }
        else if([bigUnit isEqualToString:@"m"] ){
            returnInteger=4;
        }

    }
    
    if (component==1||component==3) {
        returnInteger=2;
    }
    
    if (component==2) {
    
        
        if (componentChanged==3) 
        {
            if ([littleUnit isEqualToString:@"in"]) 
            {
                returnInteger=12;
            }
            else if([littleUnit isEqualToString:@"cm"] )
            {
                returnInteger=100;
            }

            else if ([bigUnit isEqualToString:@"ft"]) 
            {
                returnInteger=12;
            }
            else if([bigUnit isEqualToString:@"m"] )
            {
            returnInteger=100;
            }
            
        }
        else if (componentChanged==4)
        {
            returnInteger=64;
       
        
    }else if ([bigUnit isEqualToString:@"ft"]) {
        returnInteger=12;
    }
    else if([bigUnit isEqualToString:@"m"] ){
        returnInteger=100;
    }
        
    }

    return returnInteger;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    
  
        return 60.0;
    
    
    
    
}

#pragma mark -
#pragma mark UIPickerViewDelegate methods

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *returnStr = @"";
	
	// note: custom picker doesn't care about titles, it uses custom views
	
    
    
	
    if (component==0||component==2) {
        returnStr = [[NSNumber numberWithInt:row] stringValue];
    }
    if (component==1) {
        returnStr = [self bigUnitForRow:row];
    }
    if (component==3) {
        returnStr=[self littleUnitForRow:row];
    }
    
	
	return returnStr;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    
    if (component==0) {
         NSString *bigUnit = [self bigUnitForRow:[picker selectedRowInComponent:1]];
        if ([bigUnit isEqualToString:@"m"]) {
            
             NSInteger firstComponent=[picker selectedRowInComponent:0];
            if (firstComponent==3) {
                componentChanged=4;
            }
            else
            {
                    componentChanged=3;
                }
               
                [picker reloadComponent:2];
                
                
            }
        }
        
        if (component==1||component==3) {
            NSInteger firstComponent=[picker selectedRowInComponent:0];
            NSInteger thirdComponent=[picker selectedRowInComponent:2];
            NSString *bigUnit = [self bigUnitForRow:[picker selectedRowInComponent:1]];
            NSString *littleUnit = [self littleUnitForRow:[picker selectedRowInComponent:3]];
            loadUnitsFromBoundObject=FALSE;
            componentChanged=component; 
            [picker reloadComponent:2];
            [picker reloadComponent:0];
            NSInteger heighTallFtOrM=firstComponent;
            
            NSInteger heighTallInOrCm=thirdComponent;
            BOOL convertToMetric=FALSE;
            
            
            if (component==1) {
               
                if ([bigUnit isEqualToString:@"ft"]) {
                    convertToMetric=FALSE;      
                    littleUnit=@"in";
                     
                                
               }
                
                if ([bigUnit isEqualToString:@"m"]) {
                    
                    convertToMetric=TRUE;
                    littleUnit=@"cm";
                    
                               
            }
            
            
        [picker selectRow:[self rowForLittleUnit:littleUnit] inComponent:3 animated:YES];
                
                
         
            
        } else if(component==3)
        
        {
        
            if ([littleUnit isEqualToString:@"in"]) {
    //                float inches;
                    convertToMetric=FALSE;                
                   bigUnit=@"ft";
                    
                    
                }
                
                if ([littleUnit isEqualToString:@"cm"]) {
                    
                    convertToMetric=TRUE;
                    bigUnit=@"m";
                 
               
                }
                
       
            
            
            
        [picker selectRow:[self rowForBigUnit:bigUnit] inComponent:1 animated:YES];
           
        
        }
        
        if (convertToMetric) {
            NSInteger inchesInteger=0;     
            inchesInteger=thirdComponent+(firstComponent *12);
            
            heighTallInOrCm=[self convertToCentemetersComponentFromInches:inchesInteger];
            heighTallFtOrM =[self  convertToMetersComponentFromInches:inchesInteger];
            if (heighTallFtOrM>=3 &&heighTallInOrCm>63) {
                heighTallFtOrM=3;
                heighTallInOrCm=63;
            }
            
            if (heighTallFtOrM==3) {
                componentChanged=4; 
                [picker reloadComponent:2];
            }

            
        }
        else if (convertToMetric==FALSE){
            float inchesFloat=0,feetFloat;
            NSInteger inchesInteger,feetInteger,centemetersInteger;
            centemetersInteger=thirdComponent+(firstComponent *100);
            
            inchesFloat=centemetersInteger*0.393700787;
            
           
            feetFloat=inchesFloat/12;
            feetInteger=feetFloat;
            inchesFloat=feetFloat-feetInteger;
            inchesFloat=inchesFloat*12;
            
            
            inchesFloat=roundf(inchesFloat);
            
            
            inchesInteger=inchesFloat;
           
            heighTallInOrCm=inchesInteger;
            
   
            
            heighTallFtOrM=feetInteger;
            
            
            
            
            
            
            
         
        
        
        
        }
        
        
      
        [picker selectRow:heighTallFtOrM inComponent:0 animated:YES];
        [picker selectRow:heighTallInOrCm inComponent:2 animated:YES];
        
//        self.label.text = [NSString stringWithFormat:@"%i%@ %i%@",heighTallFtOrM,bigUnit,heighTallInOrCm,littleUnit] ;
        
        
    }
        
        [self cellValueChanged];
   
}

-(NSInteger) convertToMetersComponentFromInches:(NSInteger )inchesInteger{
   
//    
    NSInteger metersInteger;
    float  metersFloat;
    

    
    metersInteger=inchesInteger *0.0254;
//    metersInteger=metersFloat;
    
    
    
     metersFloat=inchesInteger *0.0254;
    
    
    if (metersFloat-metersInteger>0.995) {
        metersInteger++;
    }
    
    
   

    return metersInteger;


}
-(NSInteger )convertToCentemetersComponentFromInches:(NSInteger )inchesInteger{

    
    float metersFloat, centemetersFloat;
  
    centemetersFloat=inchesInteger * 2.54;
    NSInteger metersInteger, centemetersInteger;
    
    
    
    metersFloat=centemetersFloat/100.0;
    
    
    metersInteger=metersFloat;
    
    
    
    
    centemetersFloat=(metersFloat-metersInteger)*100;
    centemetersInteger=centemetersFloat;
    
    if (centemetersFloat-centemetersInteger>0.5) {
        centemetersInteger++;
    }
    
    
    
    
//    
//    heighTallFtOrM=metersInteger;
//    
//    centemetersComponent=centemetersInteger;
//    
    
    
    
    return centemetersInteger;


}

@end
