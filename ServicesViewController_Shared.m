//
//  ServicesViewController_Shared.m
//  PsyTrack
//
//  Created by Daniel Boice on 4/5/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "ServicesViewController_Shared.h"
#import "PTTAppDelegate.h"
#import "Time_Shared.h"
#import "ButtonCell.h"
#import "ClientPresentations_Shared.h"
#import "ClientsViewController_iPhone.h"
#import "ClientsRootViewController_iPad.h"
#import "TimeEntity.h"

@interface ServicesViewController_Shared ()

@end

@implementation ServicesViewController_Shared



@synthesize tableView=_tableView;
@synthesize searchBar=_searchBar;
@synthesize totalAdministrationsLabel;
@synthesize stopwatchTextField;
@synthesize clientPresentations_Shared;
@synthesize eventsList,eventStore,eventViewController,psyTrackCalendar;
//@synthesize managedObject;


#pragma mark -
#pragma mark View lifecycle


- (void) didReceiveMemoryWarning 
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
    PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    [appDelegate displayMemoryWarning];
    
}


-(void)viewDidUnload{
    
    [super viewDidUnload];
    
    
    self.view=nil;

   
 
    managedObjectContext=nil;
   
  
    
  
   eventTitleString=nil;
    
  tableModelClassDefEntity=nil;
    

    self.clientPresentations_Shared=nil;
    self.psyTrackCalendar=nil;
    self.eventStore=nil;
    
    self.eventsList=nil;
    self.eventViewController=nil;
    
    time_Shared=nil;
    
    searchBar=nil;
//    tableView=nil;
    
    
    
  
    
    
    
    
    counterDateFormatter=nil;
    referenceDate=nil;
    totalTimeDate=nil;
    addStopwatch=nil;
    serviceDateCell=nil;
    
    
    breakTimeTotalHeaderLabel=nil;
    
    
    
    currentDetailTableViewModel=nil;
    
    
    eventButtonBoundObject=nil;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
   
//    NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:2];
//    
//    
//    
//    
//    
//    // create a spacer
//    UIBarButtonItem* editButton = [[UIBarButtonItem alloc]
//                                   initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:nil action:nil];
//    [buttons addObject:editButton];
//    
//    
//    
//    
//    // create a standard "add" button
//    UIBarButtonItem* addButton = [[UIBarButtonItem alloc]
//                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:NULL];
//    addButton.style = UIBarButtonItemStyleBordered;
//    [buttons addObject:addButton];
//    
//    // stick the buttons in the toolbar
//    self.navigationItem.rightBarButtonItems=buttons;
    
 
       

   
    
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"EEE, M/d/yyyy"];
    
    
    
    
    
	
	// Get managedObjectContext from application delegate
    managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
	
    
    
 
    
    
 
    
    time_Shared=[[Time_Shared alloc]init];
    
    [time_Shared setupTheTimeViewUsingSTV];
    
    time_Shared.delegate=time_Shared;

    clientPresentations_Shared=[[ClientPresentations_Shared alloc]init];
    
    [clientPresentations_Shared setupUsingSTV];
    
    
  
    [self.searchBar setSelectedScopeButtonIndex:2];
    // Initialize tableModel

    if ([SCUtilities is_iPad]) {
        
        [self.tableView setBackgroundView:nil];
        [self.tableView setBackgroundView:[[UIView alloc] init]];
    }
        [self.tableView setBackgroundColor:[UIColor clearColor]];
    
    
    
    
    self.view.backgroundColor=[UIColor clearColor];
    
 
    counterDateFormatter=[[NSDateFormatter alloc]init];
    [counterDateFormatter setDateFormat:@"HH:mm:ss"];
    
    [counterDateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];  
    
    
    referenceDate=[counterDateFormatter dateFromString:@"00:00:00"];
    
    // Initialize an event store object with the init method. Initilize the array for events.
	self.eventStore = [[EKEventStore alloc] init];
    
	self.eventsList = [[NSMutableArray alloc] initWithArray:0];
    // find local source
    //    EKSource *localSource = nil;
    //    for (EKSource *source in eventStore.sources){
    //        if (source.sourceType == EKSourceTypeLocal)
    //        {
    //            localSource = source;
    //            
    //            break;
    //        }
    //    }
    
    self.psyTrackCalendar=[ self eventEditViewControllerDefaultCalendarForNewEvents:nil];
    
    
    
    //                 NSSet *calendars=(NSSet *)[localSource calendars];
    //                    for(id obj in calendars) { 
    //                    if([obj isKindOfClass:[EKCalendar class]]){
    //                        EKCalendar *calendar=(EKCalendar *)obj;
    //                        if ([calendar.calendarIdentifier isEqualToString:self.psyTrackCalendar.calendarIdentifier]) {
    //                            self.psyTrackCalendar=(EKCalendar *)calendar;
    //                          
    //                            break;
    // 
    // Get the default calendar from store.
	
    
    //	    
    
    
    
}


