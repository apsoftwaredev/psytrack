//
//  CECreditsViewController.m
//  PsyTrack
//
//  Created by Daniel Boice on 7/28/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "CECreditsViewController.h"
#import "PTTAppDelegate.h"
#import "LicenseRenewalEntity.h"

@interface CECreditsViewController ()

@end

@implementation CECreditsViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   dateFormatter = [[NSDateFormatter alloc] init];
    
    //set the date format
    [dateFormatter setDateFormat:@"M/d/yyyy"];
    NSManagedObjectContext * managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    
    SCEntityDefinition *ceCreditsDef=[SCEntityDefinition definitionWithEntityName:@"ContinuingEducationEntity" managedObjectContext:managedObjectContext propertyNamesString:@"cETitle;type;provider;cost;credits;dateEarned;forLicenseRenewal;notes"];
    
    
    SCEntityDefinition *providerDef=[SCEntityDefinition definitionWithEntityName:@"ContinuingEducationProviderEntity" managedObjectContext:managedObjectContext propertyNamesString:@"providerName;notes"];
    
    providerDef.keyPropertyName=@"providerName";
    
    SCEntityDefinition *ceTypeDef=[SCEntityDefinition definitionWithEntityName:@"ContinuingEducationTypeEntity" managedObjectContext:managedObjectContext propertyNamesString:@"cEType;notes"];
    
    SCEntityDefinition *licenseRenewalDef=[SCEntityDefinition definitionWithEntityName:@"LicenseRenewalEntity" managedObjectContext:managedObjectContext propertyNamesString:@"license;renewalDate;notes"];
    
   licenseRenewalDef.titlePropertyName=@"renewalDate;license.licenseName.title";
    
    //Create a class definition for Degree entity
	SCEntityDefinition *licenseDef = [SCEntityDefinition definitionWithEntityName:@"LicenseEntity" 
                                                             managedObjectContext:managedObjectContext
                                                                    propertyNames:[NSArray arrayWithObjects:@"licenseName",@"governingBody",@"status",
                                                                                   @"renewDate",@"notes",@"renewals", nil]];
    
    licenseDef.titlePropertyName=@"licenseName.title";
    SCPropertyDefinition *licenseRenewalsPropertyDef=[ceCreditsDef propertyDefinitionWithName:@"forLicenseRenewal"];
    licenseRenewalsPropertyDef.type=SCPropertyTypeObjectSelection;
    
   

    
    SCObjectSelectionAttributes *licenseRenewalSelectionAttribs=[SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:licenseRenewalDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO];
    licenseRenewalSelectionAttribs.allowEditingItems=YES;
   
    licenseRenewalSelectionAttribs.placeholderuiElement=[SCTableViewCell cellWithText:@"Add licenses under 'my information' clinician record"];
    licenseRenewalsPropertyDef.attributes=licenseRenewalSelectionAttribs;
    SCPropertyDefinition *licenseRenewalRenewDatePropertyDef = [licenseRenewalDef propertyDefinitionWithName:@"renewDate"];
	licenseRenewalRenewDatePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter 
                                                                            datePickerMode:UIDatePickerModeDate 
                                                             displayDatePickerInDetailView:NO];
    
    
    //set the order attributes name defined in the License Number Entity    
    licenseDef.orderAttributeName=@"order";
    SCPropertyDefinition *licenseRenewDatePropertyDef = [licenseDef propertyDefinitionWithName:@"renewDate"];
	licenseRenewDatePropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter 
                                                                            datePickerMode:UIDatePickerModeDate 
                                                             displayDatePickerInDetailView:NO];
    
    
    
    //Create a class definition for License entity
	SCEntityDefinition *licenseNameDef = [SCEntityDefinition definitionWithEntityName:@"LicenseNameEntity" 
                                                                 managedObjectContext:managedObjectContext
                                                                        propertyNames:[NSArray arrayWithObjects:@"title",@"notes",nil]];
	
	
    
    //Create a class definition for the governingBody Entity
    SCEntityDefinition *governingBodyDef = [SCEntityDefinition definitionWithEntityName:@"GoverningBodyEntity" 
                                                                   managedObjectContext:managedObjectContext
                                                                          propertyNames:[NSArray arrayWithObjects:@"body",@"country", nil]];
    
    //Create a class definition for the country Entity
    SCEntityDefinition *countryDef = [SCEntityDefinition definitionWithEntityName:@"CountryEntity" 
                                                             managedObjectContext:managedObjectContext
                                                                    propertyNames:[NSArray arrayWithObjects:@"country",@"code", nil]];
    
    
    
    //set the order attributes name defined in the License Entity
    licenseNameDef.orderAttributeName=@"order";
    
    
    
    NSPredicate *myInformationPredicate=[NSPredicate predicateWithFormat:@"clinician.myInformation == %@",[NSNumber numberWithBool:YES]];
    
    
   
    SCPropertyDefinition *renualLicensePropertyDef=[licenseRenewalDef propertyDefinitionWithName:@"license"];
    
    
    renualLicensePropertyDef.type=SCPropertyTypeObjectSelection;
    
    SCObjectSelectionAttributes *licenseSelectionAttribs=[SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:licenseDef usingPredicate:myInformationPredicate  allowMultipleSelection:NO allowNoSelection:NO];
    
    licenseSelectionAttribs.allowAddingItems=NO;
    licenseSelectionAttribs.allowDeletingItems=NO;
    licenseSelectionAttribs.allowMovingItems=NO;
    licenseSelectionAttribs.allowEditingItems=NO;
    licenseSelectionAttribs.placeholderuiElement=[SCTableViewCell cellWithText:@"Add licenses under 'My Information' clinician record"];
    renualLicensePropertyDef.attributes=licenseSelectionAttribs;
    
    
    
    SCPropertyDefinition *licenseNamePropertyDef = [licenseDef propertyDefinitionWithName:@"licenseName"];
    
    //override the auto title generation for the License Name property definition and set it to a shorter title
    licenseNamePropertyDef.title =@"License";
	//override the auto title generation for the <#name#> property definition and set it to a custom title
    licenseNamePropertyDef.type = SCPropertyTypeObjectSelection;
	SCObjectSelectionAttributes *licenseNameSelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:licenseNameDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO];
    licenseNameSelectionAttribs.allowAddingItems = NO;
    licenseNameSelectionAttribs.allowDeletingItems = NO;
    licenseNameSelectionAttribs.allowMovingItems = NO;
    licenseNameSelectionAttribs.allowEditingItems = NO;
    licenseNameSelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(Define license Names)"];
    licenseNameSelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add new License Name"];
    licenseNamePropertyDef.attributes = licenseNameSelectionAttribs;
	
