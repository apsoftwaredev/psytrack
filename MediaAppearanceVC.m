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
    
    SCEntityDefinition *mediaAppearanceDef=[SCEntityDefinition definitionWithEntityName:@"MediaAppearanceEntity" managedObjectContext:managedObjectContext propertyNamesString:@"showName;audience;dateInterviewed;host;network; showtimes;topics;notes"];
    
    mediaAppearanceDef.orderAttributeName=@"order";
    SCPropertyDefinition *showNamePropertyDefinition=[mediaAppearanceDef propertyDefinitionWithName:@"showName"];
    showNamePropertyDefinition.type=SCPropertyTypeTextView;
    showNamePropertyDefinition.title=@"Show/Publication";
    
    SCPropertyDefinition *audiencePropertyDefinition=[mediaAppearanceDef propertyDefinitionWithName:@"audience"];
    audiencePropertyDefinition.type=SCPropertyTypeTextView;
    
    SCPropertyDefinition *hostPropertyDefinition=[mediaAppearanceDef propertyDefinitionWithName:@"host"];
    hostPropertyDefinition.type=SCPropertyTypeTextView;
    
    SCPropertyDefinition *notesPropertyDefinition=[mediaAppearanceDef propertyDefinitionWithName:@"notes"];
    notesPropertyDefinition.type=SCPropertyTypeTextView;
    
    SCPropertyDefinition *showtimesPropertyDefinition=[mediaAppearanceDef propertyDefinitionWithName:@"showtimes"];
    showtimesPropertyDefinition.type=SCPropertyTypeTextView;
    
    SCPropertyDefinition *topicsPropertyDefinition=[mediaAppearanceDef propertyDefinitionWithName:@"topics"];
    topicsPropertyDefinition.type=SCPropertyTypeTextView;
    
    //create the dictionary with the data bindings
    NSDictionary *hoursDataBindings = [NSDictionary
                                       dictionaryWithObjects:[NSArray arrayWithObjects:@"hours",nil]
                                       forKeys:[NSArray arrayWithObjects:@"1",nil ]];
    
    
    
    
    //create the custom property definition
    SCCustomPropertyDefinition *hoursDataProperty = [SCCustomPropertyDefinition definitionWithName:@"LengthData"
                                                                                  uiElementNibName:@"TotalHoursAndMinutesCell" objectBindings:hoursDataBindings];
    
    hoursDataProperty.title=nil;
    //set the autovalidate to false to catch the validation event with a custom validation, which is needed for custom cells
    hoursDataProperty.autoValidate=FALSE;
    
    
    [mediaAppearanceDef addPropertyDefinition:hoursDataProperty];
    
    SCPropertyDefinition *dateInterviewedPropertyDef=[mediaAppearanceDef propertyDefinitionWithName:@"dateInterviewed"];
    dateInterviewedPropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter
                                                                        datePickerMode:UIDatePickerModeDate
                                                         displayDatePickerInDetailView:NO];


    
    if([SCUtilities is_iPad]||[SCUtilities systemVersion]>=6){
        
        self.tableView.backgroundView=nil;
        UIView *newView=[[UIView alloc]init];
        [self.tableView setBackgroundView:newView];
        
        
    }
    self.tableView.backgroundColor=[UIColor clearColor];
    
    
    [self setNavigationBarType: SCNavigationBarTypeAddEditRight];
    
    objectsModel=[[SCArrayOfObjectsModel alloc]initWithTableView:self.tableView entityDefinition:mediaAppearanceDef];
    
    objectsModel.editButtonItem = self.editButton;;
    
    objectsModel.addButtonItem = self.addButton;
    
    UIViewController *navtitle=self.navigationController.topViewController;
    
    navtitle.title=@"Media Appearances";
    
    
    
    self.view.backgroundColor=[UIColor clearColor];
    
    
    

    
    objectsModel.allowMovingItems=TRUE;
    
    objectsModel.autoAssignDelegateForDetailModels=TRUE;
    objectsModel.autoAssignDataSourceForDetailModels=TRUE;
    
    
    objectsModel.enablePullToRefresh = TRUE;
    objectsModel.pullToRefreshView.arrowImageView.image = [UIImage imageNamed:@"blueArrow.png"];
    
    self.tableViewModel=objectsModel;

}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}
- (BOOL)disablesAutomaticKeyboardDismissal
{
    return NO;
}
-(void)tableViewModel:(SCTableViewModel *)tableModel detailViewWillPresentForRowAtIndexPath:(NSIndexPath *)indexPath withDetailTableViewModel:(SCTableViewModel *)detailTableViewModel{
    
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    
    if ([SCUtilities is_iPad]||[SCUtilities systemVersion]>=6) {
        //        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
        
        
        UIColor *backgroundColor=nil;
        
        if(indexPath.row==NSNotFound|| tableModel.tag>0)
        {
            //            backgroundImage=[UIImage imageNamed:@"iPad-background-blue.png"];
            backgroundColor=(UIColor *)(UIWindow *)appDelegate.window.backgroundColor;
            
            
            
        }
        else {
            
            
            
            backgroundColor=[UIColor clearColor];
            
            
        }
        
        if (detailTableViewModel.modeledTableView.backgroundColor!=backgroundColor) {
            
            [detailTableViewModel.modeledTableView setBackgroundView:nil];
            UIView *view=[[UIView alloc]init];
            [detailTableViewModel.modeledTableView setBackgroundView:view];
            [detailTableViewModel.modeledTableView setBackgroundColor:backgroundColor];
            
            
            
            
        }
        
        
    }
    if (tableModel.tag==0) {
        appDelegate.okayToSaveContext=YES;
    }
    else if (tableModel.tag>1){
        
        appDelegate.okayToSaveContext=NO;
        
    }
    
    
}
-(void)tableViewModel:(SCTableViewModel *)tableModel detailViewWillDismissForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (tableModel.tag==0) {
        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
        
        appDelegate.okayToSaveContext=YES;
    }
    
    
}


-(void)tableViewModel:(SCTableViewModel *)tableModel willDisplayCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableModel.tag==0){
        NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
        if (cellManagedObject && [cellManagedObject respondsToSelector:@selector(entity)]&&[cellManagedObject.entity.name isEqualToString:@"MediaAppearanceEntity"])
        {
            
            NSString *showNameStr=[cellManagedObject valueForKey:@"showName"];
            NSDate *dateInterviewed=[cellManagedObject valueForKey:@"dateInterviewed"];
            NSString *notesStr=[cellManagedObject valueForKey:@"notes"];
        
            
          
           
            NSString *cellText=nil;
            
            
            if (dateInterviewed) {
                cellText=[dateFormatter stringFromDate:dateInterviewed];
            }
            
            if (showNameStr &&showNameStr.length) {
                
                if (cellText&&cellText.length) {
                    cellText=[cellText stringByAppendingFormat:@": %@",showNameStr];
                }
                else
                {
                
                    cellText=showNameStr;
                    
                }
            }
            
            if (notesStr &&notesStr.length) {
                
                
                cellText=cellText?[cellText stringByAppendingFormat:@"; %@",notesStr]:notesStr;
                
            }
            
            cell.textLabel.text=cellText;
            
            
           
            
        }
    }

}
@end
