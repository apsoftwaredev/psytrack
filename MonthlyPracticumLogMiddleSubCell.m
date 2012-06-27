//
//  MonthlyPracticumLogMiddleSubCell.m
//  PsyTrack
//
//  Created by Daniel Boice on 6/26/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "MonthlyPracticumLogMiddleSubCell.h"
#import "PTTAppDelegate.h"
#import "InterventionTypeEntity.h"
#import "MonthlyPracticumLogBottonCell.h"
#import "InterventionTypeSubtypeEntity.h"
@implementation MonthlyPracticumLogMiddleSubCell

@synthesize cellHeaderLabel;

@synthesize sectionFooterTotalLabel;

@synthesize sectionFooterView;

@synthesize sectionTableView;


-(void)willDisplay{
   
    self.accessoryType=UITableViewCellAccessoryNone;
    
    InterventionTypeEntity *interventionType=(InterventionTypeEntity *)self.boundObject;
    self.cellHeaderLabel.text=interventionType.interventionType;
    
    
    
}


-(void)loadBindingsIntoCustomControls{
    
    [super loadBindingsIntoCustomControls];
    
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    

    
    SCEntityDefinition *interventionSubTypeDef=[SCEntityDefinition definitionWithEntityName:@"InterventionTypeSubtypeEntity" managedObjectContext: appDelegate.managedObjectContext propertyNames:[NSArray arrayWithObjects:@"interventionSubType", nil]];
    
    
    InterventionTypeEntity *interventionType=(InterventionTypeEntity *)self.boundObject;
    
    [interventionType willAccessValueForKey:@"subTypes"];
    NSLog(@"bound object is %@",self.boundObject);
    // Create and add the objects section
//	SCArrayOfObjectsSection *objectsSection = [SCArrayOfObjectsSection sectionWithHeaderTitle:nil items:[NSMutableArray arrayWithArray:[(NSMutableSet *)[self.boundObject mutableSetValueForKey :@"subTypes"] allObjects] ]itemsDefinition:interventionSubTypeDef];                                 
    NSLog(@"subttypes are %@",[NSMutableArray arrayWithArray:[(NSMutableSet *)[self.boundObject mutableSetValueForKey :@"subTypes"] allObjects]]);
    [interventionType didAccessValueForKey:@"subTypes"];
//    objectsSection.sectionActions.cellForRowAtIndexPath = ^SCCustomCell*(SCArrayOfItemsSection *itemsSection, NSIndexPath *indexPath)
//    {
//        // Create & return a custom cell based on the cell in ContactOverviewCell.xib
//        NSString *bindingsString = @"20:interventionSubType"; // 1,2,3 are the control tags
//        MonthlyPracticumLogBottonCell *contactOverviewCell = [MonthlyPracticumLogBottonCell cellWithText:nil objectBindingsString:bindingsString nibName:@"MonthlyPracticumLogBottomCell"];
//        
//        
//        return contactOverviewCell;
//    };
    
    
    objectsModel=[[SCArrayOfObjectsModel alloc]initWithTableView:self.sectionTableView items:[NSMutableArray arrayWithArray:[(NSMutableSet *)[self.boundObject mutableSetValueForKey :@"subTypes"] allObjects] ]itemsDefinition:interventionSubTypeDef];
    
    objectsModel.delegate=self;
    
//    [objectsModel addSection:objectsSection];
    
    
    
    
}

@end