//-(void)didMoveToParentViewController:(UIViewController *)parent{
//
//NSLog(@"will move to parent %@",parent);
//    if (!parent) {
//        [self viewDidUnload];
//    }
//}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Ensure that the view controller supports rotation and that the split view can therefore show in both portrait and landscape.    
    return YES;
}

- (void)tableViewModel:(SCArrayOfItemsModel *)tableViewModel
searchBarSelectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    
    //NSLog(@"scope changed");
    
    
    
    
    if([tableViewModel isKindOfClass:[SCArrayOfObjectsModel class]])
    {
        SCArrayOfObjectsModel *objectsModel = (SCArrayOfObjectsModel *)tableViewModel;
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit ) fromDate:[NSDate date]];
        //create a date with these components
        NSDate *startDate = [calendar dateFromComponents:components];
        [components setMonth:1];
        [components setDay:0]; //reset the other components
        [components setYear:0]; //reset the other components
        NSDate *endDate = [calendar dateByAddingComponents:components toDate:startDate options:0];
        //NSLog(@"start dtate %@",startDate);
        //NSLog(@"end date is %@", endDate);
        
        NSPredicate *currentMonthPredicate = [NSPredicate predicateWithFormat:@"((dateOfService > %@) AND (dateOfService <= %@)) || (dateOfService = nil)",startDate,endDate];
        NSPredicate *paperworkIncompletePredicate = [NSPredicate predicateWithFormat:@"paperwork == %@",[NSNumber numberWithInteger: 0]];
        
        
        [self.searchBar setSelectedScopeButtonIndex:selectedScope];
        
        switch (selectedScope) {
            case 1: //Male
//                objectsModel.itemsPredicate = nil;
                //NSLog(@"case default");
                break;
                
            case 2: //Male
//                objectsModel.itemsPredicate = paperworkIncompletePredicate;
                //NSLog(@"case paperwork Incomplete");
                break;                
                
            default:
//                objectsModel.itemsPredicate = currentMonthPredicate;
                //NSLog(@"case 1");
                
                
                break;
        }
        [objectsModel reloadBoundValues];
        [objectsModel.modeledTableView reloadData]; 
            }
}



-(void)tableViewModel:(SCTableViewModel *)tableModel detailModelCreatedForRowAtIndexPath:(NSIndexPath *)indexPath detailTableViewModel:(SCTableViewModel *)detailTableViewModel{
    
    [self tableViewModel:(SCTableViewModel *)tableModel detailModelCreatedForSectionAtIndex:(NSUInteger )indexPath.section detailTableViewModel:(SCTableViewModel *)detailTableViewModel];
    if (indexPath.row!=NSNotFound) {
        SCTableViewCell *cell=(SCTableViewCell *)[tableModel cellAtIndexPath:indexPath];
        NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
        if (detailTableViewModel.tag==2 ||tableModel.tag==1) 
        {
            
            
            //NSLog(@"cell managed object is%@ ",cellManagedObject.entity.name);
            //NSLog(@"detail model class is %@",[detailTableViewModel class]);
            if (cellManagedObject &&[cellManagedObject respondsToSelector:@selector(entity)] &&[cellManagedObject.entity.name isEqualToString:@"TimeEntity"]) 
            {
                
                
                
                time_Shared.tableViewModel=detailTableViewModel;
                time_Shared.tableViewModel.delegate=time_Shared;
//                tableModel.detailViewController=time_Shared;
            }
            
        }    

    }
       
    
    
    
    
    
    
    
    
}





-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailModelCreatedForSectionAtIndex:(NSUInteger)index detailTableViewModel:(SCTableViewModel *)detailTableViewModel{
    
    if([SCUtilities is_iPad]&&detailTableViewModel.modeledTableView.backgroundView.backgroundColor!=[UIColor clearColor]){
        
        
        [detailTableViewModel.modeledTableView setBackgroundView:nil];
        [detailTableViewModel.modeledTableView setBackgroundView:[[UIView alloc] init]];
        [detailTableViewModel.modeledTableView setBackgroundColor:UIColor.clearColor]; // Make the table view transparent
        //NSLog(@"tableviewmodel is %@",detailTableViewModel.debugDescription);
        
    }   
    
}


