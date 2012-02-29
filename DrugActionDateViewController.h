//
//  DrugActionDateViewController.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 1/5/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//

#import "SCTableViewModel.h"


@interface DrugActionDateViewController : UITableViewController <SCTableViewModelDataSource, SCTableViewModelDelegate>{
    
    
    SCArrayOfItemsModel *tableModel;
    NSArray *_docTypesArray;
    NSMutableSet *actionDateMutableSet;
    
}

@property (nonatomic,strong) IBOutlet NSString *applNoString;
@property (nonatomic,strong) IBOutlet NSArray *docTypesArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil withApplNo:(NSString *)applNo;
@end
