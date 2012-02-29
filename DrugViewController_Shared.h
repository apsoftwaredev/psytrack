//
//  DrugViewController_Shared.h
//  psyTrainTrack
//
//  Created by Daniel Boice on 12/19/11.
//  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "SCTableViewModel.h"


@interface DrugViewController_Shared : NSObject <SCTableViewModelDelegate>{
    
    NSManagedObjectContext *drugsManagedObjectContext;
    
}

@property (strong,nonatomic)IBOutlet SCClassDefinition *drugDef;
@property (strong , nonatomic) IBOutlet NSArray *drugsArray;

-(id)setupTheDrugsViewModelUsingSTV;

@end