-(void)tableViewModel:(SCTableViewModel *)tableViewModel willConfigureCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    ////NSLog(@"table view tag is %i",tableViewModel.tag);
    //    NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
    
    
    if(tableViewModel.tag==1 &&indexPath.section==0){
        //        NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
        //NSLog(@"cell bound object is %@",cellManagedObject);
        //NSLog(@"cell.tag%i",cell.tag);
        //NSLog(@"section managed object is %@",cellManagedObject.entity.name);
        switch (cell.tag) {
            case 0:
            {
                if ([cell isKindOfClass:[SCDateCell class]]){
                    serviceDateCell=(SCDateCell *)cell;
                }
            }
                break;
            case 1:
            {
                if ([cell isKindOfClass:[SCObjectCell class]]) {
                    
                    
                    if (![cell viewWithTag:28] ) {
                        
                        UILabel *totalTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(cell.frame.size.width-125, 5, 85, 30)];
                        
                        
                        totalTimeLabel.tag=28;
                        totalTimeLabel.text=[NSString stringWithFormat:@"00:00:00"];
                        totalTimeLabel.backgroundColor=[UIColor clearColor];
                        totalTimeLabel.textAlignment=UITextAlignmentRight;
                        totalTimeLabel.autoresizingMask=UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
                        [totalTimeLabel setFont:[UIFont fontWithName:@"Arial Rounded MT Bold" size:18]];
                        totalTimeLabel.textColor=[UIColor colorWithRed:50.0f/255 green:69.0f/255 blue:133.0f/255 alpha:1.0];
                        [cell addSubview:(UIView *)totalTimeLabel];
                        
                        
                    }
                }
                
            }
                break;  
                
                
            case 3:
            {
                if ([cell isKindOfClass:[ButtonCell class]]) {
                    
                    NSString *eventIdentifier=[cell.boundObject valueForKey:@"eventIdentifier"]; 
                    
                    
                    //NSLog(@"event Identifier %@", cell.boundObject);
                    NSString *buttonText;
                    if (eventIdentifier.length) {
                        buttonText=[NSString stringWithString:@"Edit This Calendar Event"];
                    }
                    else {
                        buttonText=[NSString stringWithString:@"Add Event to Calendar"];
                    }
                    ButtonCell *buttonCell=(ButtonCell *)cell;
                    UIButton *button=buttonCell.button;
                    [button setTitle:buttonText forState:UIControlStateNormal];
                    [button addTarget:self action:@selector(addEvent:) forControlEvents:UIControlEventTouchUpInside];
                    
                }
                
            }
                break;
                
                
                
            default:
                break;
        }
    }
    
    
    if (tableViewModel.tag==3) {
        
        
        
        NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
       
        
        if (cellManagedObject && [cellManagedObject.entity.name isEqualToString:@"ClientPresentationEntity"]) 
        {
            if (tableViewModel.delegate!=clientPresentations_Shared) 
            {
                clientPresentations_Shared.tableModel=self.tableViewModel;
                tableViewModel.delegate=clientPresentations_Shared;
                if (serviceDateCell.label.text.length) 
                {
                    clientPresentations_Shared.serviceDatePickerDate=(NSDate *)serviceDateCell.datePicker.date;
                }
                
                
                
                //NSLog(@"delegate switched to client presentation shared");
                
            }
            
        }
        
        
    }
    
    
  }





-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailViewWillDismissForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if (tableViewModel.tag==0) {
        serviceDateCell=nil;
        self.eventViewController=nil;
        if (clientPresentations_Shared) {
            clientPresentations_Shared.serviceDatePickerDate=nil;
        }
        
    }
    if (tableViewModel.tag==1){
        [time_Shared willDisappear];
        
        viewControllerOpen=FALSE;
        [tableViewModel.modeledTableView reloadData];
        //           [self timerDestroy];
        
        //           stopwatchRunning=nil;
        //           stopwatchIsRunningBool=NO;
        //           viewControllerOpen=NO;
        //           
        
        
    }
    
    
}
-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailViewWillPresentForSectionAtIndex:(NSUInteger)index withDetailTableViewModel:(SCTableViewModel *)detailTableViewModel{
    
    currentDetailTableViewModel=detailTableViewModel;
    
    if (tableViewModel.tag==2 && tableViewModel.sectionCount ==1) 
    {
        
        
        
        SCTableViewSection *section=(SCTableViewSection *)[tableViewModel sectionAtIndex:0];
        
        
        //NSLog(@"tableview model data source %@",tableViewModel.dataSource);
        if (section.cellCount>0) 
        {
            SCTableViewCell *cell=(SCTableViewCell *)[section cellAtIndex:0];
            
            if (section.cellCount>1 || (section.cellCount==1 &&![cell.textLabel.text isEqualToString:@"tap + to add clients"])) 
            {
                
                NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
                //NSLog(@"cell managed object is%@ ",cellManagedObject.entity.name);
                if (cellManagedObject && [cellManagedObject.entity.name isEqualToString:@"ClientPresentationEntity"]) {
                    
                    SCArrayOfObjectsSection *section=(SCArrayOfObjectsSection *)[tableViewModel sectionAtIndex:0];
                    NSMutableSet *mutableSet=[(NSMutableSet *)section.items mutableSetValueForKey:@"client"];
                    
                    SCArrayOfObjectsSection *mainSection=(SCArrayOfObjectsSection *)[detailTableViewModel sectionAtIndex:0];
                    ClientsSelectionCell *clientSelectionCell=(ClientsSelectionCell *)[mainSection cellAtIndex:0];
                    clientSelectionCell.alreadySelectedClients=mutableSet;
                    
                    //NSLog(@"client items are12345 %@",mutableSet);
                    clientSelectionCell.hasChangedClients=NO;
                    
                }
                
            }
            
            
            else if ([cell.textLabel.text isEqualToString:@"tap + to add clients"]) 
            {
                SCArrayOfObjectsSection *mainSection=(SCArrayOfObjectsSection *)[detailTableViewModel sectionAtIndex:0];
                ClientsSelectionCell *clientSelectionCell=(ClientsSelectionCell *)[mainSection cellAtIndex:0];
                clientSelectionCell.alreadySelectedClients=[[NSMutableSet alloc]init];;
                
            }
            
            
            
        }
    }
    
    
    
    
    
}
-(void)tableViewModel:(SCTableViewModel *)tableViewModel detailViewDidAppearForSectionAtIndex:(NSUInteger)index withDetailTableViewModel:(SCTableViewModel *)detailTableViewModel{
    self.eventViewController=nil;
    
    
    
}