//    licenseDef.titlePropertyName=@"licenseName.title;governingBody.body";
    
    SCPropertyDefinition *licenseNotesPropertyDef = [licenseDef propertyDefinitionWithName:@"notes"];
	licenseNotesPropertyDef.type = SCPropertyTypeTextView;
    
    SCPropertyDefinition *licenseNameNotesPropertyDef = [licenseNameDef propertyDefinitionWithName:@"notes"];
	licenseNameNotesPropertyDef.type = SCPropertyTypeTextView;
    
    SCPropertyDefinition *licenseTitlePropertyDef = [licenseNameDef propertyDefinitionWithName:@"title"];
	licenseTitlePropertyDef.type = SCPropertyTypeTextView;
    
    //create an object selection for the governingBody relationship in the LicenseNuber Entity 
    
    //create a property definition
    SCPropertyDefinition *governingBodyPropertyDef = [licenseDef propertyDefinitionWithName:@"governingBody"];
    
    //set the title property name
    governingBodyDef.titlePropertyName=@"body";
    
    
    //set the property definition type to objects selection
	
    governingBodyPropertyDef.type = SCPropertyTypeObjectSelection;
    SCObjectSelectionAttributes *governingBodySelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:governingBodyDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:YES];
    
    //set some addtional attributes
    governingBodySelectionAttribs.allowAddingItems = YES;
    governingBodySelectionAttribs.allowDeletingItems = YES;
    governingBodySelectionAttribs.allowMovingItems = NO;
    governingBodySelectionAttribs.allowEditingItems = YES;
    
    //add a placeholder element to tell the user what to do     when there are no other cells                                          
    governingBodySelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(tap edit to add govering Bodies)"];
    
    
    //add an "Add New" element to appear when user clicks edit
    governingBodySelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add New governing body"];
    
    //add the selection attributes to the property definition
    governingBodyPropertyDef.attributes = governingBodySelectionAttribs;
    
    
    //create an object selection for the country relationship in the governing Body Entity 
    
    //create a property definition
    SCPropertyDefinition *countryPropertyDef = [governingBodyDef propertyDefinitionWithName:@"country"];
    
    
    
    //set the title property name
    countryDef.titlePropertyName=@"country";
    
    //set the property definition type to objects selection
	countryDef.keyPropertyName=@"country";
    countryPropertyDef.type = SCPropertyTypeObjectSelection;
    SCObjectSelectionAttributes *countrySelectionAttribs = [SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:countryDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:YES];
    
    //set some addtional attributes
    countrySelectionAttribs.allowAddingItems = YES;
    countrySelectionAttribs.allowDeletingItems = YES;
    countrySelectionAttribs.allowMovingItems = NO;
    countrySelectionAttribs.allowEditingItems = YES;
    
    //add a placeholder element to tell the user what to do     when there are no other cells                                          
    countrySelectionAttribs.placeholderuiElement = [SCTableViewCell cellWithText:@"(tap edit to add countries)"];
    
    
    //add an "Add New" element to appear when user clicks edit
    countrySelectionAttribs.addNewObjectuiElement = [SCTableViewCell cellWithText:@"Add New Country"];
    
    //add the selection attributes to the property definition
    countryPropertyDef.attributes = countrySelectionAttribs;
    

    
    
    ceTypeDef.orderAttributeName=@"order";
    
    SCPropertyDefinition *ceTypePropertyDef=[ceCreditsDef propertyDefinitionWithName:@"type"];
    ceTypePropertyDef.type=SCPropertyTypeObjectSelection;
    
    SCObjectSelectionAttributes *typeSelectionAttributes=[SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:ceTypeDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:YES];
    
    typeSelectionAttributes.allowMovingItems=YES;
    typeSelectionAttributes.allowAddingItems=YES;
    typeSelectionAttributes.allowDeletingItems=YES;
    typeSelectionAttributes.allowEditingItems=YES;
    typeSelectionAttributes.placeholderuiElement=[SCTableViewCell cellWithText:@"Tap edit to add CE types"];
    typeSelectionAttributes.addNewObjectuiElement=[SCTableViewCell cellWithText:@"Add CE type"];
    
    ceTypePropertyDef.attributes=typeSelectionAttributes;
    
    SCPropertyDefinition *typeNotesPropertyDef=[ceTypeDef propertyDefinitionWithName:@"notes"];
    typeNotesPropertyDef.type=SCPropertyTypeTextView;
    
    SCPropertyDefinition *providerNamePropertyDef=[providerDef propertyDefinitionWithName:@"providerName"];
    providerNamePropertyDef.type=SCPropertyTypeTextView;
    
    SCPropertyDefinition *providerNotesPropertyDef=[providerDef propertyDefinitionWithName:@"notes"];
    providerNotesPropertyDef.type=SCPropertyTypeTextView;
    
    
    SCPropertyDefinition *ceCreditsProviderPropertyDef=[ceCreditsDef propertyDefinitionWithName:@"provider"];
    
    ceCreditsProviderPropertyDef.type=SCPropertyTypeObjectSelection;
    
    SCObjectSelectionAttributes *providerSelectionAttribs=[SCObjectSelectionAttributes attributesWithObjectsEntityDefinition:providerDef usingPredicate:nil allowMultipleSelection:NO allowNoSelection:NO];
    
    providerSelectionAttribs.allowAddingItems=YES;
    providerSelectionAttribs.allowDeletingItems=YES;
    providerSelectionAttribs.allowEditingItems=YES;
    providerSelectionAttribs.allowMovingItems=YES;
    providerSelectionAttribs.placeholderuiElement=[SCTableViewCell cellWithText:@"Tap edit to add providers"];
    providerSelectionAttribs.addNewObjectuiElement=[SCTableViewCell cellWithText:@"Add provider"];
    ceCreditsProviderPropertyDef.attributes=providerSelectionAttribs;
    
    SCPropertyDefinition *dateEarnedPropertyDef = [ceCreditsDef propertyDefinitionWithName:@"dateEarned"];
	dateEarnedPropertyDef.attributes = [SCDateAttributes attributesWithDateFormatter:dateFormatter 
                                                                     datePickerMode:UIDatePickerModeDate 
                                                      displayDatePickerInDetailView:NO];
    

    
    SCPropertyDefinition *ceCostPropertyDef=[ceCreditsDef propertyDefinitionWithName:@"cost"];
    ceCostPropertyDef.title=@"Cost $";
    
    
    SCPropertyDefinition *ceTitlePropertyDef=[ceCreditsDef propertyDefinitionWithName:@"cETitle"];
    ceTitlePropertyDef.type=SCPropertyTypeTextView;
    ceTitlePropertyDef.title=@"Title";
    
    
    SCPropertyDefinition *ceCreditNotesPropertyDef=[ceCreditsDef propertyDefinitionWithName:@"notes"];
    ceCreditNotesPropertyDef.type=SCPropertyTypeTextView;
    
    objectsModel=[[SCArrayOfObjectsModel alloc]initWithTableView:self.tableView entityDefinition:ceCreditsDef];
    
    
    if(![SCUtilities is_iPad]){
        
        self.tableView.backgroundView=nil;
        UIView *newView=[[UIView alloc]init];
        [self.tableView setBackgroundView:newView];
        
        
    }
    self.tableView.backgroundColor=[UIColor clearColor];
   
    
    [self setNavigationBarType: SCNavigationBarTypeAddEditRight];
    
    objectsModel.editButtonItem = self.editButton;;
    
    objectsModel.addButtonItem = self.addButton;
    
    UIViewController *navtitle=self.navigationController.topViewController;
    
    navtitle.title=@"Continuing Education";
    
    
    
    self.view.backgroundColor=[UIColor clearColor];
    
    
    
	objectsModel.searchPropertyName = @"dateOfService";
    
    objectsModel.allowMovingItems=TRUE;
    
    objectsModel.autoAssignDelegateForDetailModels=TRUE;
    objectsModel.autoAssignDataSourceForDetailModels=TRUE;
    
    
    objectsModel.enablePullToRefresh = TRUE;
    objectsModel.pullToRefreshView.arrowImageView.image = [UIImage imageNamed:@"blueArrow.png"];
    
    self.tableViewModel=objectsModel;
    

    //remove any orphan license renewals
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"LicenseRenewalEntity" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"license==nil"];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSUInteger countForFetchRequest = [managedObjectContext countForFetchRequest:fetchRequest error:&error];
    if (countForFetchRequest) {
        NSArray *fetchedObjects=[managedObjectContext executeFetchRequest:fetchRequest error:&error];
        for (LicenseRenewalEntity *licenseRenewal in fetchedObjects) {
            [managedObjectContext deleteObject:licenseRenewal];
            
        }
        
        
    }
    

    
    
    
    
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

