//
//  PracticumLogMonthPickerView.m
//  PsyTrack
//
//  Created by Daniel Boice on 7/18/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "PracticumLogMonthPickerView.h"

@implementation PracticumLogMonthPickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.dataSource=self;
        
    }
    return self;
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



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger) numberOfRowsInComponent:(NSInteger)component
{
    NSInteger returnInteger=2;
    
        return returnInteger;
}

-(CGFloat)widthForComponent:(NSInteger)component{
    
    
    if ([SCUtilities is_iPad]) 
        return  95.0;
    else
        return 50.0;
    
    
    
    
}
#pragma mark -
#pragma mark UIPickerViewDelegate methods

- (NSString *)titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *returnStr = @"test";
	
	// note: custom picker doesn't care about titles, it uses custom views
	
    
    
	
    if (component<=2) {
        returnStr = [[NSNumber numberWithInt:row] stringValue];
    }
    if (component==3) {
        returnStr = [self titleForRow:row];
    }
    
	
	return returnStr;
}

- (void)didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    }



@end