-(void)tableViewModel:(SCTableViewModel *)tableModel detailModelConfiguredForRowAtIndexPath:(NSIndexPath *)indexPath detailTableViewModel:(SCTableViewModel *)detailTableViewModel{



    if (indexPath.row!=NSNotFound) {
        SCTableViewCell *cell=(SCTableViewCell *)[tableModel cellAtIndexPath:indexPath];
        NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
        if (detailTableViewModel.tag==2 ||tableModel.tag==1) 
        {
            
            
            //NSLog(@"cell managed object is%@ ",cellManagedObject.entity.name);
            //NSLog(@"detail model class is %@",[detailTableViewModel class]);
            if (cellManagedObject &&[cellManagedObject respondsToSelector:@selector(entity)] &&[cellManagedObject.entity.name isEqualToString:@"TimeEntity"]) 
            {
                
                
                
                time_Shared.tableViewModel=detailTableViewModel;
                time_Shared.tableViewModel.delegate=time_Shared;
                //                tableModel.detailViewController=time_Shared;
            }
            
        }    
        
    }


}

-(void)tableViewModel:(SCTableViewModel *)tableModel detailViewWillPresentForRowAtIndexPath:(NSIndexPath *)indexPath withDetailTableViewModel:(SCTableViewModel *)detailTableViewModel{
    if (tableModel.tag==0||tableModel.tag==1) {
        currentDetailTableViewModel=detailTableViewModel;
        
    }
    
    
    if (detailTableViewModel.tag==2) {
        
        SCTableViewCell *cell=(SCTableViewCell *)[tableModel cellAtIndexPath:indexPath];
        NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
        //NSLog(@"cell managed object is%@ ",cellManagedObject.entity.name);
        if (cellManagedObject && [cellManagedObject.entity.name isEqualToString:@"TimeEntity"]) {
            
            [detailTableViewModel.modeledTableView setEditing:YES animated:NO];
        }
    }
    
    if (tableModel.tag==2 && tableModel.sectionCount ==1) {
        
        
        SCTableViewSection *section=(SCTableViewSection *)[tableModel sectionAtIndex:0];
        
        if (section.cellCount>0) 
        {
            
            SCTableViewCell *cell=(SCTableViewCell *)[tableModel cellAtIndexPath:indexPath];
            NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
            //NSLog(@"cell managed object is%@ ",cellManagedObject.entity.name);
            if (cellManagedObject && [cellManagedObject.entity.name isEqualToString:@"ClientPresentationEntity"]) {
                
                SCArrayOfObjectsSection *arrayOfObjectsSection=(SCArrayOfObjectsSection *)section;
                NSMutableSet *mutableSet=[(NSMutableSet *)arrayOfObjectsSection.items mutableSetValueForKey:@"client"];
                
                SCArrayOfObjectsSection *mainSection=(SCArrayOfObjectsSection *)[detailTableViewModel sectionAtIndex:0];
                ClientsSelectionCell *clientSelectionCell=(ClientsSelectionCell *)[mainSection cellAtIndex:0];
                clientSelectionCell.alreadySelectedClients=mutableSet;
                
                //NSLog(@"client items are12345 %@",mutableSet);
                
            }
        } 
    }
}


