//
//  DrugAppDocsViewController.m
//  psyTrainTrack
//
//  Created by Daniel Boice on 1/5/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//



#import "DrugAppDocsViewController.h"
#import "PTTAppDelegate.h"


@implementation DrugAppDocsViewController

@synthesize applNoString, inDocSeqNoString;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil applNoString:(NSString *)applNo inDocSeqNo:(NSString *)inDocSeqNo{


        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
        if (self) {
            
            
            
            applNoString=applNo;
            inDocSeqNoString=inDocSeqNo;
            
            // Custom initialization
        }
        return self;


}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Gracefully handle reloading the view controller after a memory warning
    tableModel = (SCArrayOfObjectsModel *)[[SCModelCenter sharedModelCenter] modelForViewController:self];
    if(tableModel)
    {
        [tableModel replaceModeledTableViewWith:self.tableView];
        return;
    }
    
	
    // Set up the edit and add buttons.
    
    //    
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
    //    [self editButtonItem];
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
    //    
    
	self.tableView.backgroundColor=[UIColor clearColor];
    
    NSManagedObjectContext *drugsManagedObjectContext=(NSManagedObjectContext *)[(PTTAppDelegate *)[UIApplication sharedApplication].delegate drugsManagedObjectContext];
    
    
   
    
    NSPredicate *applNoPredicate=[NSPredicate predicateWithFormat:@"applNo matches %@ AND seqNo matches %@",applNoString, inDocSeqNoString];
    
        
    
    
    SCClassDefinition *appDocDef=[SCClassDefinition definitionWithEntityName:@"DrugAppDocEntity" withManagedObjectContext:drugsManagedObjectContext withPropertyNames:[NSArray arrayWithObjects:@"applNo", @"seqNo",@"docType",@"docDate",   nil]];
    
    
    
    appDocDef.keyPropertyName=@"docDate";
    
    // Instantiate the tabel model
	tableModel = [[SCArrayOfObjectsModel alloc] initWithTableView:self.tableView withViewController:self];	
    
    
    SCArrayOfObjectsSection *section=[SCArrayOfObjectsSection sectionWithHeaderTitle:@"Action Documents" withEntityClassDefinition:appDocDef usingPredicate:applNoPredicate];
    
    section.allowDeletingItems=FALSE;
    section.allowEditDetailView=FALSE;
    section.allowMovingItems=FALSE;
    section.allowAddingItems=FALSE;
    
    section.sortItemsSetAscending=FALSE;
    [tableModel addSection:section];
    
    //  	tableModel.searchPropertyName = @"drugName;activeIngredient";
    //    
    //    
    //    self.tableModel.allowMovingItems=TRUE;
    //    
    //    self.tableModel.autoAssignDelegateForDetailModels=TRUE;
    //    self.tableModel.autoAssignDataSourceForDetailModels=TRUE;
    //    
    //    self.tableModel.delegate=self;
    //    // Initialize tableModel
    //    
    //    //	
    //    
    //    // Initialize tableModel
    //    if (isInDetailSubview) {
    //        
    //        
    //        
    //        NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:2];
    //        
    //        
    //        UIBarButtonItem *doneButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonTapped)];
    //        [buttons addObject:doneButton];
    //        
    //        // create a spacer
    //        UIBarButtonItem* editButton = [[UIBarButtonItem alloc]
    //                                       initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:nil action:nil];
    //        [buttons addObject:editButton];
    //        
    //        [self editButtonItem];
    //        
    //        
    //        // create a standard "add" button
    //        UIBarButtonItem* addButton = [[UIBarButtonItem alloc]
    //                                      initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:NULL];
    //        addButton.style = UIBarButtonItemStyleBordered;
    //        [buttons addObject:addButton];
    //        
    //        
    //        
    //        // stick the buttons in the toolbar
    //        self.navigationItem.rightBarButtonItems=buttons;
    //        self.tableModel.editButtonItem=[self.navigationItem.rightBarButtonItems objectAtIndex:1];
    //        self.tableModel.addButtonItem = [self.navigationItem.rightBarButtonItems objectAtIndex:2];
    //        
    //        UIBarButtonItem *cancelButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonTapped)];
    //        
    //        self.navigationItem.leftBarButtonItem=cancelButton;
    //        
    //        
    //    }
    //    else
    //    {
    //        if (self.navigationItem.rightBarButtonItems.count>1) {
    //            
    //            tableModel.addButtonItem = [self.navigationItem.rightBarButtonItems objectAtIndex:1];
    //        }
    //        
    //        
    //        
    //        if (self.navigationItem.rightBarButtonItems.count >0)
    //        {
    //            tableModel.editButtonItem=[self.navigationItem.rightBarButtonItems objectAtIndex:0];
    //        }
    //        
    //        
    //        
    //    }
    //    
    
    
    if([SCHelper is_iPad]){
        [self.tableView setBackgroundView:nil];
        [self.tableView setBackgroundView:[[UIView alloc] init]];
        [self.tableView setBackgroundColor:UIColor.clearColor]; // Make the table view transparent
    }
    
    
    //    [self updateClientsTotalLabel];
    
    //    [(PTTAppDelegate *)[UIApplication sharedApplication].delegate application:[UIApplication sharedApplication]
    //                                               willChangeStatusBarOrientation:[[UIApplication sharedApplication] statusBarOrientation]
    //                                                                     duration:5];
    //    
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    
    return YES;
    
}

#pragma mark -
#pragma mark SCTableViewModelDataSource methods

- (SCControlCell *)tableViewModel:(SCTableViewModel *)tableViewModel
	  customCellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
    
    // Create & return a custom cell based on the cell in ContactOverviewCell.xib
	
    
    
    NSDictionary *actionOverviewBindings = [NSDictionary 
                                            dictionaryWithObjects:[NSArray arrayWithObjects:@"docDate", @"docType", @"docType",@"docDate",@"WebViewDetailViewController",   nil] 
                                            forKeys:[NSArray arrayWithObjects:@"1", @"2", @"top",@"bottom",@"openNib",nil]]; // 1,2,3 are the control tags
	SCControlCell *actionOverviewCell = [SCControlCell cellWithText:nil withBoundObject:nil withObjectBindings:actionOverviewBindings
                                                        withNibName:@"DrugDocOverviewCell_iPhone"];
	
	return actionOverviewCell;
}



- (void)tableViewModel:(SCTableViewModel *)tableViewModel didAddSectionAtIndex:(NSInteger)index
{
    
    SCTableViewSection *section = [tableViewModel sectionAtIndex:index];
    
    
    
    if(section.headerTitle !=nil)
    {
        
        UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 60)];
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 300, 40)];
        
        
        headerLabel.backgroundColor = [UIColor clearColor];
        headerLabel.textColor = [UIColor whiteColor];
        headerLabel.text=section.headerTitle;
        [containerView addSubview:headerLabel];
        
        section.headerView = containerView;
        
        
        
    }
    
    
    
}


#pragma mark - SCTable view delegate

- (void)tableViewModel:(SCTableViewModel *)tableViewModel didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    //     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
    //     // ...
    //     // Pass the selected object to the new view controller.
    //     [self.navigationController pushViewController:detailViewController animated:YES];
    
}




@end
