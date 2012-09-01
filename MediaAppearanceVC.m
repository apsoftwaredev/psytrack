//
//  MediaAppearanceVC.m
//  PsyTrack
//
//  Created by Daniel Boice on 9/1/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "MediaAppearanceVC.h"
#import "PTTAppDelegate.h"
@interface MediaAppearanceVC ()

@end

@implementation MediaAppearanceVC


- (void)viewDidLoad
{
    [super viewDidLoad];
    dateFormatter = [[NSDateFormatter alloc] init];
    
    //set the date format
    [dateFormatter setDateFormat:@"M/d/yyyy"];
    [dateFormatter setTimeZone:[NSTimeZone defaultTimeZone]];
    
    
    
    
    NSManagedObjectContext * managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    
    SCEntityDefinition *expertTestemonyDef=[SCEntityDefinition definitionWithEntityName:@"MediaAppearanceEntity" managedObjectContext:managedObjectContext propertyNamesString:@"showName;audience;dateInterviewed;host;hours;network;notes; showtimes;topics"];
    

}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