- (void)tableViewModel:(SCTableViewModel *)tableViewModel didAddSectionAtIndex:(NSUInteger)index
{
    
    SCTableViewSection *section = [tableViewModel sectionAtIndex:index];
    
    //    NSManagedObject *sectionManagedObject=(NSManagedObject *)section.boundObject;
    
    
    if(section.headerTitle !=nil)
    {
        
        //        if (!(tableViewModel.tag ==2 && index==0 &&[sectionManagedObject.entity.name isEqualToString:@"TimeEntity"] )) 
        //        {
        
        
        UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 60)];
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 300, 40)];
        
        
        headerLabel.backgroundColor = [UIColor clearColor];
        headerLabel.textColor = [UIColor whiteColor];
        headerLabel.tag=60;
        headerLabel.text=section.headerTitle;
        [containerView addSubview:headerLabel];
        
        section.headerView = containerView;
        
        //        }
        
    }
    
    if (tableViewModel.tag==3 && tableViewModel.sectionCount&&index==0) {
        
        
      
        SCTableViewSection *sectionOne=(SCTableViewSection *)[tableViewModel sectionAtIndex:0];
        SCTableViewCell *sectionOneClicianCell=(SCTableViewCell *)[sectionOne cellAtIndex:0];
        NSManagedObject *cellManagedObject=(NSManagedObject *)sectionOneClicianCell.boundObject;        
        
        if (cellManagedObject && [cellManagedObject.entity.name isEqualToString:@"ClientPresentationEntity"]) 
        
        {
            //if change the cell text then update the method that sets the age with the new cell text
            SCLabelCell *actualAge=[SCLabelCell cellWithText:@"Test Age" boundObject:nil labelTextPropertyName:@"Age"];
            SCLabelCell *wechslerAge=[SCLabelCell cellWithText:@"Wechlsler Test Age" boundObject:nil labelTextPropertyName:@"WechslerAge"];
            actualAge.label.text=[NSString stringWithString: @"0y 0m"];
            wechslerAge.label.text=[NSString stringWithFormat:@"%iy %im",0,0];
            [section addCell:actualAge];
            [section addCell:wechslerAge];
        
        }
}
}



