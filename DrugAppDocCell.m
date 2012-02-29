//
//  DrugAppDocCell.m
//  psyTrainTrack
//
//  Created by Daniel Boice on 1/3/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "DrugAppDocCell.h"

@implementation DrugAppDocCell


- (void)performInitialization 
{
    
    [super performInitialization];
    
    // place any initialization code here
    
  
}



- (void)willDisplay
{
       self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}





- (void)loadBindingsIntoCustomControls
{
    [super loadBindingsIntoCustomControls];
    
    NSString *docType = [self.boundObject valueForKey:@"docType"];
    NSDate *docDate = [self.boundObject valueForKey:@"docDate"];
   
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"m/d/yyyy"];
    self.textLabel.text=docType;
    self.label.text=[dateFormatter stringFromDate:docDate];


    
}



-(void)didSelectCell{

 NSString *docURL = [self.boundObject valueForKey:@"docURL"];
[[UIApplication sharedApplication]  openURL:[NSURL URLWithString:docURL]];


}


@end
