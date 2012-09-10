//
//  ClientGroupsViewController.m
//  PsyTrack
//
//  Created by Daniel Boice on 6/13/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "ClientGroupsViewController.h"
#import "PTTAppDelegate.h"

@interface ClientGroupsViewController ()

@end

@implementation ClientGroupsViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    

     UINavigationItem *navigationItem=(UINavigationItem *)self.navigationItem;
    navigationItem.title=@"Client Groups";
    
    NSManagedObjectContext * managedObjectContext = [(PTTAppDelegate *)[UIApplication sharedApplication].delegate managedObjectContext];
    SCEntityDefinition *clientGroupDef=[SCEntityDefinition definitionWithEntityName:@"ClientGroupEntity" managedObjectContext:managedObjectContext propertyNamesString:@"Client Group:(groupName,addNewClients)"];
    
    
    clientGroupDef.titlePropertyName=@"groupName";
    clientGroupDef.keyPropertyName=@"groupName";
    
    objectsModel =[[SCArrayOfObjectsModel alloc]initWithTableView:self.tableView entityDefinition:clientGroupDef];
    
    [self setNavigationBarType: SCNavigationBarTypeAddEditRight];
    objectsModel.editButtonItem = self.editButton;;
    
    objectsModel.addButtonItem = self.addButton;
    
    
    
    self.view.backgroundColor=[UIColor clearColor];
    
    objectsModel.allowMovingItems=TRUE;
    
    objectsModel.autoAssignDelegateForDetailModels=TRUE;
    objectsModel.autoAssignDataSourceForDetailModels=TRUE;
    
    
    objectsModel.enablePullToRefresh = TRUE;
    objectsModel.pullToRefreshView.arrowImageView.image = [UIImage imageNamed:@"blueArrow.png"];
    
    
    
    if(![SCUtilities is_iPad]){
        
        objectsModel.theme=[SCTheme themeWithPath:@"./MapperTheme/mapper-iPhone.ptt"];
        
                
        
        
    }else {
        objectsModel.theme=[SCTheme themeWithPath:@"./MapperTheme/mapper-ipad-full.ptt"];
        
               
        
    }
    self.tableViewModel=objectsModel;
   
    
    
    // Initialize tableModel
//    NSString *detailThemeNameStr=nil;
    if ([SCUtilities is_iPad]) {
//        detailThemeNameStr=@"mapper-ipad-full.ppt";
        [self.tableView setBackgroundView:nil];
        [self.tableView setBackgroundView:[[UIView alloc] init]];
    }
    else {
        
        [self.tableView setBackgroundColor:[UIColor clearColor]];
//        detailThemeNameStr=@"mapper-phone.ptt";
    }
    
//    SCTheme *theme=[SCTheme themeWithPath:detailThemeNameStr];
//    objectsModel.theme=theme;
    
    
    
    
    self.view.backgroundColor=[UIColor clearColor];
    
    
    UIViewController *navtitle=self.navigationController.topViewController;
    
    navtitle.title=@"Client Groups";


    
    
    
    
    
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


-(void)tableViewModel:(SCTableViewModel *)tableModel detailViewWillPresentForRowAtIndexPath:(NSIndexPath *)indexPath withDetailTableViewModel:(SCTableViewModel *)detailTableViewModel{
    

    if ([SCUtilities is_iPad]) {
        PTTAppDelegate *appDelegate=(PTTAppDelegate *)[UIApplication sharedApplication].delegate;
        
        
        UIColor *backgroundColor=nil;
        
        if(indexPath.row==NSNotFound|| tableModel.tag>0)
        {
            
            backgroundColor=(UIColor *)appDelegate.window.backgroundColor;
            
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
}
- (void)tableViewModel:(SCTableViewModel *)tableViewModel didAddSectionAtIndex:(NSUInteger)index
{
    
    SCTableViewSection *section = [tableViewModel sectionAtIndex:index];
    
   if(section.headerTitle !=nil)
    {
        
 
            UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 60)];
            UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 300, 40)];
            
            
            headerLabel.backgroundColor = [UIColor clearColor];
            headerLabel.textColor = [UIColor whiteColor];
            headerLabel.tag=60;
            headerLabel.text=section.headerTitle;
            [containerView addSubview:headerLabel];
            
            section.headerView = containerView;
            
            
       

    }
}
@end
