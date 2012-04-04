/*
 *  BehaviorPickerCell.m
 *  psyTrack Clinician Tools
 *  Version: 1.0
 *
 *
 *	THIS SOURCE CODE AND ANY ACCOMPANYING DOCUMENTATION ARE PROTECTED BY UNITED STATES 
 *	INTELLECTUAL PROPERTY LAW AND INTERNATIONAL TREATIES. UNAUTHORIZED REPRODUCTION OR 
 *	DISTRIBUTION IS SUBJECT TO CIVIL AND CRIMINAL PENALTIES. 
 *
 *  Created by Daniel Boice on 10/23/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */

#import "BehaviorPickerCell.h"
#import "CustomView.h"


@interface BehaviorPickerCell (PRIVATE)

- (NSString *)titleForRow:(NSInteger)row;
- (NSInteger)rowForTitle:(NSString *)title;

@end



@implementation BehaviorPickerCell
@synthesize myPickerView;
@synthesize titleString;


// overrides superclass
- (void)performInitialization
{
    [super performInitialization];
    
    // place any initialization code here
    pickerDataSource = [[BOPickersDataSource alloc] init];
    
    
    myPickerView = [[MyPickerView alloc] initWithNibName:@"MyPickerView" bundle:nil];
    myPickerView.picker.dataSource = pickerDataSource;
    myPickerView.picker.delegate = self;
    myPickerView.picker.showsSelectionIndicator = YES;
    
    
    
    pickerField = [[UITextField alloc] initWithFrame:CGRectZero];
	pickerField.delegate = self;
	pickerField.inputView = myPickerView.view;
    pickerField.tag=2;
	[self.contentView addSubview:pickerField];
    

    
}
-(void)setupPickerAndDatasource{


   
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
    
   
    bOPropertyName=(NSString *)[self.objectBindings valueForKey:@"2"];
    [pickerDataSource stringArrayForPropertyName:bOPropertyName];
    [myPickerView reloadInputViews];
    
    NSString *title = (NSString *)[self.boundObject valueForKey:(NSString *)bOPropertyName];
    [myPickerView.picker selectRow:[self rowForTitle:title] inComponent:0 animated:NO];
    self.label.text = title;
    
}


// overrides superclass
- (void)commitChanges
{
    if(!needsCommit)
		return;
	
	[super commitChanges];
    
    NSString *title = [self titleForRow:[myPickerView.picker selectedRowInComponent:0]];
    [self.boundObject setValue:title forKey:bOPropertyName];
    
    needsCommit = FALSE;
}

//override superclass
- (void)cellValueChanged
{	
   
	self.label.text = [self titleForRow:[myPickerView.picker selectedRowInComponent:0]];
	
	[super cellValueChanged];
}

//override superclass
- (void)willDisplay
{
    [super willDisplay];
    
    self.textLabel.text = (NSString *)[self.objectBindings valueForKey:@"3"];
}

//override superclass
- (void)didSelectCell
{
    self.ownerTableViewModel.activeCell = self;
    
    [pickerField becomeFirstResponder];
}

- (NSString *)titleForRow:(NSInteger)row
{
    NSString *title = nil;
    title =(NSString *)[pickerDataSource.customPickerArray objectAtIndex:row]; 
          
    return title;
}


- (NSInteger)rowForTitle:(NSString *)title
{
    NSInteger row = 0;
    
    for(NSInteger i=0; i<pickerDataSource.customPickerArray.count; i++)
    {
        if([title isEqualToString:((NSString *)[pickerDataSource.customPickerArray objectAtIndex:i])])
        {
            row = i;
            break;
        }
    }
    
    return row;
}

//#pragma mark -
//#pragma mark UIPickerViewDelegate methods
//
//// tell the picker which view to use for a given component and row, we have an array of views to show
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row
//		  forComponent:(NSInteger)component reusingView:(UIView *)view
//{
//	return [pickerDataSource.customPickerArray objectAtIndex:row];
//}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [self cellValueChanged];
}



#pragma mark -
#pragma mark UIPickerViewDelegate methods

//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    return [self titleForRow:row];
//}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 37)];
    label.text = [NSString stringWithFormat:[self titleForRow:row]];
    label.textAlignment = UITextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.font=[UIFont fontWithName:@"Helvetica-Bold" size:18];

    return label;
}


//- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
//{
//	return [customPickerArray count];
//}
//
//- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
//{
//	return 1;
//}




@end
