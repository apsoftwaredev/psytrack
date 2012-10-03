//
//  DemographicReportTopCell.m
//  PsyTrack
//
//  Created by Daniel Boice on 9/16/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "DemographicReportTopCell.h"
#import "PTTAppDelegate.h"
#import "MyInformationAndTotalClients.h"
#import "DemographicSexCounts.h"
#import "DemographicSex.h"
#import "DemographicGenderCounts.h"
#import "GenderEntity.h"
#import "DemographicGenderCounts.h"

#import "EthnicityCombinationCount.h"
#import "EthnicityEntity.h"
#import "DemographicEthnicityCounts.h"
#import "RaceEntity.h"
#import "RaceCombinationCount.h"
#import "DemographicRaceCounts.h"

#import "DisabilityEntity.h"
#import "DisabilityCombinationCount.h"
#import "DemographicDisabilityCount.h"

#import "EducationLevelEntity.h"
#import "DemographicEducationCounts.h"

#import "DemographicSexualOrientation.h"
#import "DemographicSexualOrientationCounts.h"
#import "DemographicVariableAndCount.h"
#import "DemographicReportBottomCell.h"

@implementation DemographicReportTopCell

@synthesize sexObjectsModel=sexObjectsModel_;
@synthesize genderObjectsModel=genderObjectsModel_;
@synthesize ethnicitiesObjectsModel=ethnicitiesObjectsModel_;
@synthesize racesObjectsModel=racesObjectsModel_;

@synthesize disabilityObjectsModel=disabilityObjectsModel_;
@synthesize educationLevelObjectsModel=educationLevelObjectsModel_;
@synthesize sexualOrientationObjectsModel=sexualOrientationObjectsModel_;



@synthesize sexTableView;
@synthesize genderTableView;
@synthesize ethnicitiesTableView;
@synthesize racesTableView;

@synthesize disabilityTableView;
@synthesize educationTableView;
@synthesize sexualOrientationTableView;
@synthesize mainPageScrollView;

@synthesize clinicianNameLabel;
@synthesize tablesContainerView;

@synthesize totalClientsLabel;

static float const MAX_MAIN_SCROLLVIEW_HEIGHT=1110;

-(void)willDisplay{
    
    self.accessoryType=UITableViewCellAccessoryNone;
    
    
    
    //
    
    CGFloat sexTVHeight=[self sexTableViewContentSize].height;
    CGFloat genderTVHeight=[self genderTableViewContentSize].height;
    CGFloat ethnicityTVHeight=[self ethnicityTableViewContentSize].height;
    CGFloat raceTVHeight=[self raceTableViewContentSize].height;
    
    CGFloat disabilityTVHeight=[self disabilityTableViewContentSize].height;
    CGFloat educationLevelTVHeight=[self educationTableViewContentSize].height;
    CGFloat sexualOrientationTVHeight=[self sexualOrientationViewContentSize].height;
    
    
    CGFloat totalPaddingHeight=35.0;
    CGRect tablesContainerViewFrame=self.tablesContainerView.frame;
    
    tablesContainerViewFrame.size.height=sexTVHeight+genderTVHeight+ethnicityTVHeight+raceTVHeight+disabilityTVHeight+educationLevelTVHeight+sexualOrientationTVHeight+totalPaddingHeight+10.0;
    
    self.tablesContainerView.frame=tablesContainerViewFrame;
    
    CGRect sexTableViewFrame=self.sexTableView.frame;
    CGRect genderTableViewFrame=self.genderTableView.frame;
    CGRect ethnicityTableViewFrame=self.ethnicitiesTableView.frame;
    CGRect raceTableViewFrame=self.racesTableView.frame;
    CGRect disabilityTableViewFrame=self.disabilityTableView.frame;
    CGRect educationLevelTableViewFrame=self.educationTableView.frame;
    CGRect sexualOrientationTableViewFrame=self.sexualOrientationTableView.frame;
    
    CGFloat padding=5.0;
    
    sexTableViewFrame.size.height=sexTVHeight;
    genderTableViewFrame.origin.y=sexTableViewFrame.origin.y+sexTVHeight+padding;
    genderTableViewFrame.size.height=genderTVHeight;
    ethnicityTableViewFrame.origin.y=genderTableViewFrame.origin.y+genderTVHeight+padding;
    ethnicityTableViewFrame.size.height=ethnicityTVHeight;
    raceTableViewFrame.origin.y=ethnicityTableViewFrame.origin.y+ethnicityTVHeight+padding;
    raceTableViewFrame.size.height=raceTVHeight;
    disabilityTableViewFrame.origin.y=raceTableViewFrame.origin.y+raceTVHeight+padding;
    disabilityTableViewFrame.size.height=disabilityTVHeight;
    educationLevelTableViewFrame.origin.y=disabilityTableViewFrame.origin.y+disabilityTVHeight+padding;
    educationLevelTableViewFrame.size.height=educationLevelTVHeight;
    sexualOrientationTableViewFrame.origin.y=educationLevelTableViewFrame.origin.y+educationLevelTVHeight+padding;
    sexualOrientationTableViewFrame.size.height=sexualOrientationTVHeight;
    

    self.sexTableView.frame=sexTableViewFrame;
    self.genderTableView.frame=genderTableViewFrame;
    self.ethnicitiesTableView.frame=ethnicityTableViewFrame;
    self.racesTableView.frame=raceTableViewFrame;
    
    self.disabilityTableView.frame=disabilityTableViewFrame;
    self.educationTableView.frame=educationLevelTableViewFrame;
    self.sexualOrientationTableView.frame=sexualOrientationTableViewFrame;
    
    CGRect mainScrollViewFrame=self.mainPageScrollView.frame;
    
    mainScrollViewFrame.size.height=MAX_MAIN_SCROLLVIEW_HEIGHT;
    
    
    self.mainPageScrollView.frame=mainScrollViewFrame;
    @try {
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(scrollToNextPage)
         name:@"ScrollDemographicVCToNextPage"
         object:nil];
    }
    @catch (NSException *exception) {
        //do nothing
    }
    
}