-(void)tableViewModel:(SCTableViewModel *)tableModel willDisplayCell:(SCTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    if (tableModel.tag==1&&cell.tag==6&&[cell isKindOfClass:[SCObjectSelectionCell class]]) {
        
        SCObjectSelectionCell *objectSelectionCell=(SCObjectSelectionCell *)cell;
        
        if (![objectSelectionCell.selectedItemIndex isEqualToNumber:[NSNumber numberWithInt:-1]]) {
            
       
            LicenseRenewalEntity *renewalObject=(LicenseRenewalEntity *)[objectSelectionCell.items objectAtIndex:[objectSelectionCell.selectedItemIndex intValue]];
            
            NSString *licenseName=[renewalObject valueForKeyPath:@"license.licenseName.title"];
            
            NSString *displayText=[NSString stringWithFormat:@"%@ %@",licenseName,[dateFormatter stringFromDate:renewalObject.renewalDate]];
            
            objectSelectionCell.label.text=displayText;
            
        }
    }

    if (tableModel.tag==2&&tableModel.sectionCount) {
        
        NSManagedObject *cellManagedObject=(NSManagedObject *)cell.boundObject;
        
        if (cellManagedObject &&[cellManagedObject isKindOfClass:[LicenseRenewalEntity class]]) {
            
           
            
                LicenseRenewalEntity *renewalObject=(LicenseRenewalEntity *)cellManagedObject;
            
            NSString *licenseName=[renewalObject valueForKeyPath:@"license.licenseName.title"];
            
            NSString *displayText=[NSString stringWithFormat:@"%@ %@",licenseName,[dateFormatter stringFromDate:renewalObject.renewalDate]];
            
            cell.textLabel.text=displayText;
                
        }
    }



}



@end