- (void)tableViewModel:(SCTableViewModel *)tableViewModel 
       willDisplayCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    NSManagedObject *cellManagedObject = (NSManagedObject *)cell.boundObject;
    
    
    
    if (tableViewModel.tag==0) 
    {
        
        SCTableViewSection *section=(SCTableViewSection *)[tableViewModel sectionAtIndex:indexPath.section];
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        //set the date format
        [dateFormatter setDateFormat:@"MMM d, yyyy"];
        //Set the date attributes in the  property definition and make it so the date picker appears 
        cell.textLabel.text= [dateFormatter stringFromDate:[cellManagedObject valueForKey:@"dateOfService"]];
        if (cellManagedObject) {
            
            
            
            //rule out selection cells with SCArrayOfStringsSection, prevents sex and sexual orientation selection views from raising an exception on managedObject.entity.name
            if (![section isKindOfClass:[SCArrayOfStringsSection class]]) {
                
                //NSLog(@"entity name is %@",cellManagedObject.entity.name);
                //identify the Languages Spoken table
                if ([cellManagedObject.entity.name isEqualToString:tableModelClassDefEntity]) {
                    //NSLog(@"the managed object entity is Languag spoken Entity");
                    //get the value of the primaryLangugage attribute
                    NSNumber *paperworkNumber=(NSNumber *)[cellManagedObject valueForKey:@"paperwork"];
                    
                    
                    //NSLog(@"primary alanguage %@",  paperworkNumber);
                    //if the paperwork selection is Yes
                    if (paperworkNumber==[NSNumber numberWithInteger:0]) {
                        //set the text color to red
                        cell.textLabel.textColor=[UIColor redColor];
                    }
                    
                    NSMutableSet *clientSet=[cellManagedObject mutableSetValueForKeyPath:@"clientPresentations.client.clientIDCode"];
                    
                    //NSLog(@"client set is %@",clientSet);
                    
                    NSString *clientsString=[NSString string];
                    if ([clientSet count]) {
                        for (id obj in clientSet){
                            clientsString=[clientsString stringByAppendingFormat:@" %@,",obj];
                            
                            
                        }
                        
                    }
                    
                    NSString *cellTextString=[cell.textLabel text];
                    if ( [clientsString length] > 1){
                        clientsString = [clientsString substringToIndex:[clientsString length] - 1];
                        clientsString =[clientsString substringFromIndex:1]; 
                        if (cellTextString.length) {
                            cellTextString=[cellTextString stringByAppendingFormat:@": %@ ",clientsString];
                            
                        }
                    }
                    
                    
                    
                    NSString *notesString=[cellManagedObject valueForKey:@"notes"];
                    
                    if (notesString.length &&cellTextString.length) {
                        cellTextString=[cellTextString stringByAppendingFormat:@"; %@",notesString];
                    }
                    else if(notesString.length &&!cellTextString.length){
                        cellTextString=notesString;
                    }
                    
                    [cell.textLabel setText:cellTextString];
                    
                    //NSLog(@"cell text label text is %@",cell.textLabel.text);
                    
                }
            }
            
        }
        
        
        
    }
    
    
    if (tableViewModel.tag==1) 
    {
        
        
        if (cell.tag==1)
        {
            //NSLog(@"cell is kind of class %@",[cell class]);
            if ([cell isKindOfClass:[SCObjectCell class]]) 
            {
                
                totalTimeDate=(NSDate *)[cell.boundObject valueForKey:@"totalTime"];
                //NSLog(@"total time date in will display cell objects %@", totalTimeDate);
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
    
    
    
    
    
}




-(void)tableViewModel:(SCTableViewModel *)tableViewModel valueChangedForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //NSLog(@"value changed for row at index path");
    
    
    if (tableViewModel.tag==1) 
    {
        SCSelectionCell *cell=(SCSelectionCell *)[tableViewModel.modeledTableView cellForRowAtIndexPath:indexPath];
        //NSLog(@"cell.tag %i",cell.tag);
        if (cell.tag==0) {
            if ([cell isKindOfClass:[SCDateCell class]]){
                serviceDateCell=(SCDateCell *)cell;
            }
        }
        
        if (cell.tag==1) //time cell
        {
            
            
            
            
            
            
            //NSLog(@"cell is kind of class %@",[cell class]);
            if ([cell isKindOfClass:[SCObjectCell class]]) 
            {
                
                [cell.boundObject setValue:time_Shared.totalTimeDate forKey:@"totalTime"];
                [self tableViewModel:(SCTableViewModel *)tableViewModel 
                     willDisplayCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath];
                
                
                
                
            }
        }
            }
    
    
    
    
    
    
}








#pragma mark -
#pragma mark Add a new event

// If event is nil, a new event is created and added to the specified event store. New events are 
// added to the default calendar. An exception is raised if set to an event that is not in the 
// specified event store.
- (void)addEvent:(id)sender {
	
    EKEvent *thisEvent;
    
    
    //NSLog(@"add event sender is %@",[sender superclass]);
    if ([[sender class] isSubclassOfClass:[UIButton class]]) 
    {
        UIButton *button=(UIButton *)sender;
        UIView *buttonView=(UIView *)button.superview;
        //NSLog(@"button superview is %@",buttonView.superview);
        
        if ([buttonView.superview isKindOfClass:[ButtonCell class]]) 
        {
            ButtonCell *buttonCell=(ButtonCell *)buttonView.superview;
            
            
            NSManagedObject *buttonManagedObject=(NSManagedObject *)buttonCell.boundObject;
            NSString *eventIdentifier=(NSString *)[buttonManagedObject valueForKey:@"eventIdentifier"];
            //NSLog(@"event identifier in add event %@",eventIdentifier);
            if (eventIdentifier.length) {
                if (!eventViewController) {
                    
                    thisEvent= (EKEvent *)[self.eventStore eventWithIdentifier:eventIdentifier];
                    
                    self.eventViewController=[[EKEventEditViewController alloc]initWithNibName:nil bundle:nil];
                    [eventViewController setEvent:thisEvent];
                    
                    //                  
                }
                [currentDetailTableViewModel.viewController.navigationController presentModalViewController:eventViewController animated:YES];
                eventViewController.editViewDelegate=self;
                
                
            }
            
            else 
            {
                
                // When add button is pushed, create an EKEventEditViewController to display the event.
                EKEventEditViewController *addController = [[EKEventEditViewController alloc] initWithNibName:@"MyEKEventEditViewController" bundle:nil];
                //                UIView *addControllerView=(UIView *) addController.view;
                
                //                
                // set the addController's event store to the current event store.
                addController.eventStore = self.eventStore;
                thisEvent = (EKEvent *) addController.event;
                
                if (!self.psyTrackCalendar) {
                    [thisEvent setCalendar:[self eventEditViewControllerDefaultCalendarForNewEvents:addController]];
                }
                else {
                    [thisEvent setCalendar:self.psyTrackCalendar];
                }
                //NSLog(@"add new event calander %@",self.psyTrackCalendar);
                
                [buttonCell commitDetailModelChanges:currentDetailTableViewModel];
                
                [currentDetailTableViewModel.modeledTableView reloadData];
                
                NSManagedObject *buttonCellManagedObject=(NSManagedObject *)buttonCell.boundObject;
                
                //NSLog(@"button cell managed object is %@",buttonCellManagedObject);
                
                TimeEntity *timeEntity=(TimeEntity *)[buttonCellManagedObject valueForKey:@"time"];
                
                NSDate *testDate=(NSDate *)[buttonCellManagedObject valueForKey:@"dateOfService"];
                
                NSDate *startTime=(NSDate *)[timeEntity valueForKey:@"startTime"];
                //NSLog(@"time entity is %@",timeEntity);
                
                NSDate *endTime=(NSDate *)[timeEntity valueForKey:@"endTime"];
                
                
                NSDateFormatter *dateFormatterTime=[[NSDateFormatter alloc]init];
                
                [dateFormatterTime setTimeZone:[NSTimeZone defaultTimeZone]];
                
                
                
                NSDateFormatter *dateFormatterDate=[[NSDateFormatter alloc]init];
                
                [dateFormatterDate setTimeZone:[NSTimeZone defaultTimeZone]];
                
                [dateFormatterDate setDateFormat:@"MM/d/yyyy"];
                
                [dateFormatterTime setDateFormat:@"H:m"];
                
                NSDateFormatter *dateFormatterCombined=[[NSDateFormatter alloc]init];
                
                [dateFormatterCombined setTimeZone:[NSTimeZone defaultTimeZone]];
                
                [dateFormatterCombined setDateFormat:@"H:m MM/d/yyyy"];
                
                if (startTime && testDate) {
                    NSString *startDateString=[NSString stringWithFormat:@"%@ %@",[dateFormatterTime stringFromDate:startTime],[dateFormatterDate stringFromDate:testDate]];
                    
                    //NSLog(@"startDateString is %@",startDateString);
                    
                    startTime=[dateFormatterCombined dateFromString:startDateString];
                    //NSLog(@"startTime is %@",startTime);
                }
                
                if (endTime && testDate) {
                    NSString *endDateString=[NSString stringWithFormat:@"%@ %@",[dateFormatterTime stringFromDate:endTime],[dateFormatterDate stringFromDate:testDate]];
                    
                    //NSLog(@"startDateString is %@",endDateString);
                    
                    endTime=[dateFormatterCombined dateFromString:endDateString];
                    
                    //NSLog(@"end time is %@", endTime);
                }
                
                thisEvent.startDate=startTime;
                thisEvent.endDate=endTime;
                
                NSMutableSet *clientSet=[buttonCellManagedObject mutableSetValueForKeyPath:@"clientPresentations.client.clientIDCode"];
                
                //NSLog(@"client set is %@",clientSet);
                
               
                for (id obj in clientSet){
                    eventTitleString=[eventTitleString stringByAppendingFormat:@" %@,",obj];
                    
                    
                }
                if ( [eventTitleString length] > 0)
                    eventTitleString = [eventTitleString substringToIndex:[eventTitleString length] - 1];
                
                thisEvent.title=(NSString *) eventTitleString;
                
                UIViewController *currentTableModelViewController=(UIViewController *)currentDetailTableViewModel.viewController;
                
                NSString *calenderLocation=[[NSUserDefaults standardUserDefaults] valueForKey:@"calander_location"];
                //NSLog(@"calander location is %@",calenderLocation);
                [thisEvent setLocation:calenderLocation];
                
                addController.editViewDelegate = self;
                addController.view.tag=837;
                addController.modalViewController.navigationController.delegate=self;
                //                PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
                //                
                //                UITabBarController *tabBarController=[appDelegate tabBarController];
                currentTableModelViewController.navigationController.delegate=self;
                [currentTableModelViewController.navigationController presentModalViewController:addController animated:YES];
                
                
                
            }
        }
        
    }
    
    
  }


#pragma mark -
#pragma mark EKEventEditViewDelegate

// Overriding EKEventEditViewDelegate method to update event store according to user actions.
- (void)eventEditViewController:(EKEventEditViewController *)controller 
          didCompleteWithAction:(EKEventEditViewAction)action {
	
	NSError *error = nil;
	EKEvent *thisEvent = controller.event;
	SCTableViewSection *section=(SCTableViewSection *)[currentDetailTableViewModel sectionAtIndex:0];
    SCTableViewCell *cell=(SCTableViewCell *)[section cellAtIndex:3];
    
	switch (action) {
		case EKEventEditViewActionCanceled:
			// Edit action canceled, do nothing.
        {
            
            
        }
			break;
			
		case EKEventEditViewActionSaved:
        {
			// When user hit "Done" button, save the newly created event to the event store, 
			// and reload table view.
			// If the new event is being added to the default calendar, then update its 
			// eventsList.
			
            //NSLog(@"self psyTrack calendar %@",self.psyTrackCalendar);
            //NSLog(@"even calander is %@",thisEvent.calendar);
            
            if (self.psyTrackCalendar ==  thisEvent.calendar) {
				[self.eventsList addObject:thisEvent];
			}
			[controller.eventStore saveEvent:controller.event span:EKSpanThisEvent error:&error];
			
            //NSLog(@"section count is %i",currentDetailTableViewModel.sectionCount);
            
            //NSLog(@"cell bound object in save event is %@",cell.boundObject);
            
            [cell.boundObject setValue:[controller.event eventIdentifier] forKey:@"eventIdentifier"];
            [cell commitChanges];
            [cell reloadBoundValue];
            if ([cell isKindOfClass:[ButtonCell class]]) {
                ButtonCell *buttonCell=(ButtonCell *)cell;
                UIButton *button=(UIButton *)buttonCell.button;
                
                [button setTitle:@"Edit Calendar Event" forState:UIControlStateNormal];
                //NSLog(@"cell identifier after reset button is %@",[cell.boundObject valueForKey:@"eventIdentifier"]);
            }
            
            //NSLog(@"event identifier controller .event.event identi %@", [cell.boundObject valueForKey:@"eventIdentifier"]);
            
            
        }
            
            break;
			
		case EKEventEditViewActionDeleted:
			// When deleting an event, remove the event from the event store, 
			// and reload table view.
			// If deleting an event from the currenly default calendar, then update its 
			// eventsList.
			
            //NSLog(@"self psyTrack calendar %@",self.psyTrackCalendar);
            //NSLog(@"even calander is %@",thisEvent.calendar);
            
            if (self.psyTrackCalendar ==  thisEvent.calendar) {
				[self.eventsList removeObject:thisEvent];
			}
			[controller.eventStore removeEvent:thisEvent span:EKSpanThisEvent error:&error];
			[cell.boundObject setNilValueForKey:@"eventIdentifier"];
            
            
            [cell commitChanges];
            [cell reloadBoundValue];
            if ([cell isKindOfClass:[ButtonCell class]]) {
                ButtonCell *buttonCell=(ButtonCell *)cell;
                UIButton *button=(UIButton *)buttonCell.button;
                
                [button setTitle:@"Add Event To Calendar" forState:UIControlStateNormal];
                //NSLog(@"cell identifier after reset button is %@",[cell.boundObject valueForKey:@"eventIdentifier"]);
            }
			break;
			
		default:
			break;
	}
	
    
    [controller dismissModalViewControllerAnimated:YES];
    
    
	
}



// Set the calendar edited by EKEventEditViewController to our chosen calendar - the default calendar.
- (EKCalendar *)eventEditViewControllerDefaultCalendarForNewEvents:(EKEventEditViewController *)controller {
	
    
    // Get the default calendar from store.
    //    settingsDictionary=(NSDictionary *)[(PTTAppDelegate *)[UIApplication sharedApplication].delegate settingsPlistDictionary];
    NSString *defaultCalendarIdentifier=[[NSUserDefaults standardUserDefaults] valueForKey:@"defaultCalendarIdentifier"];
	
    
    EKSource *mySource = nil;
    
    
    BOOL iCloudEnabled=(BOOL)[[NSUserDefaults standardUserDefaults] valueForKey:@"icloud_preference"];
    
    if (iCloudEnabled) {
        for (EKSource *source in eventStore.sources){
            
            if ([source.title isEqualToString: @"iCloud"])
            {
                mySource = source;
                //                //NSLog(@"cloud source type is %@",source.sourceType);
                
                break;
            }
        }
        
    }
    
    if (!mySource)
    {
        
        
        for (EKSource *source in eventStore.sources){
            
            if (source.sourceType==EKSourceTypeLocal)
            {
                mySource = source;
                
                break;
            }
        }
        
    }
    
    if (mySource) 
    {
        NSString *defaultCalendarName=[[NSUserDefaults standardUserDefaults] valueForKey:@"calendar_name"];
        //        NSSet *calendars=(NSSet *)[localSource calendars];
        if (defaultCalendarIdentifier.length) 
        {
            
            
            self.psyTrackCalendar =[self.eventStore calendarWithIdentifier:defaultCalendarIdentifier]; 
            mySource =psyTrackCalendar.source;
            
        }
        else 
        {
            
            self.psyTrackCalendar = [EKCalendar calendarWithEventStore:self.eventStore];
            
            [[NSUserDefaults standardUserDefaults] setValue:psyTrackCalendar.calendarIdentifier forKey:@"defaultCalendarIdentifier"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        }
        
        if (defaultCalendarName.length) {
            self.psyTrackCalendar.title =defaultCalendarName;
        }
        
        else 
        {
            
            self.psyTrackCalendar.title=@"Client Appointments";
        }
        self.psyTrackCalendar.source = mySource;
        
        
    }
    
    
    
    //NSLog(@"cal id = %@", self.psyTrackCalendar.calendarIdentifier);
    
    NSError *error;
    
    if (![self.eventStore saveCalendar:self.psyTrackCalendar commit:YES error:&error ]) {
        //NSLog(@"something didn't go right");
    }
    else
    {
        //NSLog(@"saved calendar");
        [[NSUserDefaults standardUserDefaults]setValue:psyTrackCalendar.calendarIdentifier forKey:@"defaultCalendarIdentifier"];
        //                 NSSet *calendars=(NSSet *)[localSource calendars];
        //                    for(id obj in calendars) { 
        //                    if([obj isKindOfClass:[EKCalendar class]]){
        //                        EKCalendar *calendar=(EKCalendar *)obj;
        //                        if ([calendar.calendarIdentifier isEqualToString:self.psyTrackCalendar.calendarIdentifier]) {
        //                            self.psyTrackCalendar=(EKCalendar *)calendar;
        //                          
        //                            break;
        //                        }
        
        
        //                    }
        
    }
    
    
    //            self.psyTrackCalendar =(EKCalendar *)localSource cal
    
    
    
    
    
    
    
    if (self.psyTrackCalendar) {
        //NSLog(@"self %@",self.psyTrackCalendar);
    }
    
    
    
    
    
    EKCalendar *calendarForEdit = self.psyTrackCalendar;
	return calendarForEdit;
}



@end
