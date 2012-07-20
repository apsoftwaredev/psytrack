//
//  PracticumLogMonthPickerVC.m
//  PsyTrack
//
//  Created by Daniel Boice on 7/18/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "PracticumLogMonthPickerVC.h"

@interface PracticumLogMonthPickerVC ()

@end

@implementation PracticumLogMonthPickerVC
@synthesize picker;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        picker.dataSource=self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}


- (NSString *)titleForRow:(NSInteger)row
{
    NSString *title = nil;
    switch (row) 
    {
        case 0: title = @"lb";     break;
        case 1: title = @"kg";    break;
            
    }
    return title;
}

- (NSInteger)rowForTitle:(NSString *)title
{
    
    
    NSInteger row = 0;
    
    for(NSInteger i=0; i<3; i++)
    {
        if([title isEqualToString:[self titleForRow:i]])
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
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger returnInteger=2;
    
  
        
        

    return returnInteger;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    
    if ([SCUtilities is_iPad]) 
        return  95.0;
    else
        return 50.0;
    
    
    
    
}
#pragma mark -
#pragma mark UIPickerViewDelegate methods

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *returnStr = @"";
	
	// note: custom picker doesn't care about titles, it uses custom views
	
    
    
	
    if (component<=2) {
        returnStr = [[NSNumber numberWithInt:row] stringValue];
    }
    if (component==3) {
        returnStr = [self titleForRow:row];
    }
    
	
	return returnStr;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{

    
}


@end
