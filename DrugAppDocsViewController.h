//
//  DrugAppDocsViewController.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 1/5/12.
//  Copyright (c) 2012 PsycheWeb LLC. All rights reserved.
//
//
#import "SCTableViewModel.h"

@interface DrugAppDocsViewController : UITableViewController <SCTableViewModelDataSource, SCTableViewModelDelegate>{
    
    
    SCArrayOfObjectsModel *tableModel;
    
    
}

@property (nonatomic,strong) IBOutlet NSString *applNoString;

@property (nonatomic,strong) IBOutlet NSString *inDocSeqNoString;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil applNoString:(NSString *)applNo inDocSeqNo:(NSString *)inDocSeqNo;
@end