-(void)scrollToNextPage{
    
    UIScrollView *mainScrollView=self.mainPageScrollView;
    
    
    
    
    
    if ((self.sexualOrientationTableView.frame.origin.y+self.sexualOrientationTableView.frame.size.height)<=(MAX_MAIN_SCROLLVIEW_HEIGHT+currentOffsetY)) {
        
        @try {
            [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ScrollDemographicVCToNextPage" object:nil];
            

        }
        @catch (NSException *exception) {
            //do nothing
        }
        
        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
        
        
        appDelegate.stopScrollingMonthlyPracticumLog=YES;
        currentOffsetY=0;
        
    } else {
        
         
        
            [self.mainPageScrollView setContentOffset:CGPointMake(0, mainScrollView.frame.size.height+currentOffsetY )];
            currentOffsetY=currentOffsetY+mainScrollView.frame.size.height;
        
        
        CGFloat paddAdditonalY=0;
        
        
        for (NSInteger i=0; i<self.tablesContainerView.subviews.count; i++) {
            UIView *subview =[self.tablesContainerView.subviews objectAtIndex:i];
            CGRect subviewFrame=subview.frame;
            if ((currentOffsetY+MAX_MAIN_SCROLLVIEW_HEIGHT )-subview.frame.origin.y+subview.frame.size.height<66.0
               ) {
                
                
                
                paddAdditonalY=(currentOffsetY+MAX_MAIN_SCROLLVIEW_HEIGHT)-(subviewFrame.origin.y+subview.frame.origin.y)+5;
                
                CGRect tableContainerViewFrame=self.tablesContainerView.frame;
                tableContainerViewFrame.size.height=tableContainerViewFrame.size.height+paddAdditonalY;
                self.tablesContainerView.transform=CGAffineTransformIdentity;
                self.tablesContainerView.frame=tableContainerViewFrame;
                
               
                subviewFrame.origin.y=subviewFrame.origin.y+paddAdditonalY;
                subview.transform=CGAffineTransformIdentity;
                subview.frame=subviewFrame;
                
                for (NSInteger p=i+1; p<self.tablesContainerView.subviews.count; p++) {
                    UIView *nextSubview=[self.tablesContainerView.subviews objectAtIndex:p];
                    
                    CGRect nextSubviewFrame=nextSubview.frame;
                    nextSubviewFrame.origin.y=nextSubviewFrame.origin.y+paddAdditonalY;
                    nextSubview.transform=CGAffineTransformIdentity;
                    nextSubview.frame=nextSubviewFrame;
                    paddAdditonalY=paddAdditonalY+nextSubviewFrame.origin.y+nextSubviewFrame.size.height;
                    
                    
                }
                
                
                
            }
            
            
        }}
        
      
    
}
-(void)loadBindingsIntoCustomControls{
    
    [super loadBindingsIntoCustomControls];
    
    MyInformationAndTotalClients *totalsObject=(MyInformationAndTotalClients *)self.boundObject;
    
    
   
    numberOfSupervisors=totalsObject.totalClients;
    
    
    NSString *bottomCellNibName=nil;
    
    
    
    bottomCellNibName=@"DemographicReportBottomCell";
   
    
   
    self.clinicianNameLabel.text=totalsObject.myName;
    
    self.totalClientsLabel.text=[NSString stringWithFormat:@"Total Clients: %i", totalsObject.totalClients ];
 
     SCClassDefinition *variableDef=[SCClassDefinition definitionWithClass:[DemographicVariableAndCount class] autoGeneratePropertyDefinitions:YES];
    
    self.sexObjectsModel=[[SCArrayOfObjectsModel alloc]initWithTableView:self.sexTableView];
    
    sexObjectsModel_.delegate=self;
   
    DemographicSexCounts *demographicSexCounts=[[DemographicSexCounts alloc]init];
    
    NSMutableArray *sexVariablesMutableArray=[NSMutableArray array];
    
    for (DemographicSex *demographicSex in demographicSexCounts.sexMutableArray ) {
        
        DemographicVariableAndCount *demVariableAndCountObject=[[DemographicVariableAndCount alloc]init];
        demVariableAndCountObject.variableStr=demographicSex.sex;
        demVariableAndCountObject.variableCountStr=[NSString stringWithFormat:@"%i", demographicSex.count ];
        
        [sexVariablesMutableArray addObject:demVariableAndCountObject];
    }
    
    SCArrayOfObjectsSection *sexSection=[SCArrayOfObjectsSection sectionWithHeaderTitle:nil items:sexVariablesMutableArray itemsDefinition:variableDef];
    
    
    [sexObjectsModel_ addSection:sexSection];
    
      
   
    self.genderObjectsModel=[[SCArrayOfObjectsModel alloc]initWithTableView:self.genderTableView];
    
    genderObjectsModel_.delegate=self;
    
    DemographicGenderCounts *demographicGenderCounts=[[DemographicGenderCounts alloc]init];
    
    NSMutableArray *genderVariablesMutableArray=[NSMutableArray array];
    
    for (GenderEntity *demographicGender in demographicGenderCounts.genderMutableArray ) {
        
        DemographicVariableAndCount *demVariableAndCountObject=[[DemographicVariableAndCount alloc]init];
        demVariableAndCountObject.variableStr=demographicGender.genderName;
        demVariableAndCountObject.variableCountStr=demographicGender.clientCountStr;
        
        [genderVariablesMutableArray addObject:demVariableAndCountObject];
    }
   
    if (demographicGenderCounts.notSelectedCountUInteger>0) {
         DemographicVariableAndCount *notSelectedGender=[[DemographicVariableAndCount alloc]init];
        notSelectedGender.variableCountStr=[ NSString stringWithFormat:@"%i", demographicGenderCounts.notSelectedCountUInteger ];
        notSelectedGender.variableStr=@"Not Selected";
        [genderVariablesMutableArray addObject:notSelectedGender];

    }
       
    SCArrayOfObjectsSection *genderSection=[SCArrayOfObjectsSection sectionWithHeaderTitle:nil items:genderVariablesMutableArray itemsDefinition:variableDef];
    
    
    [genderObjectsModel_ addSection:genderSection];
    
    
    
    
    self.ethnicitiesObjectsModel=[[SCArrayOfObjectsModel alloc]initWithTableView:self.ethnicitiesTableView];
    
    ethnicitiesObjectsModel_.delegate=self;
    
    DemographicEthnicityCounts *demographicEthnicityCounts=[[DemographicEthnicityCounts alloc]init];
    
    NSMutableArray *ethnicityVariablesMutableArray=[NSMutableArray array];
    
    for (EthnicityCombinationCount *ethnicityCombinationCount in demographicEthnicityCounts.ethnicityMutableArray ) {
        
        DemographicVariableAndCount *demVariableAndCountObject=[[DemographicVariableAndCount alloc]init];
        demVariableAndCountObject.variableStr=ethnicityCombinationCount.ethnicityCombinationStr;
        demVariableAndCountObject.variableCountStr=[NSString stringWithFormat:@"%i",ethnicityCombinationCount.ethnicityCombinationCount];
        
        [ethnicityVariablesMutableArray addObject:demVariableAndCountObject];
    }
    
    SCArrayOfObjectsSection *ethnicitySection=[SCArrayOfObjectsSection sectionWithHeaderTitle:nil items:ethnicityVariablesMutableArray itemsDefinition:variableDef];
    
    
    [ethnicitiesObjectsModel_ addSection:ethnicitySection];
    

    self.racesObjectsModel=[[SCArrayOfObjectsModel alloc]initWithTableView:self.racesTableView];
    
    racesObjectsModel_.delegate=self;
    
    DemographicRaceCounts *demographicRaceCounts=[[DemographicRaceCounts alloc]init];
    
    NSMutableArray *raceVariablesMutableArray=[NSMutableArray array];
    
    for (RaceCombinationCount *raceCombinationCount in demographicRaceCounts.raceMutableArray ) {
        DemographicVariableAndCount *demVariableAndCountObject=[[DemographicVariableAndCount alloc]init];
        demVariableAndCountObject.variableStr=raceCombinationCount.raceCombinationStr;
        demVariableAndCountObject.variableCountStr=[NSString stringWithFormat:@"%i",raceCombinationCount.raceCombinationCount];
        
        [raceVariablesMutableArray addObject:demVariableAndCountObject];
    }
    
    SCArrayOfObjectsSection *raceSection=[SCArrayOfObjectsSection sectionWithHeaderTitle:nil items:raceVariablesMutableArray itemsDefinition:variableDef];
    
    
    [racesObjectsModel_ addSection:raceSection];
    

    self.disabilityObjectsModel=[[SCArrayOfObjectsModel alloc]initWithTableView:self.disabilityTableView];
    
    disabilityObjectsModel_.delegate=self;
    
    DemographicDisabilityCount *demographicDisabilityCounts=[[DemographicDisabilityCount alloc]init];
    
    NSMutableArray *disabilityVariablesMutableArray=[NSMutableArray array];
    
    for (DisabilityCombinationCount *disabilityCombinationCount in demographicDisabilityCounts.disabilityMutableArray ) {
        
        DemographicVariableAndCount *demVariableAndCountObject=[[DemographicVariableAndCount alloc]init];
        demVariableAndCountObject.variableStr=disabilityCombinationCount.disabilityCombinationStr;
        demVariableAndCountObject.variableCountStr=[NSString stringWithFormat:@"%i",disabilityCombinationCount.disabilityCombinationCount];
        
        [disabilityVariablesMutableArray addObject:demVariableAndCountObject];
       
    }
    
    SCArrayOfObjectsSection *disabilitySection=[SCArrayOfObjectsSection sectionWithHeaderTitle:nil items:disabilityVariablesMutableArray itemsDefinition:variableDef];
    
    
    [disabilityObjectsModel_ addSection:disabilitySection];
    

    
    self.educationLevelObjectsModel=[[SCArrayOfObjectsModel alloc]initWithTableView:self.educationTableView];
    
    educationLevelObjectsModel_.delegate=self;
    
    DemographicEducationCounts *demographicEducationCounts=[[DemographicEducationCounts alloc]init];
    
    NSMutableArray *educationVariablesMutableArray=[NSMutableArray array];
    
    for (EducationLevelEntity *demographicEducation in demographicEducationCounts.educationMutableArray ) {
        
        DemographicVariableAndCount *demVariableAndCountObject=[[DemographicVariableAndCount alloc]init];
        demVariableAndCountObject.variableStr=demographicEducation.educationLevel;
        demVariableAndCountObject.variableCountStr=demographicEducation.clientCountStr;
        
        [educationVariablesMutableArray addObject:demVariableAndCountObject];
    }
    
    if (demographicEducationCounts.notSelectedCountUInteger>0) {
        DemographicVariableAndCount *notSelectedEducationLevel=[[DemographicVariableAndCount alloc]init];
        notSelectedEducationLevel.variableCountStr=[NSString stringWithFormat:@"%i", demographicEducationCounts.notSelectedCountUInteger ];
        notSelectedEducationLevel.variableStr=@"Not Selected";
        [educationVariablesMutableArray addObject:notSelectedEducationLevel];

    }
   
    SCArrayOfObjectsSection *educationSection=[SCArrayOfObjectsSection sectionWithHeaderTitle:nil items:educationVariablesMutableArray itemsDefinition:variableDef];
    
    
    [educationLevelObjectsModel_ addSection:educationSection];
    
    
    

    self.sexualOrientationObjectsModel=[[SCArrayOfObjectsModel alloc]initWithTableView:self.sexualOrientationTableView];
    
    sexualOrientationObjectsModel_.delegate=self;
    
    DemographicSexualOrientationCounts *demographicSexualOrientationCounts=[[DemographicSexualOrientationCounts alloc]init];
    
    NSMutableArray *sexualOrientationVariablesMutableArray=[NSMutableArray array];
    
    for (DemographicSexualOrientation *demographicSexualOrientation in demographicSexualOrientationCounts.sexualOrientationMutableArray ) {
        
        DemographicVariableAndCount *demVariableAndCountObject=[[DemographicVariableAndCount alloc]init];
        demVariableAndCountObject.variableStr=demographicSexualOrientation.sexualOrientation;
        demVariableAndCountObject.variableCountStr =[NSString stringWithFormat:@"%i",demographicSexualOrientation.count];
        
        [sexualOrientationVariablesMutableArray addObject:demVariableAndCountObject];
    }
    
    SCArrayOfObjectsSection *sexualOrientationSection=[SCArrayOfObjectsSection sectionWithHeaderTitle:nil items:sexualOrientationVariablesMutableArray itemsDefinition:variableDef];
    
    
    [sexualOrientationObjectsModel_ addSection:sexualOrientationSection];
    

    sexSection.sectionActions.cellForRowAtIndexPath = ^SCCustomCell*(SCArrayOfItemsSection *itemsSection, NSIndexPath *indexPath)
    {
        // Create & return a custom cell based on the cell in ContactOverviewCell.xib
        
        
        //            NSString *bindingsString = @"20:interventionSubType;21:self.monthToDisplay"; // 1,2,3 are the control tags
        
        NSDictionary *bindingsDictionary=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"variableStr",@"variableCountStr", nil] forKeys:[NSArray arrayWithObjects:@"20",@"21", nil]];
        
        DemographicReportBottomCell *demographicBottomCell = [DemographicReportBottomCell cellWithText:nil objectBindings:bindingsDictionary nibName:bottomCellNibName];
        
        
        return demographicBottomCell;
    };
   
    sexSection.sectionActions.cellForRowAtIndexPath = ^SCCustomCell*(SCArrayOfItemsSection *itemsSection, NSIndexPath *indexPath)
    {
        // Create & return a custom cell based on the cell in ContactOverviewCell.xib
        
        
        //            NSString *bindingsString = @"20:interventionSubType;21:self.monthToDisplay"; // 1,2,3 are the control tags
        
        NSDictionary *bindingsDictionary=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"variableStr",@"variableCountStr", nil] forKeys:[NSArray arrayWithObjects:@"20",@"21", nil]];
        
        DemographicReportBottomCell *demographicBottomCell = [DemographicReportBottomCell cellWithText:nil objectBindings:bindingsDictionary nibName:bottomCellNibName];
        
        
        return demographicBottomCell;
    };
    genderSection.sectionActions.cellForRowAtIndexPath = ^SCCustomCell*(SCArrayOfItemsSection *itemsSection, NSIndexPath *indexPath)
    {
        // Create & return a custom cell based on the cell in ContactOverviewCell.xib
        
        
        //            NSString *bindingsString = @"20:interventionSubType;21:self.monthToDisplay"; // 1,2,3 are the control tags
        
        NSDictionary *bindingsDictionary=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"variableStr",@"variableCountStr", nil] forKeys:[NSArray arrayWithObjects:@"20",@"21", nil]];
        
        DemographicReportBottomCell *demographicBottomCell = [DemographicReportBottomCell cellWithText:nil objectBindings:bindingsDictionary nibName:bottomCellNibName];
        
        
        return demographicBottomCell;
    };
    ethnicitySection.sectionActions.cellForRowAtIndexPath = ^SCCustomCell*(SCArrayOfItemsSection *itemsSection, NSIndexPath *indexPath)
    {
        // Create & return a custom cell based on the cell in ContactOverviewCell.xib
        
        
        //            NSString *bindingsString = @"20:interventionSubType;21:self.monthToDisplay"; // 1,2,3 are the control tags
        
        NSDictionary *bindingsDictionary=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"variableStr",@"variableCountStr", nil] forKeys:[NSArray arrayWithObjects:@"20",@"21", nil]];
        
        DemographicReportBottomCell *demographicBottomCell = [DemographicReportBottomCell cellWithText:nil objectBindings:bindingsDictionary nibName:bottomCellNibName];
        
        
        return demographicBottomCell;
    };
    raceSection.sectionActions.cellForRowAtIndexPath = ^SCCustomCell*(SCArrayOfItemsSection *itemsSection, NSIndexPath *indexPath)
    {
        // Create & return a custom cell based on the cell in ContactOverviewCell.xib
        
        
        //            NSString *bindingsString = @"20:interventionSubType;21:self.monthToDisplay"; // 1,2,3 are the control tags
        
        NSDictionary *bindingsDictionary=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"variableStr",@"variableCountStr", nil] forKeys:[NSArray arrayWithObjects:@"20",@"21", nil]];
        
        DemographicReportBottomCell *demographicBottomCell = [DemographicReportBottomCell cellWithText:nil objectBindings:bindingsDictionary nibName:bottomCellNibName];
        
        
        return demographicBottomCell;
    };
    disabilitySection.sectionActions.cellForRowAtIndexPath = ^SCCustomCell*(SCArrayOfItemsSection *itemsSection, NSIndexPath *indexPath)
    {
        // Create & return a custom cell based on the cell in ContactOverviewCell.xib
        
        
        //            NSString *bindingsString = @"20:interventionSubType;21:self.monthToDisplay"; // 1,2,3 are the control tags
        
        NSDictionary *bindingsDictionary=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"variableStr",@"variableCountStr", nil] forKeys:[NSArray arrayWithObjects:@"20",@"21", nil]];
        
        DemographicReportBottomCell *demographicBottomCell = [DemographicReportBottomCell cellWithText:nil objectBindings:bindingsDictionary nibName:bottomCellNibName];
        
        
        return demographicBottomCell;
    };
    educationSection.sectionActions.cellForRowAtIndexPath = ^SCCustomCell*(SCArrayOfItemsSection *itemsSection, NSIndexPath *indexPath)
    {
        // Create & return a custom cell based on the cell in ContactOverviewCell.xib
        
        
        //            NSString *bindingsString = @"20:interventionSubType;21:self.monthToDisplay"; // 1,2,3 are the control tags
        
        NSDictionary *bindingsDictionary=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"variableStr",@"variableCountStr", nil] forKeys:[NSArray arrayWithObjects:@"20",@"21", nil]];
        
        DemographicReportBottomCell *demographicBottomCell = [DemographicReportBottomCell cellWithText:nil objectBindings:bindingsDictionary nibName:bottomCellNibName];
        
        
        return demographicBottomCell;
    };

    sexualOrientationSection.sectionActions.cellForRowAtIndexPath = ^SCCustomCell*(SCArrayOfItemsSection *itemsSection, NSIndexPath *indexPath)
    {
        // Create & return a custom cell based on the cell in ContactOverviewCell.xib
        
        
        //            NSString *bindingsString = @"20:interventionSubType;21:self.monthToDisplay"; // 1,2,3 are the control tags
        
        NSDictionary *bindingsDictionary=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"variableStr",@"variableCountStr", nil] forKeys:[NSArray arrayWithObjects:@"20",@"21", nil]];
        
        DemographicReportBottomCell *demographicBottomCell = [DemographicReportBottomCell cellWithText:nil objectBindings:bindingsDictionary nibName:bottomCellNibName];
        
        
        return demographicBottomCell;
    };

    
    
    
}

- (CGSize)sexTableViewContentSize
{
    
    [self.sexTableView layoutIfNeeded];
    return [self.sexTableView contentSize];
}

- (CGSize)genderTableViewContentSize
{
    
    [self.genderTableView layoutIfNeeded];
    return [self.genderTableView contentSize];
}

- (CGSize)ethnicityTableViewContentSize
{
    
    [self.ethnicitiesTableView layoutIfNeeded];
    return [self.ethnicitiesTableView contentSize];
}
- (CGSize)raceTableViewContentSize
{
    
    [self.racesTableView layoutIfNeeded];
    return [self.racesTableView contentSize];
}

- (CGSize)disabilityTableViewContentSize
{
    
    [self.disabilityTableView layoutIfNeeded];
    return [self.disabilityTableView contentSize];
}


- (CGSize)educationTableViewContentSize
{
    
    [self.educationTableView layoutIfNeeded];
    return [self.educationTableView contentSize];
}
- (CGSize)sexualOrientationViewContentSize
{
    
    [self.sexualOrientationTableView layoutIfNeeded];
    return [self.sexualOrientationTableView contentSize];
}

@end
